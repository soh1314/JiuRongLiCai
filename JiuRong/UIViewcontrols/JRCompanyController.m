//
//  JRCompanyController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/7.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRCompanyController.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
@interface JRCompanyController ()<UIWebViewDelegate,UMSocialUIDelegate>
@property (nonatomic,retain)UIWebView * webview;
@property (nonatomic,assign)BOOL loading;
@end

@implementation JRCompanyController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.loading = NO;
    self.webview = [[UIWebView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:self.webview];
    self.webview.scalesPageToFit = YES;
//
    self.webview.delegate = self;
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    self.webview.hidden = YES;
    [self setNavBar];
    _loading = NO;
    // Do any additional setup after loading the view.
}
- (void)shareCps:(id)sender
{
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
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    if (platformName == UMShareToQQ) {
        socialData.shareText = @"分享到QQ的文字内容";
    }
    else{
        socialData.shareText = @"分享到其他平台的文字内容";
    }
}
- (void)setNavBar
{
    //    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share-icon-nor@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(shareCps:)];
    //    self.navigationItem.rightBarButtonItem = right;
    UIBarButtonItem * back = [[UIBarButtonItem alloc]initWithImage:[Public GetBackImage] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    self.navigationItem.leftBarButtonItem = back;
} // Do any additional setup after loading the view.
- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    if (_loading == NO) {
//            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('xf_wylc_view_content')[0].style.webkitTextSizeAdjust = '100%'"];
//       
////        [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('xf_con_box')[0].style.zoom=0.8"];
//          [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('xf_wylc_view_content')[0].style.width = '80%'"];
//            [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByClassName('xf_con_box')[0].style.width = '80%'"];
        _loading = YES;
        self.webview.hidden = NO;
    }

    

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

@end
