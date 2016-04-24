//
//  ViewController_AccountBaseInfo.m
//  JiuRong
//
//  Created by iMac on 15/9/7.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_AccountBaseInfo.h"
#import "Public.h"
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "UserInfo.h"
#import "JiuRongConfig.h"

@interface ViewController_AccountBaseInfo ()

@end

@implementation ViewController_AccountBaseInfo

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    _btnLoginout.layer.cornerRadius = 5.0f;
    
    [self UpdateUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)ClickBtnLeft
{
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ClickBtnLoginOut:(id)sender
{
    UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:@"退出当前账号吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"退出",nil];
    [alter show];
}

- (IBAction)HideKeyboard:(id)sender {
}

- (void)UpdateUI
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetPersonBaseInfo:[UserInfo GetUserInfo].uid success:^(NSInteger iStatus, UserBaseInfo *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            _labelName.text = info.name;
            _labelCreditScore.text = [NSString stringWithFormat:@"%ld分",info.creditScore];
            _labelRegisterTime.text = info.registerTime;
            _labelScore.text = [NSString stringWithFormat:@"%ld分",info.score];
            _labelCreditValue.text = [NSString stringWithFormat:@"%ld元",info.creditValue];
            _labelSend.text = [NSString stringWithFormat:@"%ld",info.sendTimes];
            _labelRecv.text = [NSString stringWithFormat:@"%ld",info.recvTimes];
            _labelTrans.text = [NSString stringWithFormat:@"%ld",info.otherTimes];
            _nameLevel.text = info.creditName;
            _nameLevel.textColor = [UIColor redColor];
            _nameLevel.clipsToBounds = YES;
            _nameLevel.layer.cornerRadius = _nameLevel.bounds.size.width/2.0;
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [UserInfo GetUserInfo].isLogin = NO;
        
        AppInfo* info = [[JiuRongConfig ShareJiuRongConfig] GetAppInfo];
        [[JiuRongConfig ShareJiuRongConfig] SetUserInfo:info.username pwd:nil type:0 login:NO];
        
        self.tabBarController.selectedIndex = 0;
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
