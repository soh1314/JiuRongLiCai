//
//  JRUserCenterBaseController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/12.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRUserCenterBaseController.h"

@interface JRUserCenterBaseController ()

@end

@implementation JRUserCenterBaseController
- (id)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpNav];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated ];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)setUpNav
{
    UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithImage:[Public GetBackImage] style:UIBarButtonItemStyleDone target:self action:@selector(back:)];
    left.imageInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    self.navigationItem.leftBarButtonItem = left;
}
- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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
