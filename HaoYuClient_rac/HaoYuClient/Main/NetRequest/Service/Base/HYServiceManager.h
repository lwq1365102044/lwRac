//
//  HYServiceManager.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/22.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseService.h"
@interface HYServiceManager : HYBaseService

/**
 有加载动画的请求
 */
- (void)postRequestAnWithurl:(NSString *)url
                   paramters:(NSDictionary *)paramters
                successBlock:(HYNetRequestSuccessBlock)successBlock
                failureBlock:(HYNetRequestFailureBlock)failBlock;

/**
 没有加载动画的请求
 */
- (void)postRequestWithurl:(NSString *)url
                 paramters:(NSDictionary *)paramters
              successBlock:(HYNetRequestSuccessBlock)successBlock
              failureBlock:(HYNetRequestFailureBlock)failBlock;

/**
 上传图片
 */
- (void)uploadImageWithurl:(NSString *)url
                  ImageArr:(NSArray *)imageArr
                  fileName:(NSArray *)fileName
                parameters:(NSDictionary *)parameters
                   Success:(HYNetRequestSuccessBlock)successBlock
                      fail:(HYNetRequestFailureBlock)failBlock;


/**
 上传图片  -- 单张
 */
- (void)uploadSingleImageWithurl:(NSString *)url
                           Image:(UIImage *)image
                        fileName:(NSString *)fileName
                      parameters:(NSDictionary *)parameters
                         Success:(HYNetRequestSuccessBlock)successBlock
                            fail:(HYNetRequestFailureBlock)failBlock;

/**
 上传图片  -- 单张 -- progress
 */
- (void)uploadSingleImageWithurl:(NSString *)url
                           Image:(UIImage *)image
                        fileName:(NSString *)fileName
                      parameters:(NSDictionary *)parameters
                   progressBlock:(HYEventCallBackBlock)progressBlock
                         Success:(HYNetRequestSuccessBlock)successBlock
                            fail:(HYNetRequestFailureBlock)failBlock;

/**
 有加载动画的请求
 */
- (void)postRequestAnWithurl:(NSString *)url
                   paramters:(NSDictionary *)paramters
                successBlock:(HYNetRequestSuccessBlock)successBlock;

/**
 没有加载动画的请求
 */
- (void)postRequestWithurl:(NSString *)url
                 paramters:(NSDictionary *)paramters
              successBlock:(HYNetRequestSuccessBlock)successBlock;

@end