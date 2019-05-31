//
//  HYContactUsView.h
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/11.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYBaseView.h"
#import "HYMapView.h"
@interface HYContactUsView : HYBaseView
@property (nonatomic, strong) HYMapView * mapView;
@property (nonatomic, strong) HYDefaultLabel * kefuPhoneLable;
@property (nonatomic, strong) HYDefaultLabel * addressLable;
/**
 设置定位 更新地图
 */
- (void)setMyLocationCoordinateWithlat:(double)lat lng:(double)lng;
@end
