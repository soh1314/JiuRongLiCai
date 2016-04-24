//
//  ViewController_Setting.h
//  JiuRong
//
//  Created by iMac on 15/10/20.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRUserCenterBaseController.h"
@interface ViewController_Setting : JRUserCenterBaseController <UIAlertViewDelegate>
- (IBAction)ClickBtnAbout:(id)sender;
- (IBAction)ClickBtnPhone:(id)sender;
- (IBAction)ClickBtnUpgrate:(id)sender;
- (IBAction)ClickBtnCompany:(id)sender;
- (IBAction)ClickBtnSafeInfo:(id)sender;

@end
