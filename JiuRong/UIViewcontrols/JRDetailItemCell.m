//
//  JRDetailItemCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/28.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRDetailItemCell.h"

@implementation JRDetailItemCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setRecord:(JRGiftRecord *)record
{
    _record = record;
    self.userName.text = record.user_name;
    self.itemCode.text = [NSString stringWithFormat:@"%ld",record.code_num];
    self.giftName.text = [NSString stringWithFormat:@"%@",record.treasure];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
