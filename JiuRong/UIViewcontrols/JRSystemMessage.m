//
//  JRSystemMessage.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRSystemMessage.h"

@implementation JRSystemMessage

- (void)awakeFromNib {
    // Initialization code
    self.notiImage.clipsToBounds = YES;
    self.notiImage.layer.cornerRadius = self.notiImage.bounds.size.height/2.0;
     self.notiImage.backgroundColor = [UIColor redColor];
}
- (void)setMessage:(JRCompanyMessageModel *)message
{
    _message = message;
    self.systemMessageTitle.text = _message.title;
    self.systemMessageTime.text = _message.time;
    [self updateMessageStatus:_message.read_status];
}
- (void)updateMessageStatus:(NSString *)read_status
{
    if ([read_status isEqualToString:@"已读"]) {
        self.notiImage.hidden = YES;
    }
    else
    {
        self.notiImage.hidden = NO;
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
