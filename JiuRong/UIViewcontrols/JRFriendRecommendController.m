//
//  JRFriendRecommendController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRFriendRecommendController.h"
#import "UserCenterConstant.h"
#import "UMSocial.h"
#import "UMSocialQQHandler.h"
#import "WXApi.h"
#import "JRFriendRecommendHeader.h"
@interface JRFriendRecommendController ()
@property (nonatomic,strong)JRFriendRecommendHeader * header;
@end

@implementation JRFriendRecommendController

- (void)viewDidLoad {
    [super viewDidLoad];
    _header = [JRFriendRecommendHeader header];
    _header.frame = CGRectMake(0, 0, KScreenW, KScreenH/2.0);
    [self.view addSubview:_header];
    // Do any additional setup after loading the view.
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
