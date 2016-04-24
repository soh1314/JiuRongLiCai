//
//  JRUserPropertyCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/15.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRUserPropertyCell.h"

@implementation JRUserPropertyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    _recharge.clipsToBounds = YES;
    _recharge.layer.cornerRadius = 5;
    _getMoney.clipsToBounds = YES;
    _getMoney.layer.cornerRadius = 5;
    _bgView.backgroundColor = RGBCOLOR(27, 138, 238);
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)recharge:(id)sender {
    [self.delegate recharge];
}

- (IBAction)getMoney:(id)sender {
    [self.delegate getMoney];
}
@end
