//
//  HYAddBaoXiuViewController.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/1.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYAddBaoXiuViewController.h"
#import "HYAddBaoXiuMainView.h"
#import "LWHud.h"
#import "HYContractModel.h"
#import "HYWeiXiuQuYuModel.h"
#import "LWImagePicker.h"
@interface HYAddBaoXiuViewController ()<addPhotoDelegate>
@property (nonatomic, strong) HYAddBaoXiuMainView * MainView;
//key: image  value: url
@property (nonatomic, strong) NSMutableDictionary * selImageUrlDict;

@end

@implementation HYAddBaoXiuViewController

#pragma mark - First.通知

#pragma mark - Second.网络请求

/**
 维修区域
 */
- (void)requestWeiXiuQuYuInfor
{
    PARA_CREART;
    PARA_SET(@"0dc1fd1a-2991-4f43-8497-a144b644b3f0", @"mark");
    [[HYServiceManager share] postRequestAnWithurl:GET_MINEWEIXIUQUYUINFOR_URL
                                         paramters:para
                                      successBlock:^(id objc, id requestInfo) {
                                          LWLog(@"\n\n\nweixiuquyu:%@",objc);
                                          NSArray *dataArr = objc[@"result"][@"list"];
                                          NSMutableArray *temps = [[NSMutableArray alloc] init];
                                          for (NSDictionary *dict in dataArr) {
                                              HYWeiXiuQuYuModel *contractModel = [HYWeiXiuQuYuModel modelWithJSON:dict];
                                              [temps addObject:contractModel];
                                          }
                                          self.MainView.QuYuInfor = temps;
                                      } failureBlock:^(id error, id requestInfo) {
                                          
                                      }];
}

#pragma mark - Third.点击事件

#pragma mark - Fourth.代理方法
- (void)gotoChooseImages
{
    WEAKSELF(self);
    [[LWImagePicker share] imagePickerWithSourceVc:self allowsEditing:NO callBlock:^(id sender) {
        [weakself.MainView.addPhotoView chooseImages:@[(UIImage *)sender]];
        [self uploadImage:(UIImage *)sender];
    }];
}

/**
 删除图片
 */
- (void)deleImage:(UIImage *)image
{
    NSArray *allkey = self.selImageUrlDict.allKeys;
    if ([allkey containsObject:image]) {
        [self.selImageUrlDict removeObjectForKey:image];
    }
}

/**
 重新上传
 */
- (void)reUploadImage:(UIImage *)image
{
    if(!image) return;
    [self uploadImage:image];
}

/**
 提交所有信息
 */
- (void)commitAllInfor:(NSDictionary *)para
{
    NSString *URL = GET_MINEAPPLYWEIXIUINFOR_URL;
    if ([self.title isEqualToString:@"申请保洁"]) {
        URL = GET_MINEAPPLYBAOJIEINFOR_URL;
    }else{
        if (self.selImageUrlDict.allValues.count > 0) {
            [para setValue:self.selImageUrlDict.allValues forKey:@"urls"];
        }
    }
    [[HYServiceManager share] postRequestWithurl:URL
                                       paramters:para
                                    successBlock:^(id objc, id requestInfo) {
                                        HYBaoXiuViewController *listvc =  self.navigationController.viewControllers[self.navigationController.viewControllers.count-2];
                                        [listvc requestListInfor];
                                        [self.navigationController popViewControllerAnimated:YES];
                                        [LWHud dismiss];
                                        ALERT(@"提交成功！");
                                    } failureBlock:^(id error, id requestInfo) {
                                        [LWHud dismiss];
                                    }];
}

/**
 上传图片
 */
- (void)uploadImage:(UIImage *)image
{
    [LWHud show];
    [[HYServiceManager share] uploadSingleImageWithurl:UPLOAD_MINEWEIXIU_IMAGE_URL
                                                 Image:image
                                              fileName:nil
                                            parameters:nil
                                               Success:^(id objc, id requestInfo) {
                                                   NSString *imgeurl = objc[@"url"];
                                                   if (imgeurl) {
                                                       [self.selImageUrlDict setObject:imgeurl forKey:(id)image];
                                                   }
                                                   NSMutableDictionary *tem = [[NSMutableDictionary alloc]init];
                                                   tem[@"result"] = @"1";
                                                   tem[@"image"] = image;
                                                   POST_NOTI(@"uploadresult_baoxiu", tem);
                                                   [LWHud dismiss];
                                               } fail:^(id error, id requestInfo) {
                                                   NSMutableDictionary *tem = [[NSMutableDictionary alloc]init];
                                                   tem[@"result"] = @"0";
                                                   tem[@"image"] = image;
                                                   POST_NOTI(@"uploadresult_baoxiu", tem);
                                                   [LWHud dismiss];
                                               }];
    
}

#pragma mark - Fifth.视图生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUI];
    if ([self.title isEqualToString:@"申请报修"]) {
        [self requestWeiXiuQuYuInfor];
    }
    WEAKSELF(self);
    self.MainView.commitBlock = ^(id sender) {
        if ([self.title isEqualToString:@"申请报修"] &&
             self.selImageUrlDict.allKeys.count == 0) {
            ALERT(@"请添加图片");
            return ;
        }
        [weakself commitAllInfor:sender];
    };
}

+ (instancetype)creatApplyWeiXiuViewController:(NSString *)titleStr
{
    HYAddBaoXiuViewController *addbaoxiu    = [[HYAddBaoXiuViewController alloc] init];
    addbaoxiu.title                         = [NSString stringWithFormat:@"申请%@",titleStr];
    return addbaoxiu;
}
#pragma mark - Sixth.界面配置
- (void)setUI
{
    [self.MainScrollView addSubview:self.MainView];
    [self.view addSubview:self.MainScrollView];
    [self.MainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.MainScrollView.mas_top);
        make.left.right.mas_equalTo(self.MainScrollView);
        make.bottom.mas_equalTo(self.MainScrollView).offset(-ADJUST_PERCENT_BOTTOM(5));
        make.width.mas_offset(SCREEN_WIDTH);
    }];
    [self.MainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.top.mas_equalTo(self.view);
        make.size.mas_offset(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT));
    }];
    self.MainView.addPhotoView.delegate = self;
    self.MainScrollView.backgroundColor = HYCOLOR.color_c1;
}
#pragma mark - Seventh.懒加载
- (HYAddBaoXiuMainView*)MainView
{
    if (!_MainView) {
        _MainView = [HYAddBaoXiuMainView creatAddBaoXiuMainView:self.title];
        _MainView.backgroundColor = HYCOLOR.color_c1;
    }
    return _MainView;
}

- (NSMutableDictionary*)selImageUrlDict
{
    if (!_selImageUrlDict) {
        _selImageUrlDict = [[NSMutableDictionary alloc] init];
    }
    return _selImageUrlDict;
}


@end
