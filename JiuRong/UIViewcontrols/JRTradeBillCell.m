//
//  JRTradeBillCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/22.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRTradeBillCell.h"

@implementation JRTradeBillCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _billStatusTag.clipsToBounds = YES;
    _billStatusTag.layer.cornerRadius = 12.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
