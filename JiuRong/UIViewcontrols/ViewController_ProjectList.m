//
//  ViewController_ProjectList.m
//  JiuRong
//
//  Created by iMac on 15/9/8.
//  Copyright (c) 2015年 huoqiangshou. All rights reserved.
//

#import "ViewController_ProjectList.h"
#import "Public.h"
#import "CollectionViewCell_Project.h"
#import "BorrowInfo.h"
#import <MJRefresh/MJRefresh.h>
#import "JiuRongHttp.h"
#import <SVProgressHUD/SVProgressHUD.h>
#import "ViewController_TenderBestDetial.h"
#import "ViewController_TenderDetial.h"
#import "AppDelegate.h"
#import "PopViewLikeQQView.h"
static NSString * CellIdentifier = @"CollectProject";

@interface ViewController_ProjectList () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,CollectionCell_Project_delegate>
{
    NSMutableArray *m_arrayInfos;
    UIView *m_pViewNOData;
    BorrowInfo *m_pCurInfo;
    BOOL m_bBest;
    
    NSInteger m_iCurPage;
}
@property (nonatomic,strong)UILabel * titleLabel;
@property (nonatomic,strong)UIView * titleView;
@property (nonatomic,strong)UIImageView * titleArrow;
@end

@implementation ViewController_ProjectList

- (void)viewDidLoad {
    [super viewDidLoad];
    _titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 100, 30)];
    _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, 75, 20)];
    _titleLabel.text = @"久融精选";
    _titleLabel.textColor = [UIColor whiteColor];
    _titleArrow = [[UIImageView alloc]initWithFrame:CGRectMake(75, 10, 12, 8)];
    _titleArrow.image = [UIImage imageNamed:@"com_icon_arrow_down_black@2x"];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeInvestItem:)];
    [_titleView addGestureRecognizer:tap];
    [_titleView addSubview:_titleLabel];
    [_titleView addSubview:_titleArrow];
    self.navigationItem.titleView  = _titleView;
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight ;

    [self.collectionviewMain registerClass:[CollectionViewCell_Project class] forCellWithReuseIdentifier:CellIdentifier];
    
    _btnOne.selected = YES;
    m_bBest = TRUE;
    m_iCurPage = 0;
    [self GetHeadData:@"true"];
    [self setupRefresh];
    [self setUpNav];
}
- (void)changeInvestItem:(UIGestureRecognizer *)tap
{
    NSLog(@"1");
    NSArray * temp = @[@"久融散投",@"久融精选",@"债权转让"];
    [PopViewLikeQQView configCustomPopViewWithFrame:CGRectMake(0, 0, KScreenW, 90) imagesArr:nil dataSourceArr:temp anchorPoint:CGPointMake(0, 0) seletedRowForIndex:^(NSInteger index) {
        self.titleLabel.text = temp[index];
        [self refreshDataSource:index];
    } animation:YES timeForCome:0.5 timeForGo:0.5];
}
- (void)refreshDataSource:(NSInteger)index
{
    
}
- (void)setUpNav
{
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
//        UIViewController* pRoot = [self.storyboard instantiateViewControllerWithIdentifier:@"loginroot"];
        UIViewController * vc = KStoryBoardVC(@"loginroot");
        [self presentModalViewController:vc animated:YES];
    }
    

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
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


//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger iCount = [m_arrayInfos count];
    if (iCount == 0)
    {
        [self SetupEmptyView:YES];
    }
    else
    {
        [self SetupEmptyView:NO];
    }
    
    return iCount;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell_Project * cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    
    cell.delegate = self;
    [cell UpdateInfo:m_arrayInfos[indexPath.row]];
    
    return cell;
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.bounds.size.width, 80);
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    m_pCurInfo = m_arrayInfos[indexPath.row];
    
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

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)DidClickBtnCommit:(id)sender
{
    ;
}
- (void)refreshData:(NSString*)isBest
{
     m_iCurPage = 1;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetProjectList:10 index:m_iCurPage isBest:isBest success:^(NSInteger iStatus, NSInteger number, NSMutableArray *products, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        if ([m_arrayInfos count]) {
            [m_arrayInfos removeAllObjects];
        }
        if (iStatus == 1)
        {
            if (products == nil || [products count] == 0)
            {
                m_iCurPage--;
                return ;
            }
            
            if (m_iCurPage == 1)
            {
                m_arrayInfos = products;
            }
            else
            {
                [m_arrayInfos addObjectsFromArray:products];
            }
            
            [self.collectionviewMain reloadData];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];

    
}
- (void)GetHeadData:(NSString*)isBest
{
    m_iCurPage++;
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeClear];
    [JiuRongHttp JRGetProjectList:10 index:m_iCurPage isBest:isBest success:^(NSInteger iStatus, NSInteger number, NSMutableArray *products, NSString *strErrorCode) {
        
        [SVProgressHUD dismiss];
        
        if (iStatus == 1)
        {
            if (products == nil || [products count] == 0)
            {
                m_iCurPage--;
                return ;
            }
            
            if (m_iCurPage == 1)
            {
                m_arrayInfos = products;
            }
            else
            {
                [m_arrayInfos addObjectsFromArray:products];
            }
            
            [self.collectionviewMain reloadData];
        }
        else
        {
            UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"久融金融" message:strErrorCode delegate:self cancelButtonTitle:@"呦,我知道了!" otherButtonTitles:nil];
            [alter show];
        }
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];
}

