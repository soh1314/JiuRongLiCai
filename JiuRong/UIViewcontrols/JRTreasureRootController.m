//
//  JRTreasureRootController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/15.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRTreasureRootController.h"
#import "JRHelpCenterStyleNCell.h"
#import "UserInfo.h"
#import "NSString+AttributedText.h"
#import "ViewController_UserAcitivityGift.h"
#import "JRUserAcitivityRecord.h"
#import "JRAccountMessage.h"
#import "JRSystemMessageItem.h"
#import "WZLBadgeImport.h"
#import "AppDelegate.h"
#import "JRUserPropertyCell.h"
#import "JRInvestRecordController.h"
@interface JRTreasureRootController ()<UITableViewDelegate,UITableViewDataSource,JRUserPropertyManage>
@property (nonatomic,retain)UITableView * tableView;
@property (nonatomic,copy)NSMutableString * totalMoney;
@property (nonatomic,copy)NSMutableString * totalIncome;
@property (nonatomic,copy)NSMutableString * totalRemain;
@property (nonatomic,copy)NSArray * titleArray;
@property (nonatomic,copy)NSArray * imageArray;
@property (nonatomic,copy)NSArray * vcIndetifyArray;
@end

@implementation JRTreasureRootController
- (id)init
{
    if (self = [super init]) {
        

    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _vcIndetifyArray = @[@"pushTList",@"CollectionViewController_PersonRecord",@"",@"certifyMember"];
    _totalMoney = [NSMutableString string];
    _totalIncome = [NSMutableString string];
    _totalRemain = [NSMutableString string];
    _titleArray = @[@"我的投资",@"交易记录",@"我的奖品",@"汇付认证"];
    self.automaticallyAdjustsScrollViewInsets = NO;
    _imageArray = @[@"acc_yaoqing@2x",@"acc_huikuan@2x",@"acc_p2p@2x",@"s_verify@2x"];
    [self.view addSubview:self.tableView];
//    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, -10, KScreenW, 20)];
//    [self.view addSubview:view];
//    view.backgroundColor = RGBCOLOR(17, 112, 237);
    self.view.backgroundColor = KGlobalColor;
//    [self setUpPullRefresh];
    [self SetupNavigation];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
        [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = RGBCOLOR(27, 138, 238);
        self.navigationController.navigationBar.shadowImage = [UIImage new];

    self.navigationItem.title = [UserInfo GetUserInfo].user;
    if ([UserInfo GetUserInfo].isLogin)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        dispatch_group_t group = dispatch_group_create();
        dispatch_group_async(group, dispatch_get_global_queue(0, 0), ^{
            [self loadMessageInfo];
             [self loadData];
        });
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
            [SVProgressHUD dismiss];
        });
    }
   
//    [self.tableView.header beginRefreshing];
    
}
- (void)SetupNavigation
{


    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"my_msg25x25@2x"] style:UIBarButtonItemStylePlain target:self action:@selector(ToCotroller_Message:)];
    rightButtonItem.imageInsets = UIEdgeInsetsMake(0, -5, -5,5);
    self.navigationItem.rightBarButtonItem = rightButtonItem;
}
- (void)ToCotroller_Message:(id)sender
{
    JRAccountMessage * message = [[JRAccountMessage alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}
- (void)setUpPullRefresh
{
    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadData];
        [self.tableView.header endRefreshing];
    }];
    self.tableView.header.backgroundColor = RGBCOLOR(27, 138, 238);
}
- (void)loadData
{
    [JiuRongHttp JRGetPersonData:[UserInfo GetUserInfo].uid success:^(NSInteger iStatus, NSInteger money1, NSString * money2, NSString * money3, NSString * money4, NSString *strErrorCode) {
        if (iStatus == 1)
        {
            _totalMoney = [NSMutableString stringWithFormat:@"%@",money2];
            _totalIncome = [NSMutableString stringWithFormat:@"%@",money3];
            _totalRemain = [NSMutableString stringWithFormat:@"%@",money4];
            [self.tableView reloadData];
        }
        else
        {
            KAllert(strErrorCode);
        }
    } failure:^(NSError *error) {
    }];

}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, -5, KScreenW, KScreenH-KTabbarH+5) style:UITableViewStyleGrouped];
        _tableView.delegate= self;
        _tableView.dataSource = self;
//        _tableView.bounces = NO;
//        _tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectZero];
//        _tableView.backgroundColor = RGBCOLOR(225, 225, 225);
        _tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
       
        [_tableView registerNib:[UINib nibWithNibName:@"JRUserPropertyCell" bundle:nil] forCellReuseIdentifier:@"JRUserPropertyCellID"];
        [_tableView registerNib:[UINib nibWithNibName:@"JRHelpCenterStyleNCell" bundle:nil] forCellReuseIdentifier:@"JRHelpCenterStyleNCellID"];
    }
    return _tableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
        JRUserPropertyCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRUserPropertyCellID" forIndexPath:indexPath];
        cell.delegate= self;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.totalIncome.text = KString(self.totalIncome);
        cell.remainMoney.text = KString(self.totalRemain);
        cell.waitIncome.text = KString(self.totalMoney);
                [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    }
    else
    {
        JRHelpCenterStyleNCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRHelpCenterStyleNCellID" forIndexPath:indexPath];
        cell.leftImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
        cell.titleLabel.text = self.titleArray[indexPath.row];
                [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    }

}
- (void)recharge
{
    UIViewController * vc = KStoryBoardVC(@"recharge");
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)getMoney
{
    UIViewController * vc = KStoryBoardVC(@"withdrawCash");
    [self.navigationController pushViewController:vc animated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        return 4;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]init];
    view.backgroundColor = RGBCOLOR(225, 225, 225);
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 15;
    }
    else
    {
        return 0.001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.0001;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
        return 200;
    }
    else
    {
        return 45;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    if (section == 1 && indexPath.row == 2) {
//        JRUserAcitivityRecord * record = [[JRUserAcitivityRecord alloc]init];
//        [self.navigationController pushViewController:record animated:YES];
        
        JRInvestRecordController * record = [[JRInvestRecordController alloc]init];
        [self.navigationController pushViewController:record animated:YES];
        
    }
    else if (section == 1 && indexPath.row != 2) {
        UIViewController * vc = KStoryBoardVC(self.vcIndetifyArray[indexPath.row]);
        [self.navigationController pushViewController:vc animated:YES];
    }
    else
    {
        
    }
 
}
- (void)loadMessageInfo
{
 
    [JiuRongHttp JRGetUnreadMessageNum:[UserInfo GetUserInfo].uid status:2 success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        UIBarButtonItem * MessageItem = self.navigationItem.rightBarButtonItem;
        MessageItem.badgeCenterOffset = CGPointMake(-15, 10);
        [MessageItem showBadgeWithStyle:WBadgeStyleNumber value:[[info objectForKey:@"count"] integerValue] animationType:WBadgeAnimTypeBreathe];
    } failure:^(NSError *error) {
        
    }];
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
