//
//  JRHomeProjectHeader.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRHomeProjectHeader.h"

@implementation JRHomeProjectHeader

+ (instancetype)header
{
    JRHomeProjectHeader * header = [[[NSBundle mainBundle] loadNibNamed:@"JRHomeProjectHeader" owner:self options:nil] lastObject];
    header.line.clipsToBounds = YES;
    header.line.layer.cornerRadius = 2.5;
    return header;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
