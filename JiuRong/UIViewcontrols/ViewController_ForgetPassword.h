//
//  ViewController_ForgetPassword.h
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRUserCenterBaseController.h"
@interface ViewController_ForgetPassword : JRUserCenterBaseController

- (IBAction)ClickBtnNext:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textfilePhone;
@property (weak, nonatomic) IBOutlet UITextField *textfileAuthcode;
@property (weak, nonatomic) IBOutlet UIButton *btnAuthcode;
- (IBAction)ClickBtnAuthcode:(id)sender;
- (IBAction)HideKeyboard:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@end
