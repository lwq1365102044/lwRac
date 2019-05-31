//
//  HYBillListCellView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/25.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"

@interface HYBillListCellView : HYBaseView
+ (instancetype)creatBillListCellViewWithIsShowBtn:(BOOL)isShow;
@property (nonatomic, assign) BOOL isShow;
@property (nonatomic, strong) HYDefaultLabel * timeLable;
@property (nonatomic, strong) HYDefaultLabel * storeLable;
@property (nonatomic, strong) HYDefaultButton * leftSelectBtn;
@property (nonatomic, strong) NSArray * itemsDataArr;
@property (nonatomic, strong) UIView * itemsView;
@property (nonatomic, strong) HYBaseView * billInfor_Bg;
@property (nonatomic, strong) NSIndexPath * indexpath;


@end
