//
//  YQNavCV.m
//  1556-1026-刘仰清
//
//  Created by qianfeng on 15/12/16.
//  Copyright (c) 2015年 LYQ. All rights reserved.
//

#import "YQNavCV.h"
#import "RGBColor.h"
@interface YQNavCV ()

@end

@implementation YQNavCV

- (void)viewDidLoad {
    [super viewDidLoad];

//    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[RGBColor colorWithHexString:@"#FFFFFF"],NSFontAttributeName:[UIFont systemFontOfSize:17.0f]};
//    self.navigationBar.translucent = NO;
     [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
//    self.navigationBar.backgroundColor = [UIColor clearColor];//背景颜色
//    [[UINavigationBar appearance]setBarStyle:UIBarStyleBlackOpaque];
    self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
//    [self.navigationBar.superview addSubview:self.navBgView];
//    self.navigationBar.tintColor = [UIColor redColor];//字体颜色
    self.navigationBar.barTintColor = RGBCOLOR(27, 138, 238);//导航栏的镂空颜色
//    self.navigationBarHidden = YES;
   

   
}
- (UIView *)navBgView
{
    if (!_navBgView) {
        _navBgView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 20)];
//        _navBgView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"adpay-play-bg@2x.png"]];
        _navBgView.backgroundColor = [UIColor orangeColor];
//        _navBgView.tintColor = [UIColor whiteColor];
    }
    return _navBgView;
}

-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
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
