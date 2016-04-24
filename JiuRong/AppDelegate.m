//
//  AppDelegate.m
//  JiuRong
//
//  Created by iMac on 15/9/1.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "AppDelegate.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "JRLeftContrller.h"
#import "JRGestureLockController.h"
#import "JiuRongConfig.h"
@interface AppDelegate ()

@end

@implementation AppDelegate
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [NSThread sleepForTimeInterval:2.0];
    [UMSocialData setAppKey:@"56e26631e0f55a1d43000fc4"];
    [UMSocialWechatHandler setWXAppId:@"wxb44cbe4535f3ee87" appSecret:@"f9e42d3c6115bd9304796932d08ce1db" url:@"http://www.9rjr.com"];
    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://open.weixin.qq.com/connect/oauth2/authorize?appid=wx47f15b5f37590046&redirect_uri=http%3A%2f%2fAPPIO.9RJR.COM%2FwechatAuthorize&response_type=code&scope=snsapi_base&state=aprilActive#wechat_redirect";
    [UMSocialQQHandler setQQWithAppId:@"1105246262" appKey:@"rmVPr0Unr2sGAQDR" url:@"http://www.9rjr.com"];
    _window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    _window.backgroundColor = [UIColor whiteColor];
    UIStoryboard * main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITabBarController * mainTab = [main instantiateViewControllerWithIdentifier:@"mainTab"];
    JRLeftContrller * VC = [[JRLeftContrller alloc]init];
//    UINavigationController * leftVCNav = [[UINavigationController alloc]initWithRootViewController:VC];
    self.menu = [[DDMenuController alloc]initWithRootViewController:mainTab];
    self.menu.leftViewController = VC;
     self.window.rootViewController = self.menu;
    [_window makeKeyAndVisible];
    [self AutoLogin];
    [self startNotifyNet];
    return YES;
}
- (void)AutoLogin
{
    AppInfo *info = [[JiuRongConfig ShareJiuRongConfig] GetAppInfo];
    if (info.username == nil)
    {
        return;
    }
    
    if (info.password == nil)
    {
        return;
    }
    if (info.autologin)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRLogin:info.username pwd:info.password success:^(NSInteger iStatus, NSString *userid, NSString *strErrorCode) {
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                [UserInfo GetUserInfo].uid = userid;
                [UserInfo GetUserInfo].isLogin = TRUE;
                [UserInfo GetUserInfo].user = info.username;
                [UserInfo GetUserInfo].password = info.password;
                [self GetCerfityInfo:userid];
            }            
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)GetCerfityInfo:(NSString*)uid
{
    [JiuRongHttp JRGetCertifyInfo:uid success:^(NSInteger iStatus, CertifyInfo *info, NSString *strErrorCode) {
        if (iStatus == 1)
        {
            [UserInfo GetUserInfo].certifyinfo = info;
        }
    } failure:^(NSError *error) {
        ;
    }];
}
- (void)startNotifyNet
{
    [GLobalRealReachability startNotifier];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(networkChange:) name:kRealReachabilityChangedNotification object:nil];
    
}
- (void)networkChange:(NSNotification *)noti
{
    RealReachability *reachability = (RealReachability *)noti.object;
    ReachabilityStatus status = [reachability currentReachabilityStatus];
    if (status == 0) {
        NSLog(@"请重连网络");
        [MyIndicatorView showIndicatiorViewWith:@"当前网络信号异常请稍后重试" inView:self.window];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    BOOL result = [UMSocialSnsService handleOpenURL:url];
    if (result == FALSE) {
        //调用其他SDK，例如支付宝SDK等
    }
    return result;
}
- (void)applicationDidEnterBackground:(UIApplication *)application {
    if ([UserInfo GetUserInfo].user) {
        NSUserDefaults * defaults = [NSUserDefaults standardUserDefaults];
        NSString * lockedPwd = [defaults objectForKey:@"lockedPwd"];
        if  (lockedPwd)
        {
        JRGestureLockController * locker = [[JRGestureLockController alloc]init];
        UIViewController * vc = self.window.rootViewController;
        locker.lockType = GestureUnlock;
        [vc presentViewController:locker animated:YES completion:nil];
        }
    }
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    [self AutoLogin];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