- (IBAction)ClickButtons:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    self.btnOne.selected = btn==self.btnOne?YES:NO;
    self.btnTwo.selected = btn==self.btnTwo?YES:NO;
    self.btnThree.selected = btn==self.btnThree?YES:NO;
    
    if (btn == self.btnTwo)
    {
        [self SetupEmptyView:TRUE];
    }
    else
    {
        [self SetupEmptyView:FALSE];
        if (btn == _btnOne)
        {
            if (m_bBest && m_iCurPage > 0)
            {
                return;
            }
            
            m_bBest = TRUE;
            m_iCurPage = 0;
            [m_arrayInfos removeAllObjects];
            [self.collectionviewMain reloadData];
            
            [self GetHeadData:@"true"];
        }
        else
        {
            if (!m_bBest && m_iCurPage > 0)
            {
                return;
            }
            
            m_bBest = FALSE;
            m_iCurPage = 0;
            [m_arrayInfos removeAllObjects];
            [self.collectionviewMain reloadData];
            
            [self GetHeadData:@"false"];
        }
    }
}

//开始刷新自定义方法
- (void)setupRefresh
{
#warning sdfdsfasd
    self.collectionviewMain.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block
    
        if (m_bBest)
        {
            [self refreshData:@"true"];
        }
        else
        {
            [self refreshData:@"false"];
        }
        [self.collectionviewMain.header endRefreshing];
    }];
    
    // 上拉刷新
    self.collectionviewMain.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        // 进入刷新状态后会自动调用这个block

        if (m_bBest)
        {
            [self GetHeadData:@"true"];
        }
        else
        {
            [self GetHeadData:@"false"];
        }
        [self.collectionviewMain.footer endRefreshing];
    }];
    
}

- (void)SetupEmptyView:(BOOL)bShow
{
    if (m_pViewNOData == nil)
    {
        m_pViewNOData = [[UIView alloc] initWithFrame:self.collectionviewMain.frame];
        m_pViewNOData.backgroundColor = RGBCOLOR(243, 243, 243);
        
        CGPoint p =  CGPointMake([Public GetWidth]/2, [Public GetHeight]/2);
        UIImageView *imageview = [[UIImageView alloc] initWithFrame:CGRectMake(p.x-50, 100, 100, 100)];
        imageview.image = [UIImage imageNamed:@"理财无数据@2x.png"];
        imageview.contentMode = UIViewContentModeCenter;
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 210, self.collectionviewMain.bounds.size.width, 21)];
        label.textAlignment = NSTextAlignmentCenter;
        label.text = @"暂无相关记录";
        label.textColor = RGBCOLOR(149, 149, 149);
        
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(p.x-40, 250, 80, 30)];
        [btn setTitle:@"点击刷新" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.layer.borderColor = [RGBCOLOR(145, 204, 232) CGColor];
        btn.layer.borderWidth = 2.0f;
        btn.layer.cornerRadius = 2.0f;
        
        [m_pViewNOData addSubview:imageview];
        [m_pViewNOData addSubview:label];
//        [m_pViewNOData addSubview:btn];
        [self.view addSubview:m_pViewNOData];
    }
    
    m_pViewNOData.hidden = bShow?NO:YES;
    self.collectionviewMain.hidden = bShow?YES:NO;
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
                [self performSegueWithIdentifier:@"pushTenderBestDetial" sender:self];
            }
            else
            {
                [self performSegueWithIdentifier:@"pushTenderDetial" sender:self];
            }
        }
        else
        {
            
        }
    } failure:^(NSError *error) {
        
        [SVProgressHUD dismiss];
        
    }];
}
@end
