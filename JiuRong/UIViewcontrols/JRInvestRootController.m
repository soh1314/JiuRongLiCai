//
//  JRInvestRootController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/14.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRInvestRootController.h"
#import "JRProjectSpecialCell.h"
#import "BorrowInfo.h"
#import "ViewController_TenderBestDetial.h"
#import "ViewController_TenderDetial.h"
#import "AppDelegate.h"
#import "PopViewLikeQQView.h"
@interface JRInvestRootController ()<UITableViewDelegate,UITableViewDataSource>
{
        BOOL m_bBest;
        BorrowInfo * m_pCurInfo;
}
@property(nonatomic,retain)UITableView * tableview;
@property (nonatomic,retain)NSMutableArray * m_dataArray;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIView * titleView;
@property (nonatomic,strong)UIImageView * titleArrow;
@end

@implementation JRInvestRootController
- (id)init
{
    if (self = [super init]) {
        _page = 1;
        m_bBest = YES;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitleItem];
    [self.view addSubview:self.tableview];
    [self refreshData:@"true"];
    [self getBondData];
    [self pullDragRefresh];
    [self setUpNav];
    // Do any additional setup after loading the view.
}
- (void)setTitleItem
{
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 120, 30)];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, 75, 20)];
    _titleLabel.text = @"久融精选";
    _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:17];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.textColor = [UIColor whiteColor];
    _titleArrow = [[UIImageView alloc]initWithFrame:CGRectMake(95, 10, 12, 8)];
    _titleArrow.image = [UIImage imageNamed:@"com_icon_arrow_down_black@2x"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeInvestItem:)];
    [_titleView addGestureRecognizer:tap];
    [_titleView addSubview:_titleLabel];
    [_titleView addSubview:_titleArrow];
    self.navigationItem.titleView  = _titleView;
}
- (void)changeInvestItem:(UIGestureRecognizer *)tap
{
    NSLog(@"1");
    NSArray * temp = @[@"久融散投",@"久融精选",@"债权转让"];
    [PopViewLikeQQView configCustomPopViewWithFrame:CGRectMake(0,0,KScreenW, 120) imagesArr:nil dataSourceArr:temp anchorPoint:CGPointMake(0, 0) seletedRowForIndex:^(NSInteger index) {
        self.titleLabel.text = temp[index];
        [self refreshDataSource:index];
    } animation:YES timeForCome:0.5 timeForGo:0.5];
}
- (void)refreshDataSource:(NSInteger)idex
{
    if (idex == 1) {
        [self refreshData:@"true"];
        m_bBest = YES;
    }
    else if(idex == 0)
    {
        [self refreshData:@"false"];
        m_bBest = NO;
    }
    else
    {
        [self getBondData];
    }
}
- (void)getBondData
{
    [JiuRongHttp JRGetBondList:10 index:1 success:^(NSInteger iStatus, NSInteger number, NSMutableArray *products, NSString *strErrorCode) {
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableview.header beginRefreshing];
}
- (NSMutableArray *)m_dataArray
{
    if (!_m_dataArray) {
        _m_dataArray  = [NSMutableArray array];
    }
    return _m_dataArray;
}
- (void)setUpNav
{
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu2@2x.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftSlide:)];
    self.navigationItem.leftBarButtonItem = leftBtnItem ;
}

- (void)leftSlide:(id)sender
{
    DDMenuController *ddmenu=(DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menu;
    [ddmenu showLeftController:YES];
 
}
- (void)refreshData:(NSString*)isBest
{
    self.page = 1;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetProjectList:10 index:self.page isBest:isBest success:^(NSInteger iStatus, NSInteger number, NSMutableArray *products, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if ([self.m_dataArray count]) {
            [self.m_dataArray removeAllObjects];
        }
        if (iStatus == 1)
        {
            [self.m_dataArray addObjectsFromArray:products];
            [self.tableview reloadData];
        }
        else
        {
            KAllert(strErrorCode);
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
}

- (void)pullDragRefresh
{
    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        if (m_bBest)
        {
            [self refreshData:@"true"];
        }
        else
        {
            [self refreshData:@"false"];
        }
        [self.tableview.header endRefreshing];
    }];
    
    // 上拉刷新
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        
        if (m_bBest)
        {
            [self loadData:@"true"];
        }
        else
        {
            [self loadData:@"false"];
        }
        [self.tableview.footer endRefreshing];
    }];

}

- (void)loadData:(NSString *)type
{
    _page++;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetProjectList:10 index:self.page isBest:type success:^(NSInteger iStatus, NSInteger number, NSMutableArray *products, NSString *strErrorCode) {
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            if (products == nil || [products count] == 0)
            {
                self.page--;
                return ;
            }
            if (self.page == 1)
            {
                self.m_dataArray = products;
            }
            else
            {
                [self.m_dataArray addObjectsFromArray:products];
            }
            [self.tableview reloadData];
        }
        else
        {
            KAllert(strErrorCode);
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.m_dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRProjectSpecialCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRProjectSpecialCellID" forIndexPath:indexPath];
    cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    BorrowInfo * info = self.m_dataArray[indexPath.row];
    [cell UpdateInfo:info];
    return cell;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49)];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
        [_tableview registerNib:[UINib nibWithNibName:@"JRProjectSpecialCell" bundle:nil] forCellReuseIdentifier:@"JRProjectSpecialCellID"];
    }
    return _tableview;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (KScreenH-49-64)/4.0;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    m_pCurInfo = self.m_dataArray[indexPath.row];
    
    if ([UserInfo GetUserInfo].isLogin == NO)
    {
        UIViewController* pRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"loginroot"];
        [self presentModalViewController:pRoot animated:YES];
    }
    else
    {
        [self UpdateInfo];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"pushTenderBestDetial"])
    {
        ViewController_TenderBestDetial *viewcontrol = (ViewController_TenderBestDetial*)segue.destinationViewController;
        viewcontrol.info = m_pCurInfo;
    }
    
    if ([[segue identifier] isEqualToString:@"pushTenderDetial"])
    {
        ViewController_TenderDetial *viewcontrol = (ViewController_TenderDetial*)segue.destinationViewController;
        viewcontrol.info = m_pCurInfo;
    }
}
- (void)UpdateInfo
{
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRProjectDetial:m_pCurInfo.ID success:^(NSInteger iStatus, BorrowInfo *info, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if (iStatus == 1)
        {
            m_pCurInfo = info;
            if (m_bBest)
            {
                UIStoryboard * board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ViewController_TenderBestDetial * vc = (ViewController_TenderBestDetial*)[board instantiateViewControllerWithIdentifier:@"pushBorrowBest"];
                vc.info = m_pCurInfo;
                [self.navigationController pushViewController:vc animated:YES];
                
//                [self performSegueWithIdentifier:@"pushTenderBestDetial" sender:self];
            }
            else
            {
                UIStoryboard * board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ViewController_TenderBestDetial * vc = (ViewController_TenderBestDetial*)[board instantiateViewControllerWithIdentifier:@"pushBorrowNormal"];
                vc.info = m_pCurInfo;
                [self.navigationController pushViewController:vc animated:YES];
//                [self performSegueWithIdentifier:@"pushTenderDetial" sender:self];
            }
        }
        else
        {
            
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
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
