//
//  MyIndicatorView.m
//  viewtest
//
//  Created by 刘仰清 on 16/3/8.
//  Copyright © 2016年 刘仰清. All rights reserved.
//

#import "MyIndicatorView.h"

@implementation MyIndicatorView
+ (void)showIndicatiorViewWith:(NSString *)word inView:(UIView *)containerView
{
   UIWindow * window = [UIApplication sharedApplication].keyWindow;
    float width = [word boundingRectWithSize:CGSizeMake(KScreenW, KScreenH) options:NSStringDrawingUsesLineFragmentOrigin attributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:16],NSFontAttributeName, nil] context:nil].size.width+40;
    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2.0-width/2.0, [UIScreen mainScreen].bounds.size.height - 100,width, 35)];
    label.backgroundColor = [UIColor blackColor];
    label.alpha = 0.5;
    label.text = word;
    label.clipsToBounds = YES;
    label.layer.cornerRadius = 17.5;
    label.textAlignment = UITextAlignmentCenter;
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:16];
    [window addSubview:label];
//    [window addSubview:label];
    [UIView animateWithDuration:2 animations:^{
        label.alpha = 0;
    } completion:^(BOOL finished) {
        [label removeFromSuperview];
    }];
}
@end
