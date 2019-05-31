//
//  HYContractListTableViewCell.m
//  HaoYuClient
//
//  Created by 刘文强 on 2018/5/30.
//  Copyright © 2018年 LWQ. All rights reserved.
//

#import "HYContractListTableViewCell.h"

@interface HYContractListTableViewCell()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *xuzuBtn;
@property (weak, nonatomic) IBOutlet UIButton *tuiZuBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusBtn;
@property (weak, nonatomic) IBOutlet UIImageView *houseImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *doorLable;
@property (weak, nonatomic) IBOutlet UILabel *fangzuPriceLable;
@property (weak, nonatomic) IBOutlet UILabel *tongHeLable;

@end

@implementation HYContractListTableViewCell

- (void)setContractModel:(HYContractModel *)contractModel
{
    _contractModel = contractModel;
    [self.houseImage sd_setImageWithURL:[NSURL URLWithString:HYIMAGEURLSTRING(HYProjectImageURLStringList, contractModel.roomTypePic[@"small"])] placeholderImage:IMAGENAME(@"占位图-200_200")];
    self.titleLable.text  = contractModel.houseItemName;
    self.doorLable.text = [NSString stringWithFormat:@"%@栋 %@室",contractModel.buildingNo,contractModel.houseNo];
    self.fangzuPriceLable.text = [NSString stringWithFormat:@"房租：%@/月",contractModel.iosDedicated];
    [self.statusBtn setTitle:contractModel.statusStr forState:UIControlStateNormal];
    
    self.tongHeLable.text = [NSString stringWithFormat:@"%@ | %@",contractModel.zukeName,[contractModel.isShared isEqualToString:@"1"] ? @"合租" : @"整租"];
//    2:3 续租
//    2 退租
    [self.xuzuBtn setTitleColor:HYCOLOR.color_c2 forState:UIControlStateNormal];
    [self.tuiZuBtn setTitleColor:HYCOLOR.color_c2 forState:UIControlStateNormal];
    self.xuzuBtn.userInteractionEnabled = NO;
    self.tuiZuBtn.userInteractionEnabled = NO;
    if ([contractModel.status integerValue] == 2 || [contractModel.status integerValue] == 3) {
        [self.xuzuBtn setTitleColor:HYCOLOR.color_c4 forState:UIControlStateNormal];
        self.xuzuBtn.userInteractionEnabled = YES;
        if ([contractModel.status integerValue] == 2 ) {
            [self.tuiZuBtn setTitleColor:HYCOLOR.color_c4 forState:UIControlStateNormal];
            self.tuiZuBtn.userInteractionEnabled = YES;
        }
    }
}

- (IBAction)ClickXuZuBtn:(id)sender {
    ALERT(@"开发中...");
}
- (IBAction)ClickTuiZuBtn:(id)sender {
    ALERT(@"开发中...");
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self = [[NSBundle mainBundle] loadNibNamed:@"HYContractListTableViewCell" owner:self options:nil].firstObject;
        self.backgroundColor = HYCOLOR.color_c1;
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.statusBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    /**
     放在 awakeFromNib 中会导致 bgview 的布局问题
     */
    [self setRation];
}

- (void)setRation
{
        UIBezierPath *maskPath                              = [UIBezierPath bezierPathWithRoundedRect:self.bgView.bounds
                                                                                    byRoundingCorners:UIRectCornerAllCorners
                                                                                          cornerRadii:CGSizeMake(10, 10)];
        CAShapeLayer *maskLayer                             = [[CAShapeLayer alloc]init];
        maskLayer.frame                                     = self.bgView.bounds;
        maskLayer.path                                      = maskPath.CGPath;
        self.bgView.layer.mask                              = maskLayer;
}

@end
