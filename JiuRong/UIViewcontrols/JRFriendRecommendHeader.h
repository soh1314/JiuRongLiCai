//
//  JRFriendRecommendHeader.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JRFriendRecommendHeader : UIView
@property (weak, nonatomic) IBOutlet UIImageView *introImg;
@property (weak, nonatomic) IBOutlet UIButton *inviteBtn;
- (IBAction)invite:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *inviteRule;
+ (instancetype)header;
@end
