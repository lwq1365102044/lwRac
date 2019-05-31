//
//  HYHouseRescourcesListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourcesListTableViewCell.h"
#import "HYHouseRescourcesCellView.h"
@interface HYHouseRescourcesListTableViewCell ()
@property (nonatomic, strong) HYHouseRescourcesCellView * cellView;
@end
@implementation HYHouseRescourcesListTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cellView = [[HYHouseRescourcesCellView alloc]init];
        [self.contentView addSubview:self.cellView];
        self.backgroundColor = HYCOLOR.color_c1;
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
        
        self.cellView.houseImage.image = IMAGENAME(@"11");
        self.cellView.priceLable.text = @"2000元/月起";
        self.cellView.houseSorteLable.text = @"北京市海淀区牡丹园店";
        self.cellView.numberLable.text = @"4个户型，105套房源";
        self.cellView.addressLable.text = @"北京市房山区长阳地铁站向南100米";
        
        [self.cellView bk_whenTapped:^{
            if (self.clickBlock) {
                self.clickBlock(self.indexPath);
            }
        }];
        [self.cellView.addressLable bk_whenTapped:^{
            ALERT_MSG(@"定位开发中...");
        }];
    }
    return self;
}

@end
