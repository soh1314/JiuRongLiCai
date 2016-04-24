//
//  ViewController_duobaoSuccess.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/25.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "ViewController_duobaoSuccess.h"

@interface ViewController_duobaoSuccess ()
@property (nonatomic,retain)UIButton * commitBtn;

@end

@implementation ViewController_duobaoSuccess
- (id)init
{
    if (self = [super init]) {
        self.title = @"夺宝成功";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavBar];
//    self.commitBtn = [UIButton alloc]initWithFrame:CGRectMake(100, , <#CGFloat width#>, <#CGFloat height#>)
}
- (void)setNavBar
{
    UIBarButtonItem * item = [[UIBarButtonItem alloc]initWithImage:[Public GetBackImage] style:UIBarButtonItemStyleDone target:self action:@selector(returnBack:)];
    self.navigationItem.leftBarButtonItem = item;
}
- (void)returnBack:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
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
