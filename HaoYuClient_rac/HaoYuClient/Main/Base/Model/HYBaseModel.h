//
//  HYBaseModel.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/18.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYBaseModel : NSObject<YYModel>
@property (nonatomic, copy) NSString * customId;

@property (nonatomic, assign) CGFloat cellHeight;

@end
