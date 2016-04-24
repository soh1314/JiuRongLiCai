//
//  JRPasswordController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/8.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRPasswordController.h"
#import "JRHelpCenterStyleNCell.h"
#import "UserCenterConstant.h"
#import "JRVerifyLoginPwdController.h"
#import "JRModifyPwdController.h"
@interface JRPasswordController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UITableView * tableView;
@property (nonatomic,retain)NSArray * titleArray;
@property (nonatomic,retain)NSArray * notiArray;
@property (nonatomic,retain)NSArray * imageArray;

@end

@implementation JRPasswordController
- (id)init
{
    if (self = [super init]) {
        self.title = @"密码管理";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _titleArray = @[@"登录密码",@"手势密码"];
    _notiArray = @[@"修改",@"设置/修改"];
    _imageArray = @[@"password@2x",@"password@2x"];
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [[UIView alloc]init];
//        _tableView.separatorInset = UIEdgeInsetsMake(0, -10, 0, 0);
        [_tableView registerNib:[UINib nibWithNibName:@"JRHelpCenterStyleNCell" bundle:nil] forCellReuseIdentifier:@"JRHelpCenterStyleNCellID"];
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
////// tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRHelpCenterStyleNCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRHelpCenterStyleNCellID" forIndexPath:indexPath];
//    cell.leftImage.hidden = YES;
    cell.titleLabel.text = self.titleArray[indexPath.row];
    cell.notiLabel.text = self.notiArray[indexPath.row];
    cell.notiLabel.textColor = [UIColor redColor];
    cell.leftImage.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 1) {
        JRVerifyLoginPwdController * cv = [[JRVerifyLoginPwdController alloc]init];
        [self presentViewController:cv animated:YES completion:nil];
    }
    else
    {
//        JRModifyPwdController * vc = [[JRModifyPwdController alloc]init];
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController * vc = [story instantiateViewControllerWithIdentifier:@"ViewController_ForgetPassword"];
        [self.navigationController pushViewController:vc animated:YES];
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
