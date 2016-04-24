//
//  JRUserMessageCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRUserMessageCell.h"

@implementation JRUserMessageCell

- (void)awakeFromNib {
    // Initialization code
    self.notiStatusImage.clipsToBounds = YES;
    self.notiStatusImage.layer.cornerRadius = self.notiStatusImage.bounds.size.height/2.0;
    self.notiStatusImage.backgroundColor = [UIColor redColor];
}
- (void)setModel:(JRSystemMessageItem *)model
{
    _model = model;
    self.word.text = model.content;
    [self updateMessageStatus:_model.read_status];
}
- (void)updateMessageStatus:(NSString *)read_status
{
    if ([read_status isEqualToString:@"已读"]) {
        self.notiStatusImage.hidden = YES;
    }
    else
    {
        self.notiStatusImage.hidden = NO;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
