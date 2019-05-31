//
//  HYBaseTextFiled.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/8.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "LWTFHandler.h"

@interface HYbasetextfiled :UITextField

@end

@interface HYBaseTextFiled : HYBaseView

@property (nonatomic, assign) NSInteger maxCount ;
@property (nonatomic, strong) UITextField * textFiled;
@property (nonatomic, strong) NSString * text;
- (void)setUI;
@property (nonatomic, copy) HYEventCallBackBlock  DidEndEditingBlock;

@end
