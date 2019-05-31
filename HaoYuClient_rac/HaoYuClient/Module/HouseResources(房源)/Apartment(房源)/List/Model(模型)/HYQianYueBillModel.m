//
//  HYQianYueBillModel.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/7/24.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYQianYueBillModel.h"

@implementation HYQianYueBillModel

-(NSString *)desc
{
    if ([_desc containsString:@"。"]) {
        return [_desc componentsSeparatedByString:@"。"].firstObject;
    }
    return _desc;
}

/**
 定金抵扣的描述
 */
- (NSString *)dingJinDikouDesc
{
    if (_desc) {
        if ([_desc containsString:@"。"]) {
            NSArray *arr = [_desc componentsSeparatedByString:@"。"];
            if (arr.count > 1) {
              return  arr[1];
            }
        }
    }
    return nil;
}

/**
// 优惠活动的描述
// */
//- (NSString *)discountDescTongJi{
//    if (_tongJi && [_tongJi isKindOfClass:[NSArray class]]) {
//        NSDictionary *dic = _tongJi.firstObject;
//        return dic[@"money"] ? dic[@"money"] : @"";
//    }
//    return @"";
//}

/**
 本地标题描述
 */
- (NSString *)titleDesc
{
    if (!_desc) {
        return @"";
    }
    if([_desc containsString:@"。"]){
        NSArray *arr = [_desc componentsSeparatedByString:@"。"];
        if (arr.count > 1) {
            if (_discountedPrice && ![_discountedPrice isEqualToString:@""]) {
                return [NSString stringWithFormat:@"%@ (优惠：%@元)",arr[0],_discountedPrice];
            }else{
                return arr[0];
            }
        }else{
            return _desc;
        }
    }else{
        if (_discountedPrice && ![_discountedPrice isEqualToString:@""]) {
            return [NSString stringWithFormat:@"%@ (优惠：%@元)",_desc,_discountedPrice];
        }else{
            return _desc;
        }
    }
}

@end
