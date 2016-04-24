//
//  JRRecomendFriendController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/12.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRRecomendFriendController.h"
#import "UserCenterConstant.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
@interface JRRecomendFriendController ()

@end

@implementation JRRecomendFriendController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推荐好友";
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)inviteFriend:(id)sender {
    NSMutableArray * shareArray = [NSMutableArray arrayWithArray:KShareUMArray];
    if (![QQApiInterface isQQInstalled]) {
        [shareArray removeObjectAtIndex:3];
        [shareArray removeObjectAtIndex:4];
    }
    if (![WXApi isWXAppInstalled]) {
        [shareArray removeObjectAtIndex:0];
        [shareArray removeObjectAtIndex:0];
        [shareArray removeObjectAtIndex:0];
    }
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"56e26631e0f55a1d43000fc4"
                                      shareText:@"测试分享"
                                     shareImage:[UIImage imageNamed:@"首页logo.png"]
                                shareToSnsNames:shareArray
                                       delegate:self];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://www.baidu.com";
}
- (IBAction)checkRule:(id)sender {
}
@end
