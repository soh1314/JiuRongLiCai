//
//  JRGiftRecordCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRGiftRecordCell.h"

@implementation JRGiftRecordCell

- (void)awakeFromNib {
    // Initialization code
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}
- (void)initUI
{
    
}
- (void)setRecord:(JRGiftRecord *)record
{
    _record = record;
    if (_record) {
        self.giftTime.text = _record.timeStr;
        self.giftIdCoder.text = [NSString stringWithFormat:@"%ld",_record.code_num];
        self.activityGiftName.text = _record.treasure;
        self.investAmount.text = [NSString stringWithFormat:@"%.2lf",_record.invest_amount];

    }

    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
