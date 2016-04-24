//
//  JRVerifyLoginPwdController.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/13.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRUserCenterBaseController.h"
@interface JRVerifyLoginPwdController : JRUserCenterBaseController
@property (weak, nonatomic) IBOutlet UITextField *pwdTtf;
- (IBAction)verifyLoginPwd:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *verifyBtn;
- (IBAction)cancel:(id)sender;

@end
