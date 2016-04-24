//
//  ViewController_Upgrate.h
//  JiuRong
//
//  Created by iMac on 15/9/9.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRUserCenterBaseController.h"
@interface ViewController_Upgrate : JRUserCenterBaseController

@property (weak, nonatomic) IBOutlet UILabel *labelOld;
@property (weak, nonatomic) IBOutlet UILabel *labelNew;
@property (weak, nonatomic) IBOutlet UIView *viewIntroduction;
@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)ClickBtnUpgrate:(id)sender;
- (IBAction)ClickBtnCancel:(id)sender;
- (IBAction)seeChange:(id)sender;

@end
