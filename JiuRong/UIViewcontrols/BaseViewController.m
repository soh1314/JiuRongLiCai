//
//  ViewController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/25.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setJRNavBar];
    // Do any additional setup after loading the view.
}
- (void)setJRNavBar
{
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[Public GetBackImage] style:UIBarButtonItemStylePlain target:self action:@selector(ClickBtnLeft)];
    leftButtonItem.imageInsets = UIEdgeInsetsMake(0, -15, 0, 15);
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}
- (void)ClickBtnLeft
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
