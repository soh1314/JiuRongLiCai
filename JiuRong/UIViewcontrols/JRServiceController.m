//
//  JRServiceController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRServiceController.h"
#import "JRThreeItemCell.h"
#import "JRHelpCenterStyleNCell.h"
@interface JRServiceController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UITableView * tableView;
@property (nonatomic,copy)NSArray * titleArray;
@end

@implementation JRServiceController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的服务";
    _titleArray = @[@"官方微信",@"官方微博",@"官方地址",@"官方邮箱",@"客服热线"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"JRThreeItemCell" bundle:nil] forCellReuseIdentifier:@"JRThreeItemCellID"];
        [_tableView registerNib:[UINib nibWithNibName:@"JRHelpCenterStyleNCell" bundle:nil] forCellReuseIdentifier:@"JRHelpCenterStyleNCellID"];
    }
    return _tableView;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        JRThreeItemCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRThreeItemCellID" forIndexPath:indexPath];
        return cell;
    }
    else
    {
        JRHelpCenterStyleNCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRHelpCenterStyleNCellID" forIndexPath:indexPath];
        if (indexPath.row == 1) {
            cell.notiLabel.text = @"www.9rjr.com";
        }
        if (indexPath.row == 3) {
            cell.notiLabel.text = @"40000020149";
        }
        cell.titleLabel.text = self.titleArray[indexPath.row];
        return cell;
    }
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
        return 5;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 80;
    }
    else
    {
        return 45;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0) {
        return 25;
    }
    else
    {
        return 0.0001;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.00001;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
