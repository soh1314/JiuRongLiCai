//
//  JRRecomendFriendController.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/12.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserCenterConstant.h"
@interface JRRecomendFriendController : JRUserCenterBaseController
- (IBAction)inviteFriend:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *checkRule;
- (IBAction)checkRule:(id)sender;

@end
