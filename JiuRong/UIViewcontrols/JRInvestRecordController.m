//
//  JRInvestRecordController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/22.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRInvestRecordController.h"
#import "JRTradeBillCell.h"
typedef NS_ENUM(NSInteger,InvestRecordType)
{
    payingRecord = 0,
    waitingRecord = 1,
    payedRecord
};
@interface JRInvestRecordController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger m_iCurPage;
    NSInteger refreshType;
}
@property (nonatomic,strong)UITableView * tableview;
@property (nonatomic,strong)NSMutableArray * allDataArray;
@property (nonatomic,strong)NSMutableArray * payingArray;
@property (nonatomic,strong)NSMutableArray * waitingArray;
@property (nonatomic,strong)NSMutableArray * payedArray;
@property (nonatomic,strong)UISegmentedControl * sortControl;
@property (nonatomic,assign)InvestRecordType recordType;
@end

@implementation JRInvestRecordController
- (id)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
        m_iCurPage = 1;
        _recordType = payingRecord;
        self.title = @"投资记录";
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *arr = [[NSArray alloc]initWithObjects:@"还款中",@"投标中",@"已还清", nil];
    _sortControl = [[UISegmentedControl alloc]initWithItems:arr];
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 5)];
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];
    _sortControl.frame = CGRectMake(10, 10, KScreenW-20, 40);
    _sortControl.tintColor = KGlobalColor;
    _sortControl.selectedSegmentIndex = 0;
    [_sortControl setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"Helvetica-Bold" size:16]} forState:UIControlStateNormal];
    [_sortControl addTarget:self action:@selector(sort:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.tableview];
    [self setupRefresh];
    [self getData:m_iCurPage];
    
    // Do any additional setup after loading the view.
}
- (void)sort:(id)sender
{
    [self.tableview reloadData];
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 5, KScreenW, KScreenH-64) style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableHeaderView = self.sortControl;
        _tableview.tableFooterView = [[UIView alloc]init];
        [_tableview registerNib:[UINib nibWithNibName:@"JRTradeBillCell" bundle:nil] forCellReuseIdentifier:@"JRTradeBillCellID"];
    }
    return _tableview;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRTradeBillCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRTradeBillCellID" forIndexPath:indexPath];
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.sortControl.selectedSegmentIndex == 0) {
        return self.payingArray.count;
    }
    else if (self.sortControl.selectedSegmentIndex == 1)
    {
        return self.waitingArray.count;
    }
    else
    {
        return self.payedArray.count;
    }
}
- (NSMutableArray *)payedArray
{
    if (!_payedArray) {
        _payedArray = [NSMutableArray array];
    }
    return _payedArray;
}
- (NSMutableArray *)payingArray
{
    if (!_payingArray) {
        _payingArray = [NSMutableArray array];
    }
    return _payingArray;
}
- (NSMutableArray *)waitingArray
{
    if (!_waitingArray) {
        _waitingArray = [NSMutableArray array];
    }
    return _waitingArray;
}
- (void)getData:(NSInteger)page
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetPersonInvestList:[UserInfo GetUserInfo].uid curpage:page pagesize:18 success:^(NSInteger iStatus, NSDictionary *dic, NSString * strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == -1) {
            [self jsonAnalysis:dic];
        }
        else
        {
            KAllert(strErrorCode);
        }
    } failure:^(NSError * errror) {
        [SVProgressHUD dismiss];
    }];
  

}
- (void)jsonAnalysis:(NSDictionary *)dic
{
    if (refreshType == 0) {
        [self.waitingArray removeAllObjects];
        [self.payingArray removeAllObjects];
         [self.payedArray removeAllObjects];
    }

     NSMutableArray *pPage = [dic objectForKey:@"list"];
    for (int i = 0; i < [pPage count]; i++) {
        PaybackBaseInfo *baseinfo = [[PaybackBaseInfo alloc] init];
        baseinfo.title = [pPage[i] objectForKey:@"title"];
        baseinfo.status = [[pPage[i] objectForKey:@"status"] integerValue];
        baseinfo.no = [pPage[i] objectForKey:@"no"];
        baseinfo.ID = [[pPage[i] objectForKey:@"bid_id"] integerValue];
        baseinfo.money = [[pPage[i] objectForKey:@"invest_amount"] integerValue];
        baseinfo.Kmoney = [pPage[i] objectForKey:@"invest_amount"];
        baseinfo.is_agency = [[pPage[i] objectForKey:@"is_agency"] integerValue];
        if (baseinfo.status == 4 ) {
 
            [self.payingArray addObject:baseinfo];
        }
        else if(baseinfo.status == 5 )
        {

            [self.payedArray addObject:baseinfo];
        }
        else
        {

            [self.waitingArray addObject:baseinfo];
        }
    }
    [self.tableview reloadData];
}
- (void)setupRefresh
{
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        m_iCurPage = 1;
        refreshType = 0;
        [self getData:m_iCurPage];
        [self.tableview.header endRefreshing];
    }];
    
    // 上拉刷新
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        m_iCurPage++;
        refreshType = 1;
        [self getData:m_iCurPage];
        
        [self.tableview.footer endRefreshing];
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
