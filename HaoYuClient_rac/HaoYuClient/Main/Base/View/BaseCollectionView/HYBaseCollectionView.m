//
//  HYBaseCollectionView.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/23.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseCollectionView.h"

@implementation HYBaseCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        
        self.backgroundColor = HYCOLOR.color_c0;
        
    }
    return self;
}

@end