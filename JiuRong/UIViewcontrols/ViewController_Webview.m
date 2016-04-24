//
//  ViewController_Webview.m
//  JiuRong
//
//  Created by iMac on 15/12/10.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_Webview.h"
#import "Public.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "NJKWebViewProgress.h"
#import "NJKWebViewProgressView.h"
@interface ViewController_Webview ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (nonatomic,strong)NJKWebViewProgress * webViewProgress;
@property (nonatomic,strong)NJKWebViewProgressView * progressView;
@end

@implementation ViewController_Webview

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
//    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
//    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
//    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self.navigationItem setTitle:_webviewtitle];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_url]];
    UIWebView *webviewMain = [[UIWebView alloc] initWithFrame:self.view.bounds];
//    [webviewMain setScalesPageToFit:YES];
//    [webviewMain loadHTMLString:@"http://www.9rjr.com/front/wealthinfomation/newDetails?id=717" baseURL:nil];
//    webviewMain.delegate = self;
    _webViewProgress = [[NJKWebViewProgress alloc]init];
    webviewMain.delegate = _webViewProgress;
    _webViewProgress.webViewProxyDelegate = self;
    _webViewProgress.progressDelegate = self;
    [self initProgressBar];
    [webviewMain loadRequest:request];
    [self.view addSubview:webviewMain];
    
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:_progressView];
    self.tabBarController.tabBar.hidden = YES;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    // Remove progress view
    // because UINavigationBar is shared with other ViewControllers
    [_progressView removeFromSuperview];
   self.tabBarController.tabBar.hidden = NO;
}

- (void)initProgressBar
{
    CGFloat progressBarHeight = 4.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height, navigationBarBounds.size.width, progressBarHeight);
    _progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    _progressView.tintColor = [UIColor greenColor];
    _progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [_progressView setProgress:progress animated:YES];

    
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

@end
