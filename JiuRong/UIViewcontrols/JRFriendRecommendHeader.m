//
//  JRFriendRecommendHeader.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRFriendRecommendHeader.h"

@implementation JRFriendRecommendHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)header
{
    JRFriendRecommendHeader * header = [[[NSBundle mainBundle]loadNibNamed:@"JRFriendRecommendHeader" owner:nil options:nil]lastObject];
    
    return header;
}
- (void)awakeFromNib
{
    _inviteBtn.clipsToBounds = YES;
    _inviteBtn.layer.cornerRadius = 5;
}

- (IBAction)invite:(id)sender {
    
}
@end
