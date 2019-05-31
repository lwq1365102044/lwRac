//
//  HYHouseRescourcesListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/10.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYHouseRescourcesListTableViewCell.h"
#import "HYHomePageModel.h"
@interface HYHouseRescourcesListTableViewCell ()

@end

@implementation HYHouseRescourcesListTableViewCell

- (void)setHouseRescourcesModel:(id)houseRescourcesModel
{
    if ([houseRescourcesModel isKindOfClass:[HYHouseRescourcesModel class]]) {
        HYHouseRescourcesModel *model = (HYHouseRescourcesModel *)houseRescourcesModel;
        [self.cellView.houseImage sd_setImageWithURL:[NSURL URLWithString:model.picObjcModel.big] placeholderImage:IMAGENAME(@"占位图-750_300")];
        self.cellView.priceLable.text = [NSString stringWithFormat:@"%@元/月起",model.iosDedicated];
        self.cellView.houseSorteLable.text = model.itemName;
        self.cellView.addressLable.text = model.houseItemAddress;
    }else if ([houseRescourcesModel isKindOfClass:[HYHomePageModel class]]){
        HYHomePageModel *model = (HYHomePageModel *)houseRescourcesModel;
        [self.cellView.houseImage sd_setImageWithURL:[NSURL URLWithString:model.picModel.big] placeholderImage:IMAGENAME(@"占位图-750_300")];
        NSString *priceDesc = [NSString stringWithFormat:@"%@元/月起",model.iosItemLowestprice];;
        if ([model.iosItemLowestprice doubleValue] == 0) {
            priceDesc = [NSString stringWithFormat:@"? 元/月起"];
        }
        self.cellView.priceLable.text = priceDesc;
        self.cellView.houseSorteLable.text = model.itemName;
        self.cellView.addressLable.text = model.itemAddress;
    }
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        self.cellView = [[HYHouseRescourcesCellView alloc]init];
        [self.contentView addSubview:self.cellView];
        self.backgroundColor = HYCOLOR.color_c1;
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.mas_equalTo(self.contentView);
            make.top.mas_equalTo(self.contentView.mas_top).mas_offset(ADJUST_PERCENT_FLOAT(10));
        }];
    }
    return self;
}

@end
