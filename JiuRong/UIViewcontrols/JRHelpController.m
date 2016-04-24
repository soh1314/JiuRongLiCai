//
//  JRHelpController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/8.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRHelpController.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
@interface JRHelpController ()

@end

@implementation JRHelpController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton * bten = [[UIButton alloc]initWithFrame:CGRectMake(0, 100, 100, 100)];
    bten.backgroundColor = [UIColor redColor];
    [bten addTarget:self action:@selector(popView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bten];
    // Do any additional setup after loading the view.
}
- (void)popView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

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
