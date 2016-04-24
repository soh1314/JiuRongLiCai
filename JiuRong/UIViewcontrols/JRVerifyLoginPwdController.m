//
//  JRVerifyLoginPwdController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/13.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRVerifyLoginPwdController.h"
#import "JRGestureLockController.h"
#import "UserInfo.h"
@interface JRVerifyLoginPwdController ()<UITextViewDelegate>

@end

@implementation JRVerifyLoginPwdController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGBCOLOR(235, 235, 235);

    self.pwdTtf.delegate = self;
    self.verifyBtn.enabled = NO;
    
    // Do any additional setup after loading the view from its nib.
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSMutableString * temp = [[NSMutableString alloc]initWithString:self.pwdTtf.text];
    [temp replaceCharactersInRange:range withString:string];
    if ([temp isEqualToString:@""]) {
        self.verifyBtn.enabled = NO;
    }
    else
    {
         self.verifyBtn.enabled = YES;
    }
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)verifyLoginPwd:(id)sender {
    
    if ([self.pwdTtf.text isEqualToString:[UserInfo GetUserInfo].password]) {
        JRGestureLockController * vc = [[JRGestureLockController alloc]init];
        [self presentViewController:vc animated:YES completion:nil];
    }
    else
    {
        KAllert(@"密码错误");
    }

    
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
