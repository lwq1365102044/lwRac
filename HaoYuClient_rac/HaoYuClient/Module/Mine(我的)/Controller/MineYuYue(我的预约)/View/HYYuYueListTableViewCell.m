//
//  HYYuYueListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/6/5.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYYuYueListTableViewCell.h"
#import "HYYuYueListCellView.h"

@interface HYYuYueListTableViewCell()
@property (nonatomic, strong) HYYuYueListCellView * cellView;
@end

@implementation HYYuYueListTableViewCell

- (void)setDataDict:(NSDictionary *)dataDict
{
    _dataDict = dataDict;
    NSString *houseImage_url = dataDict[@"roomTypeJson"][@"pic"][@"small"];
    [_cellView.houseImage sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringMid, houseImage_url)] placeholderImage:IMAGENAME(@"占位图-240_160")];
    NSString *houseName = dataDict[@"roomTypeJson"][@"itemJson"][@"hiItemName"];
    _cellView.houseNameLable.text = houseName;
    _cellView.houseWhereLable.text = dataDict[@"roomTypeJson"][@"roomTypeName"];
    NSString *zujin = dataDict[@"roomTypeJson"][@"iosDedicated"];
    _cellView.houseLayoutLable.text = [NSString stringWithFormat:@"%@元/月",zujin];
    NSString *yudingshijian = dataDict[@"seeTime"];
    _cellView.yudingTimeLable.text = [NSString stringWithFormat:@"预约时间:%@",yudingshijian];
    NSString *address_city = dataDict[@"roomTypeJson"][@"itemJson"][@"hiCity"];
    NSString *address_deatil = dataDict[@"roomTypeJson"][@"itemJson"][@"hiDetailedAddress"];
    _cellView.dingweiLable.text = [NSString stringWithFormat:@"%@%@",address_city,address_deatil];
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.cellView = [[HYYuYueListCellView alloc]init];
        [self.contentView addSubview:self.cellView];
        self.cellView.backgroundColor = HYCOLOR.color_c1;
        [self.cellView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.bottom.mas_equalTo(self.contentView);
        }];
        [self.cellView setBtnArray:@[@"取消",@"去电"]];
        
        WEAKSELF(self);
        self.cellView.clickFuncBtnBlock = ^(id sender) {
            LWLog(@"点击了%@",sender);
            if (weakself.clickFuncBlock) {
                weakself.clickFuncBlock(weakself.indexPath,sender);
            }
        };
    }
    return self;
}

@end
