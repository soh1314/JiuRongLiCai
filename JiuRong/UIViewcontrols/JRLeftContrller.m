//
//  JRLeftContrller.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/8.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRLeftContrller.h"
#import "AppDelegate.h"
#import "JRHelpController.h"
#import "UserCenterConstant.h"
#import "Masonry.h"
#import "UserInfo.h"
#import "JiuRongConfig.h"
#import "JRHelpCenterStyleNCell.h"
#define UserCenterRatio 0.8
@interface JRLeftContrller ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain) UITableView * tableView;
@property (nonatomic,strong)UIView * avatarView;
@property (nonatomic,strong)UIImageView * avatarImage;
@property (nonatomic,strong)UILabel * userName;
@property (nonatomic,strong)UIButton * userStatusBtn;
@property (nonatomic,assign)NSInteger userStatus;
@property (nonatomic,strong)UILabel * statusLabel;
@end

@implementation JRLeftContrller

- (void)viewDidLoad {
    [super viewDidLoad];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    [self.view addSubview:self.tableView];

}
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadUserInfo];
}

- (void)loadUserInfo
{
    [UserInfo GetUserInfo].certifyinfo.depositstatus == 1 ? self.userStatus = 1 : (self.userStatus = 0);
    if (self.userStatus == 1) {
        self.statusLabel.hidden = YES;
        [self.userStatusBtn setTitle:@"个人资料 >" forState:UIControlStateNormal];
        self.userName.text = [UserInfo GetUserInfo].certifyinfo.name;
    }
    else
    {
        self.statusLabel.hidden = NO;
        [self.userStatusBtn setTitle:@"用户开户 >" forState:UIControlStateNormal];
        self.userName.text = [UserInfo GetUserInfo].user;
        
    }
}

- (void)pushController:(id)sender
{
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil] ;
    UIViewController * vc = [story instantiateViewControllerWithIdentifier:@"pushIndentity"];
    DDMenuController *ddmenu=(DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menu;
    [ddmenu showRootController:NO];
    UITabBarController * tab = (UITabBarController *)ddmenu.rootViewController;
    [tab.viewControllers[tab.selectedIndex] pushViewController:vc animated:NO];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, UserCenterRatio*KScreenW, KScreenH)];
        _tableView.tableHeaderView = self.avatarView;
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc]init];
        [_tableView registerNib:[UINib nibWithNibName:@"JRHelpCenterStyleNCell" bundle:nil] forCellReuseIdentifier:@"JRHelpCenterStyleNCellID"];
    }
    return _tableView;
}
- (UIView *)avatarView
{
    if (!_avatarView) {
        _avatarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, UserCenterRatio*KScreenW, 200)];
        [_avatarView addSubview:self.avatarImage];
        [_avatarView addSubview:self.userName];
        [_avatarView addSubview:self.userStatusBtn];
        [_avatarView addSubview:self.statusLabel];
        _avatarView.backgroundColor = [UIColor colorWithPatternImage:UserCenterBackGroundImage];
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(pushUserInfo:)];
        [_avatarView addGestureRecognizer:tap];
    }
    return _avatarView;
}
- (UIImageView *)avatarImage
{
    if (!_avatarImage) {
        _avatarImage = [[UIImageView alloc]initWithFrame:CGRectMake((UserCenterRatio*KScreenW)/2.0-75/2.0, self.avatarView.bounds.size.height-145, 75, 75)];
        _avatarImage.image = [UIImage imageNamed:@"icon_me@2x"];
        _avatarImage.userInteractionEnabled = YES;
    }
    return _avatarImage;
}
- (void)pushUserInfo:(UIGestureRecognizer *)gest
{
    [self DDMenuPush:@"pushBaseInfo"];

}
- (void)DDMenuPush:(NSString *)indentyStr
{
    UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController * vc = [story instantiateViewControllerWithIdentifier:indentyStr];
    DDMenuController *ddmenu=(DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menu;
    [ddmenu showRootController:NO];
    UITabBarController * tab = (UITabBarController *)ddmenu.rootViewController;
    [tab.viewControllers[tab.selectedIndex] pushViewController:vc animated:NO];
}
- (UILabel *)statusLabel
{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(self.userStatusBtn.frame)+20, CGRectGetMaxY(self.userName.frame)+5, 5, 5)];
        _statusLabel.clipsToBounds = YES;
        _statusLabel.layer.cornerRadius = 2.5;
        _statusLabel.backgroundColor = [UIColor redColor];
        ;
    }
    return _statusLabel;
}
- (UILabel *)userName
{
    if (!_userName) {
        _userName = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.avatarImage.frame)+5, UserCenterRatio*KScreenW-20, 18)];
        _userName.textColor = [UIColor whiteColor];
        _userName.textAlignment = NSTextAlignmentCenter;
        _userName.font = [UIFont systemFontOfSize:14];
    }
    return _userName;
}
- (UIButton *)userStatusBtn
{
    if (!_userStatusBtn) {
        _userStatusBtn = [[UIButton alloc]initWithFrame:CGRectMake(UserCenterRatio*KScreenW/2.0-60, CGRectGetMaxY(self.userName.frame)+5, 120, 20)];
        _userStatusBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_userStatusBtn setTitleColor:RGBCOLOR(27, 138, 228) forState:UIControlStateNormal];
//         [_userStatusBtn setTitle:@"用户开户>" forState:UIControlStateNormal];
        [_userStatusBtn addTarget:self action:@selector(newAcount:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _userStatusBtn;
}
- (void)newAcount:(id)sender
{
    if (self.userStatus == 0) {
       [self DDMenuPush:@"newAccount"];
    }
    else
    {
        [self DDMenuPush:@"pushBaseInfo"];
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
////// tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRHelpCenterStyleNCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRHelpCenterStyleNCellID" forIndexPath:indexPath];
    cell.leftImage.image = [UIImage OriginalImageNamed:UserCenterLeftImage[indexPath.row]];
    cell.titleLabel.text = UserCenterSubTitle[indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    Class cls = NSClassFromString(UserCenterSubCtrl[indexPath.row]);
    UIViewController * vc = [[cls alloc]init];
    DDMenuController *ddmenu=(DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menu;
    [ddmenu showRootController:NO];
    UITabBarController * tab = (UITabBarController *)ddmenu.rootViewController;
    if (indexPath.row == 2) {
        [self DDMenuPush:@"ViewController_Setting"];
    }
    else if (indexPath.row == 1)
    {
        [self DDMenuPush:@"ViewController_BindBankCard"];
    }
    else
    {
    [tab.viewControllers[tab.selectedIndex] pushViewController:vc animated:NO];
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
