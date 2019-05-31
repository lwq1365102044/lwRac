
//
//  HYActivityTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/9.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYActivityTableViewCell.h"
#import "HYWaterSurfaceCellView.h"
@interface HYActivityTableViewCell ()
@property (nonatomic, strong) HYWaterSurfaceCellView * cellView;
@end

@implementation HYActivityTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cellView = [[HYWaterSurfaceCellView alloc]init];
        [self.contentView addSubview:self.cellView];
        self.cellView.backgroundColor = HYCOLOR.color_c1;
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self.contentView);
        }];
        
        self.cellView.houseNameLable.text = @"五一 冲冲送";
        self.cellView.houseWhereLable.text = @"5月1-5月7";
        self.cellView.houseLayoutLable.text = @"电费 冲100送10";
        self.cellView.houseWhereLable.font = SYSTEM_REGULARFONT(14);
        self.cellView.houseLayoutLable.font = SYSTEM_REGULARFONT(12);
        self.cellView.houseLayoutLable.textColor = HYCOLOR.color_c2;
        [self.cellView.houseLayoutLable mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.cellView.houseNameLable.mas_left);
            make.bottom.mas_equalTo(self.cellView.houseImage.mas_bottom);
        }];
       
        [self.cellView bk_whenTapped:^{
            if (self.clickBlock) {
                self.clickBlock(self.indexPath);
            }
        }];
        self.cellView.houseLayoutLable.userInteractionEnabled = YES;
        [self.cellView.houseLayoutLable bk_whenTapped:^{
            ALERT(@"定位开发中...");
        }];
    }
    return self;
}


@end
