//
//  JRMessageDetailController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/2.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRMessageDetailController.h"
#import "JRSystemMessageItem.h"
#import "UMSocial.h"
#import "JRCompanyMessageModel.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
@interface JRMessageDetailController ()<UMSocialUIDelegate>

@end

@implementation JRMessageDetailController
- (id)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"";
//        self.view.backgroundColor = RGBCOLOR(237, 237, 240);
        self.automaticallyAdjustsScrollViewInsets = YES;
    }
    return self;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self setUpNavBar];
    // Do any additional setup after loading the view from its nib.
}
- (void)setUpNavBar
{
//    UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"share-icon-nor@2x"] style:UIBarButtonItemStyleDone target:self action:@selector(shareCps:)];
//    self.navigationItem.rightBarButtonItem = right;
}
- (void)shareCps:(id)sender
{
    NSMutableArray * shareArray = [NSMutableArray arrayWithArray:KShareUMArray];
    if (![QQApiInterface isQQInstalled]) {
        [shareArray removeObjectAtIndex:3];
        [shareArray removeObjectAtIndex:3];
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
       [UMSocialData defaultData].extConfig.wechatSessionData.url = @"https://www.baidu.com";
    [UMSocialData defaultData].extConfig.qqData.url = @"https://www.baidu.com";
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
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refreshMessageStatus:nil];
}
- (void)refreshMessageStatus:(NSString *)entityId
{
    
    if ([self.title isEqualToString:@"官方公告"]) {
        JRCompanyMessageModel * model = self.messageArray[self.index];
        [JiuRongHttp JRGetCompanyMessageDetail:model.entityId curpage:1 success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
            JRSystemMessageItem * item = [[JRSystemMessageItem alloc]init];

            item.content = [info objectForKey:@"content"];
            item.title = [info objectForKey:@"title"];
            item.time = [info objectForKey:@"time"];
            [self reloadView:item];
        } failure:^(NSError *error) {
            
        }];
    }
    else
    {
    JRSystemMessageItem * model = self.messageArray[self.index];
    [JiuRongHttp JRNoteMessageRead:[UserInfo GetUserInfo].uid ids:model.entityId success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        
    } failure:^(NSError *error) {
        
    }];
    }

}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self reloadView:self.messageArray[self.index]];
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

- (IBAction)showNextMessage:(id)sender {
    if (self.index+1 < self.messageArray.count) {
        self.index = self.index+1;
         JRSystemMessageItem * model = self.messageArray[self.index];
        [self reloadView:model];
        [self refreshMessageStatus:nil];
    }
    else
    {
        [MyIndicatorView showIndicatiorViewWith:@"已经是最后一条" inView:self.view];
    }
   
    
}
- (void)reloadView:(JRSystemMessageItem *)model
{
    self.messageTitle.text = model.title;
    self.messageContent.text = model.content;
    self.messageTime.text = model.timeStr;
    NSData *data = [model.content dataUsingEncoding:NSUnicodeStringEncoding];
    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
    NSAttributedString *html = [[NSAttributedString alloc]initWithData:data
                                                                   options:options
                                                        documentAttributes:nil
                                                                    error:nil];
    self.messageContent.attributedText = html;

    
}
@end
