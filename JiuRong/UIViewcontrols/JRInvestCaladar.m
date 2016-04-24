//
//  JRInvestCaladar.m
//  YingbaFinance
//
//  Created by 刘仰清 on 16/4/24.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRInvestCaladar.h"

@interface JRInvestCaladar ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,retain)UITableView * tableview;
@property (nonatomic,retain)UIView * calardarView;
@property (nonatomic,retain)NSMutableArray * dataArray;
@end

@implementation JRInvestCaladar

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-64)];
        _tableview.delegate = self;
        _tableview.dataSource =self;
        _tableview.tableHeaderView = self.calardarView;
    }
    return _tableview   ;
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
