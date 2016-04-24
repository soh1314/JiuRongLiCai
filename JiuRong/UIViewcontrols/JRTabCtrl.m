//
//  YQTabCtrl.m
//  cuihuaxiaowo
//
//  Created by qianfeng on 15/12/22.
//  Copyright © 2015年 cuihuaxiaowo. All rights reserved.
//

#import "JRTabCtrl.h"
#import "YQNavCV.h"
#import "RGBColor.h"
#define KTabbarVCName @[@"JRFinderController",@"JRInvestController",@"JRUserController"]
#define KTabbarNum 3
@interface JRTabCtrl ()<UITabBarControllerDelegate>

@end

@implementation JRTabCtrl

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatViewCtrl];
    self.delegate = self;
}
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    NSInteger index = tabBarController.selectedIndex;
    if (index == 1||index == 2)
    {
        if ([UserInfo GetUserInfo].isLogin == NO)
        {
            tabBarController.selectedIndex = 0;
            UIViewController* pRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"loginroot"];
            [self presentModalViewController:pRoot animated:YES];
        }
    }
}
- (void)creatViewCtrl
{
    self.tabBar.backgroundColor = [UIColor redColor];
    self.tabBar.barStyle = UIBarStyleDefault;
    self.tabBar.tintColor = RGBCOLOR(27, 138, 238);
    self.tabBar.backgroundColor = [RGBColor colorWithHexString:@"#FFFFFF"];
    self.tabBar.translucent = NO;
    for (UIBarItem *item in self.tabBar.items) {
        [item setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIFont fontWithName:@"Helvetica" size:15.0], NSFontAttributeName, nil]
                            forState:UIControlStateNormal];
        
    }
    NSArray * viewArray = @[@"JRHomeRootController",@"JRInvestRootController",@"JRTreasureRootController"];
    NSArray * titleArray = @[@"发现",@"理财",@"财富"];
    NSArray * imageArray = @[@"RN_icon_today_normal@2x.png",@"RN_icon_fund_normal@2x.png",@"RN_icon_property_normal@2x.png"];
    NSArray * selectArray = @[@"RN_icon_today_active@2x.png",@"RN_icon_fund_active@2x.png",@"RN_icon_property_active@2x.png"];
    NSMutableArray * dataArray = [NSMutableArray array];
    for (int i = 0; i < KTabbarNum; i ++) {
        Class cls = NSClassFromString(viewArray[i]);
        UIViewController * vc = nil;
        if (i == 1 || i == 0 || i == 2 ) {
            vc = [[cls alloc]init];
        }
        else
        {
        vc = [self.storyboard instantiateViewControllerWithIdentifier:viewArray[i]];
        }
//           vc.title = titleArray[i];
        YQNavCV * nav = [[YQNavCV alloc]initWithRootViewController:vc];
        nav.title = titleArray[i];
        nav.tabBarItem.image = [UIImage OriginalImageNamed:imageArray[i]];
        nav.tabBarItem.imageInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        nav.tabBarItem.selectedImage = [UIImage OriginalImageNamed:selectArray[i]];
        [dataArray addObject:nav];
    }
    self.viewControllers = dataArray;
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
