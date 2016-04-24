//
//  JRHomeRootController.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/14.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRHomeRootController.h"
#import "BorrowInfo.h"
#import "UserInfo.h"
#import "JiuRongConfig.h"
#import "ViewController_TenderBestDetial.h"
#import "ViewController_TenderDetial.h"
#import "ViewController_Borrow.h"
#import "JRHomeIntroCell.h"
#import "JRHomeRecommendCell.h"
#import "SDCycleScrollView.h"
#import "JRProjectSpecialCell.h"
#import "DDMenuController.h"
#import "AppDelegate.h"
#import <ImageIO/ImageIO.h>
#import "UIScrollView+Associated.h"
#import "UINavigationBar+Awesome.h"
#import "QSRefreshView.h"
#define NAVBAR_CHANGE_POINT 80
@interface JRHomeRootController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
@property (nonatomic,retain)UITableView * tableview;
@property (nonatomic,retain)NSMutableArray * bannerImageArray;
@property (nonatomic,retain)NSMutableArray * projectArray;
@property (nonatomic,copy)NSMutableString * registerNum;
@property (nonatomic,copy)NSMutableString * earnAmount;
@property (nonatomic,assign)NSInteger page;
@property (nonatomic,retain)SDCycleScrollView * banner;
@end

@implementation JRHomeRootController
- (id)init
{
    if (self = [super init]) {
        _page = 1;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _bannerImageArray = [[NSMutableArray alloc] init];
    [_bannerImageArray addObject:@"首页logo01.png"];
    [_bannerImageArray addObject:@"首页logo02.png"];
    [_bannerImageArray addObject:@"首页logo03.png"];
    [_bannerImageArray addObject:@"首页logo04.png"];
    [self SetupNavigation];
    [self.view addSubview:self.tableview];
    [self loadData:YES];
    [self pullDragRefresh];
    [self.navigationController.navigationBar lt_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.title = @"久融理财";
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
     [self.tableview.refreshView2 pullRefresh];
    self.tableview.delegate = self;
    [self scrollViewDidScroll:self.tableview];
    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.tableview.delegate = nil;
    [self.navigationController.navigationBar lt_reset];
    self.navigationController.navigationBar.hidden = NO;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = RGBCOLOR(27, 138, 238);
    
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > NAVBAR_CHANGE_POINT) {
        CGFloat alpha = MIN(1, 1 - ((NAVBAR_CHANGE_POINT + 64 - offsetY) / 64));
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
//        self.navigationController.navigationBar.hidden = NO;
    } else {
        [self.navigationController.navigationBar lt_setBackgroundColor:[color colorWithAlphaComponent:0]];
//        self.navigationController.navigationBar.hidden = YES;
    }
}
- (void)SetupNavigation
{
    //    UIControl *leftbarView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 100, 64)];
    //    UIImageView *imageview = [[UIImageView alloc] initWithFrame:leftbarView.bounds];
    //    imageview.image = [UIImage imageNamed:@"logo@2x.png"];
    //    imageview.contentMode = UIViewContentModeScaleAspectFit;
    //    [leftbarView addSubview:imageview];
    //    [leftbarView addTarget:self action:@selector(ClickToUILocate) forControlEvents:UIControlEventTouchDown];
    //    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftbarView];
    //    self.navigationItem.leftBarButtonItem = leftButtonItem;
    UIBarButtonItem * leftBtnItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"menu2@2x.png"] style:UIBarButtonItemStyleDone target:self action:@selector(leftSlide:)];
    self.navigationItem.leftBarButtonItem = leftBtnItem ;
}
- (void)leftSlide:(id)sender
{
    if ([UserInfo GetUserInfo].isLogin == TRUE) {
        DDMenuController *ddmenu=(DDMenuController *)((AppDelegate *)[[UIApplication sharedApplication]delegate]).menu;
        [ddmenu setEnableGesture:YES];
        [ddmenu showLeftController:YES];
    }
    else
    {
        UIViewController * vc = KStoryBoardVC(@"loginroot");
        [self presentModalViewController:vc animated:YES];
    }
    
}
- (SDCycleScrollView *)banner
{
    if (!_banner) {
        _banner = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, KScreenW, KScreenW*0.5) shouldInfiniteLoop:YES imageNamesGroup:_bannerImageArray];
        _banner.pageControlStyle = SDCycleScrollViewPageContolStyleAnimated;
    }
    return _banner;
}
- (UITableView *)tableview
{
    if (!_tableview) {
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-KTabbarH) style:UITableViewStylePlain];
        _tableview.delegate =  self;
        _tableview.dataSource = self;
        _tableview.separatorInset = UIEdgeInsetsMake(0, -25, 0, 0);
        [_tableview registerNib:[UINib nibWithNibName:@"JRHomeIntroCell" bundle:nil] forCellReuseIdentifier:@"JRHomeIntroCellID"];
        [_tableview registerNib:[UINib nibWithNibName:@"JRProjectSpecialCell" bundle:nil] forCellReuseIdentifier:@"JRProjectSpecialCellID"];
        _tableview.tableHeaderView = self.banner;
        _tableview.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    }
    return _tableview;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        JRHomeIntroCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRHomeIntroCellID" forIndexPath:indexPath];
        cell.earMoneyTotal.text = [NSString stringWithFormat:@"%@",self.earnAmount];
        cell.registerNum.text = [NSString stringWithFormat:@"%@",self.registerNum];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    }
    else
    {
        JRProjectSpecialCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRProjectSpecialCellID" forIndexPath:indexPath];
        BorrowInfo * info = self.projectArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        [cell UpdateInfo:info];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    if (row == 0) {
        return KScreenW*0.15  ;
    }
    else
    {
        return 120;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.projectArray.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  
    if ([UserInfo GetUserInfo].isLogin == NO)
    {
        
        UIViewController* pRoot = KStoryBoardVC(@"loginroot");
        
        [self presentModalViewController:pRoot animated:YES];
        return;
    }
    BorrowInfo *tmpinfo = self.projectArray[indexPath.row];
    if (tmpinfo.isbest)
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRProjectDetial:tmpinfo.ID success:^(NSInteger iStatus, BorrowInfo *info, NSString *strErrorCode) {
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ViewController_TenderBestDetial* pTender = [story instantiateViewControllerWithIdentifier:@"pushBorrowBest"];
                pTender.info = info;
                [self.navigationController pushViewController:pTender animated:YES];
            }
            else
            {
                KAllert(strErrorCode);
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
    else
    {
        [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
        [JiuRongHttp JRProjectDetial:tmpinfo.ID success:^(NSInteger iStatus, BorrowInfo *info, NSString *strErrorCode) {
            [SVProgressHUD dismiss];
            if (iStatus == 1)
            {
                UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ViewController_TenderDetial* pTender = [story instantiateViewControllerWithIdentifier:@"pushBorrowNormal"];
                pTender.info = info;
                [self.navigationController pushViewController:pTender animated:YES];
            }
            else
            {
                KAllert(strErrorCode);
            }
        } failure:^(NSError *error) {
            [SVProgressHUD dismiss];
        }];
    }
}

- (void)pullDragRefresh
{
//    self.tableview.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        // 进入刷新状态后会自动调用这个block
//        [self loadData];
//        [self.tableview.header endRefreshing];
//    }];
    self.tableview.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
        [self loadMoreData];
        [self.tableview.footer endRefreshing];
    }];
    __weak typeof(self)VC=self;
    self.tableview.refreshView2=[[QSRefreshView alloc]initWithHandler:^{
            [self loadData:NO];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
          [VC.tableview.refreshView2 stopRefresh];
        });
    }];
}
- (NSMutableArray *)projectArray
{
    if (!_projectArray) {
        _projectArray = [NSMutableArray array];
    }
    return _projectArray;
}
- (void)loadMoreData
{
    self.page++;
    [JiuRongHttp JRGetHomeData:@"true" curpage:self.page pagesize:5 success:^(NSInteger iStatus, NSInteger registerNum, NSInteger platAmount, NSInteger earnAmount, NSMutableArray *products, NSString *strErrorCode) {
        if (iStatus == 1)
        {
            self.earnAmount = [NSMutableString stringWithFormat:@"%lu",earnAmount];
            self.registerNum = [NSMutableString stringWithFormat:@"%lu",registerNum] ;
            if (products.count > 0) {
                [self.projectArray addObjectsFromArray:products];
                [self.tableview reloadData];
            }
            else
            {
                self.page--;
                return ;
            }
        }
        else
        {
            KAllert(strErrorCode);
        }
    } failure:^(NSError *error)
     {
         [SVProgressHUD dismiss];
     }];
}

- (void)loadData:(BOOL)showHud
{
    if (showHud) {
        [SVProgressHUD showWithMaskType: SVProgressHUDMaskTypeBlack];
    }
    [JiuRongHttp JRGetHomeData:@"true" curpage:1 pagesize:5 success:^(NSInteger iStatus, NSInteger registerNum, NSInteger platAmount, NSInteger earnAmount, NSMutableArray *products, NSString *strErrorCode) {
        if (showHud) {
            [SVProgressHUD dismiss];
        }
        self.earnAmount = [NSMutableString stringWithFormat:@"%lu",earnAmount];
        self.registerNum = [NSMutableString stringWithFormat:@"%lu",registerNum] ;
        if (iStatus == 1)
        {
            [self.projectArray removeAllObjects];
            [self.projectArray addObjectsFromArray:products];
            [self.tableview reloadData];
        }
        else
        {
            KAllert(strErrorCode);
        }
    } failure:^(NSError *error)
     {
//         if (showHud) {
//             [SVProgressHUD dismiss];
//         }
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
