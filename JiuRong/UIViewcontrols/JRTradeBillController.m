//
//  JRTradeBillController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/22.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRTradeBillController.h"
#import "JRTradeBillCell.h"
@interface JRTradeBillController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UITableView * tableView;
@property (nonatomic,assign)NSInteger page;
@end

@implementation JRTradeBillController

- (id)init
{
    if (self = [super init]) {
        _page = 1;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self loadData:self.page];
    [self refreshSetting];
    // Do any additional setup after loading the view.
}
- (void)loadData:(NSInteger)page
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetTransList:[UserInfo GetUserInfo].uid curpage:page pagesize:18 type:0 success:^(NSInteger iStatus, TransInfo *info, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            
            [self.tableView reloadData];
        }
        else
        {
            KAllert(strErrorCode);
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}
- (void)refreshSetting
{
    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH) style:UITableViewStylePlain];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerNib:[UINib nibWithNibName:@"JRTradeBillCell" bundle:nil] forCellReuseIdentifier:@"JRTradeBillCellID"];
    }
    return _tableView;
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
