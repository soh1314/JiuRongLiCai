//
//  JRGiftHeaderView.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRGiftHeaderView.h"

@implementation JRGiftHeaderView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (instancetype)creatJRGiftHeader
{
    return [[[NSBundle mainBundle]loadNibNamed:@"JRGiftHeaderView" owner:nil options:nil]firstObject];
}
- (void)awakeFromNib
{
    
}
@end
