//
//  JRPastGiftRecordCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRPastGiftRecordCell.h"
@implementation JRPastGiftRecordCell

- (void)awakeFromNib {
    // Initialization code
    self.detailBtn.clipsToBounds = YES;
    self.detailBtn.layer.cornerRadius = 5;
    self.hideDetail = YES;
    [self hideDetailView];
}
- (void)hideDetailView
{
    self.view_detail.hidden = YES;
    self.hideDetail = YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setRecord:(JRGiftRecord *)record
{
    _record = record;
//    self.lb_issueNo.text = _record.issueNo;
//    self.lb_issueGiftName.text = _record.giftName;
//    self.lb_issueCode.text = _record.code;
//    self.lb_userName.text = _record.luckUserName;
//    self.lb_issueTime.text = _record.issueTime;
}
- (IBAction)recordDetail:(id)sender {
    if (self.hideDetail) {
        self.view_detail.hidden = NO;
        self.hideDetail = NO;
        CGRect rect = self.frame;
        rect.size.height = 90;
        self.frame = rect;
        self.cellBlock(self);
    }
    else
    {
        self.view_detail.hidden = YES;
        self.hideDetail = YES;
        CGRect rect = self.frame;
        rect.size.height = 50;
        self.frame = rect;
        self.cellBlock(self);
    }
    
}
@end
