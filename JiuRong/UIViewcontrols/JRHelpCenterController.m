//
//  JRHelpCenterController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRHelpCenterController.h"
#import "JRHelpCenterStyleNCell.h"
#import "JRHelpCenterCollectionStyleCell.h"
#import "ViewController_Webview.h"
@interface JRHelpCenterController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UITableView * tableview;
@property (nonatomic,copy)NSArray * titleArray;
@property (nonatomic,copy)NSArray * imageArray;
@property (nonatomic,copy)NSArray * projectTitleArray;
@property (nonatomic,copy)NSArray * projectImageArray;
@property (nonatomic,copy)NSArray * headerTitleArray;
@property (nonatomic,copy)NSArray * urlArray;
@end

@implementation JRHelpCenterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"帮助中心";
    _headerTitleArray = @[@"理财产品",@"常见问题",@"用户账户"];
    _titleArray = @[@[@"注册登录",@"投资赎回",@"充值提现"],@[@"账户管理",@"交易管理",@"活动专区"]];
    _projectTitleArray = @[@"新手专享",@"精选产品",@"活动产品"];
    _projectImageArray = @[@"award1.png",@"充值@2x副本",@"充值@2x副本"];
    [self.view addSubview:self.tableview];

    [self.tableview reloadData];
    
    
    
    // Do any additional setup after loading the view.
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) style:UITableViewStyleGrouped];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        [_tableview registerNib:[UINib nibWithNibName:@"JRHelpCenterStyleNCell" bundle:nil] forCellReuseIdentifier:@"JRHelpCenterStyleNCellID"];
        [_tableview registerClass:[JRHelpCenterCollectionStyleCell class] forCellReuseIdentifier:@"JRHelpCenterCollectionStyleCellID"];
    }
    return _tableview;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
        JRHelpCenterCollectionStyleCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRHelpCenterCollectionStyleCellID" forIndexPath:indexPath];
        cell.dataArray = _projectTitleArray;
        cell.imageArray = _projectImageArray;
        [cell setSelectItemAction:^(NSIndexPath * index) {
            NSLog(@"%ld",index.row);
        }];
        return cell;
    }
    else
    {
    JRHelpCenterStyleNCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRHelpCenterStyleNCellID" forIndexPath:indexPath];
    cell.titleLabel.text = self.titleArray[indexPath.section-1][indexPath.row];
    cell.leftImage.image = [UIImage imageNamed:self.imageArray[indexPath.section-1][indexPath.row]];
    return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger section = indexPath.section;
    if (section == 0) {
        return min((KScreenW-2)/3.0f,110);
    }
    else
    {
        return 45;
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else
    {
        ;
        return [self.titleArray[section-1] count];
    }

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger section = indexPath.section;
    if (section != 0) {
        ViewController_Webview * web = [[ViewController_Webview alloc]init];
        web.url = self.urlArray[indexPath.section][indexPath.row];
        [self.navigationController pushViewController:web animated:YES];
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * view = [[UIView alloc]initWithFrame:CGRectZero];
    UILabel * lable = [[UILabel alloc]initWithFrame:CGRectMake(15, 5, 150, 20)];
    lable.font = [UIFont systemFontOfSize:14];
    lable.textColor = KGlobalColor;
    lable.text = self.headerTitleArray[section];
    [view addSubview:lable];
    return view;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.001;
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
