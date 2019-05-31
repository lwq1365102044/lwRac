//
//  WYScanManagerControl.m
//  WYIDCardOCR
//
//  Created by 汪年成 on 17/7/6.
//  Copyright © 2017年 之静之初. All rights reserved.
//

#import "WYScanManagerControl.h"

@implementation WYScanManagerControl

- (void)startSession {
    if (![self.captureSession isRunning]) {
        [self.captureSession startRunning];
    }
}

- (void)stopSession {
    if ([self.captureSession isRunning]) {
        [self.captureSession stopRunning];
    }
}

- (void)resetConfig {
    self.isInProcessing = NO;
    self.isHasResult = NO;
}

- (void)resetParams {
    self.isInProcessing = NO;
    self.isHasResult = NO;
    if ([self.captureSession canAddOutput:self.videoDataOutput]) {
        [self.captureSession addOutput:self.videoDataOutput];
        NSLog(@"captureSession addOutput");
    }
}

- (void)doSomethingWhenWillDisappear {
    if ([self.captureSession isRunning]) {
        [self stopSession];
        [self resetParams];
    }
}

- (void)doSomethingWhenWillAppear {
    if (![self.captureSession isRunning]) {
        [self startSession];
        [self resetParams];
    }
}


- (void)parseBankImageBuffer:(CVImageBufferRef)imageBuffer
{
    size_t width_t= CVPixelBufferGetWidth(imageBuffer);
    size_t height_t = CVPixelBufferGetHeight(imageBuffer);
    CVPlanarPixelBufferInfo_YCbCrBiPlanar *planar = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t offset = NSSwapBigIntToHost(planar->componentInfoY.offset);
    
    unsigned char* baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
    unsigned char* pixelAddress = baseAddress + offset;
    
    size_t cbCrOffset = NSSwapBigIntToHost(planar->componentInfoCbCr.offset);
    uint8_t *cbCrBuffer = baseAddress + cbCrOffset;
    
    CGSize size = CGSizeMake(width_t, height_t);
    CGRect effectRect = [WYRectManager getEffectImageRect:size];
    CGRect rect = [WYRectManager getGuideFrame:effectRect];
    
    int width = ceilf(width_t);
    int height = ceilf(height_t);
    
    unsigned char result [512];
    int resultLen = 0;
#if TARGET_IPHONE_SIMULATOR
    
#else
    resultLen = BankCardNV12(result, 512, pixelAddress, cbCrBuffer, width, height, rect.origin.x, rect.origin.y, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
#endif
    if(resultLen > 0) {
        
        // 播放一下“拍照”的声音，模拟拍照！！
        AudioServicesPlaySystemSound(1108);
        
        if ([self.captureSession isRunning]) {
            [self.captureSession stopRunning];
        }
        
        
        int charCount = [WYRectManager docode:result len:resultLen];
        if(charCount > 0) {
            
            //            CGRect subRect = [WYRectManager getCorpCardRect:width height:height guideRect:rect charCount:charCount];
            //            UIImage *image = [UIImage getImageStream:imageBuffer];
            //            __block UIImage *subImg = [UIImage getSubImage:subRect inImage:image];
            
            self.isHasResult = YES;
            char *numbers = [WYRectManager getNumbers];
            
            NSString *numberStr = [NSString stringWithCString:numbers encoding:NSASCIIStringEncoding];
            NSString *bank = [WYBankCardSearch getBankNameByBin:numbers count:charCount];
            
            WYScanResultModel *model = [WYScanResultModel new];
            
            model.bankNumber = numberStr;
            model.bankName = bank;
            
            
            
            CGSize size = CGSizeMake(width, height);
            CGRect effectRect = [WYRectManager getEffectImageRect:size];
            CGRect rect = [WYRectManager getGuideFrame:effectRect];
            UIImage *image = [UIImage getImageStream:imageBuffer];
            //UIImage *subImg = [UIImage getSubImage:rect inImage:image];
            /** edit by 郑键 2017年09月26日17:31:25 用于修复身份证图片被切割问题 */
            UIImage *subImg = image;
            
            
            model.bankImage = subImg;
            
            dispatch_async(dispatch_get_main_queue(), ^{
                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
                [self.bankScanSuccess sendNext:model];
            });
        }
    }
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    self.isInProcessing = NO;
}


- (void)parseIDCardImageBuffer:(CVImageBufferRef)imageBuffer {
    
    WYScanResultModel *idInfo = nil;
    
    size_t width= CVPixelBufferGetWidth(imageBuffer);
    size_t height = CVPixelBufferGetHeight(imageBuffer);
    
    CVPlanarPixelBufferInfo_YCbCrBiPlanar *planar = CVPixelBufferGetBaseAddress(imageBuffer);
    size_t offset = NSSwapBigIntToHost(planar->componentInfoY.offset);
    size_t rowBytes = NSSwapBigIntToHost(planar->componentInfoY.rowBytes);
    unsigned char* baseAddress = (unsigned char *)CVPixelBufferGetBaseAddress(imageBuffer);
    unsigned char* pixelAddress = baseAddress + offset;
    
    static unsigned char *buffer = NULL;
    if (buffer == NULL) {
        buffer = (unsigned char*)malloc(sizeof(unsigned char) * width * height);
    }
    memcpy(buffer, pixelAddress, sizeof(unsigned char) * width * height);
    
    unsigned char pResult[1024];
    
    int ret = 0;
#if TARGET_IPHONE_SIMULATOR
    
#else
    //调用第三方.a文件中的方法
    ret = EXCARDS_RecoIDCardData(buffer, (int)width, (int)height, (int)rowBytes, (int)8, (char*)pResult, sizeof(pResult));
#endif
    
    
    if (ret <= 0) {
        //        NSLog(@"ret=[%d]", ret);
    }
    else {
        //        NSLog(@"ret=[%d]", ret);
        
        
        char ctype;
        char content[256];
        int xlen;
        int i = 0;
        
        idInfo = [WYScanResultModel new];
        ctype = pResult[i++];
        idInfo.type = ctype;
        while(i < ret){
            ctype = pResult[i++];
            for(xlen = 0; i < ret; ++i){
                if(pResult[i] == ' ') { ++i; break; }
                content[xlen++] = pResult[i];
            }
            content[xlen] = 0;
            if(xlen) {
                NSStringEncoding gbkEncoding =CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
                if(ctype == 0x21)
                    idInfo.code = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                else if(ctype == 0x22)
                    idInfo.name = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                else if(ctype == 0x23)
                    idInfo.gender = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                else if(ctype == 0x24)
                    idInfo.nation = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                else if(ctype == 0x25)
                    idInfo.address = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                else if(ctype == 0x26)
                    idInfo.issue = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
                else if(ctype == 0x27)
                    idInfo.valid = [NSString stringWithCString:(char *)content encoding:gbkEncoding];
            }
        }
        
        static WYScanResultModel *lastIdInfo = nil;
        if (self.verify) {
            if (lastIdInfo == nil) {
                lastIdInfo = idInfo;
                idInfo = nil;
            }
            else{
                if (![lastIdInfo isEqual:idInfo]){
                    lastIdInfo = idInfo;
                    idInfo = nil;
                }
            }
        }
        if ([lastIdInfo isOK]) {
            //            NSLog(@"%@", [lastIdInfo toString]);
        } else {
            idInfo = nil;
        }
    }
    
    
    if (idInfo != nil) {
        
        // 播放一下“拍照”的声音，模拟拍照
        AudioServicesPlaySystemSound(1108);
        
        if ([self.captureSession isRunning]) {
            [self.captureSession stopRunning];
        }
        
        
        CGSize size = CGSizeMake(width, height);
        CGRect effectRect = [WYRectManager getEffectImageRect:size];
        CGRect rect = [WYRectManager getGuideFrame:effectRect];
        UIImage *image = [UIImage getImageStream:imageBuffer];
        /** edit by 郑键 2017年09月26日17:31:25 用于修复身份证图片被切割问题 */
//        UIImage *subImg = [UIImage getSubImage:rect inImage:image];
        UIImage *subImg = image;
        idInfo.idImage = subImg;
        dispatch_async(dispatch_get_main_queue(), ^{
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
            [self.idCardScanSuccess sendNext:idInfo];
        });
    }
    
    CVPixelBufferUnlockBaseAddress(imageBuffer, 0);
    self.isInProcessing = NO;
}


//选择前置和后置
- (BOOL)switchCameras {
    if (![self canSwitchCameras]) {
        return NO;
    }
    NSError *error;
    AVCaptureDevice *videoDevice = [self inactiveCamera];
    
    AVCaptureDeviceInput *videoInput =
    [AVCaptureDeviceInput deviceInputWithDevice:videoDevice error:&error];
    
    if (videoInput) {
        [self.captureSession beginConfiguration];
        
        [self.captureSession removeInput:self.activeVideoInput];
        
        if ([self.captureSession canAddInput:videoInput]) {
            [self.captureSession addInput:videoInput];
            self.activeVideoInput = videoInput;
        }
        else {
            [self.captureSession addInput:self.activeVideoInput];
        }
        
        [self.captureSession commitConfiguration];
    }
    else {
        [self.scanError sendNext:error];
        return NO;
    }
    return YES;
}

- (void)setFlashMode:(AVCaptureFlashMode)flashMode {
    AVCaptureDevice *device = [self activeCamera];
    
    if (device.flashMode != flashMode &&
        [device isFlashModeSupported:flashMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.flashMode = flashMode;
            [device unlockForConfiguration];
        }
        else {
            [self.scanError sendNext:error];
        }
    }
}

- (void)setTorchMode:(AVCaptureTorchMode)torchMode {
    AVCaptureDevice *device = [self activeCamera];
    
    if (device.torchMode != torchMode &&
        [device isTorchModeSupported:torchMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.torchMode = torchMode;
            [device unlockForConfiguration];
        }
        else {
            [self.scanError sendNext:error];
        }
    }
}

- (void)focusAtPoint:(CGPoint)point {
    AVCaptureDevice *device = [self activeCamera];
    
    if (device.isFocusPointOfInterestSupported &&
        [device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.focusPointOfInterest = point;
            device.focusMode = AVCaptureFocusModeAutoFocus;
            [device unlockForConfiguration];
        }
        else {
            [self.scanError sendNext:error];
        }
    }
}

static const NSString *THCameraAdjustingExposureContext;

- (void)exposeAtPoint:(CGPoint)point {
    AVCaptureDevice *device = [self activeCamera];
    
    AVCaptureExposureMode exposureMode =
    AVCaptureExposureModeContinuousAutoExposure;
    
    if (device.isExposurePointOfInterestSupported &&
        [device isExposureModeSupported:exposureMode]) {
        NSError *error;
        if ([device lockForConfiguration:&error]) {
            device.exposurePointOfInterest = point;
            device.exposureMode = exposureMode;
            
            if ([device isExposureModeSupported:AVCaptureExposureModeLocked]) {
                [device addObserver:self
                         forKeyPath:@"adjustingExposure"
                            options:NSKeyValueObservingOptionNew
                            context:&THCameraAdjustingExposureContext];
            }
            [device unlockForConfiguration];
        }
        else {
            [self.scanError sendNext:error];
        }
    }
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if (context == &THCameraAdjustingExposureContext) {
        AVCaptureDevice *device = (AVCaptureDevice *)object;
        
        if (!device.isAdjustingExposure &&
            [device isExposureModeSupported:AVCaptureExposureModeLocked]) {
            [object removeObserver:self
                        forKeyPath:@"adjustingExposure"
                           context:&THCameraAdjustingExposureContext];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                NSError *error;
                if ([device lockForConfiguration:&error]) {
                    device.exposureMode = AVCaptureExposureModeLocked;
                    [device unlockForConfiguration];
                } else {
                    [self.scanError sendNext:error];
                }
            });
        }
    }
    else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

//重置曝光
- (void)resetFocusAndExposureModes {
    AVCaptureDevice *device = [self activeCamera];
    
    AVCaptureExposureMode exposureMode =
    AVCaptureExposureModeContinuousAutoExposure;
    
    AVCaptureFocusMode focusMode = AVCaptureFocusModeContinuousAutoFocus;
    
    BOOL canResetFocus = [device isFocusPointOfInterestSupported] &&
    [device isFocusModeSupported:focusMode];
    
    BOOL canResetExposure = [device isExposurePointOfInterestSupported] &&
    [device isExposureModeSupported:exposureMode];
    
    CGPoint centerPoint = CGPointMake(0.5f, 0.5f);
    
    NSError *error;
    if ([device lockForConfiguration:&error]) {
        if (canResetFocus) {
            device.focusMode = focusMode;
            device.focusPointOfInterest = centerPoint;
        }
        
        if (canResetExposure) {
            device.exposureMode = exposureMode;
            device.exposurePointOfInterest = centerPoint;
        }
        
        [device unlockForConfiguration];
    } else {
        [self.scanError sendNext:error];
    }
}


@end
