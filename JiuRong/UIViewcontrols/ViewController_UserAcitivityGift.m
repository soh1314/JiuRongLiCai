//
//  ViewController_UserAcitivityGift.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "ViewController_UserAcitivityGift.h"
#import "JRGiftRecordCell.h"
#import "JRGiftRecord.h"
#import "JRPastGiftRecordCell.h"
@interface ViewController_UserAcitivityGift ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong)UITableView * giftTableView;
@property (nonatomic,strong)UIView * noRecordView;
@property (nonatomic,strong)UIButton * findTreasureBtn;
@property (nonatomic,strong)NSMutableArray * userActivityRecord;
@property (nonatomic,strong)NSMutableArray * pastActivityRecord;
@property (nonatomic,assign) BOOL hideDetail;
@property (nonatomic,retain)NSIndexPath * indexPath;
@property (nonatomic,assign)float celH;
@property (nonatomic,retain)NSMutableArray * controlArray;
@property (nonatomic,retain)UIView * tableHeader;
@end

@implementation ViewController_UserAcitivityGift
- (id)init
{
    if (self = [super init]) {
        self.hidesBottomBarWhenPushed = YES;
         self.title = @"我的礼品";
        self.hideDetail = YES;
       
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
     self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavbarItem];
    [self loadData];
    [self.view addSubview:self.giftTableView];
    [self.giftTableView reloadData];
    [self updateUI];
    // Do any additional setup after loading the view.
}
- (void)updateUI
{
    [self.view addSubview:self.findTreasureBtn];
    if (self.userActivityRecord.count) {
        
        self.findTreasureBtn.frame = CGRectMake(10, CGRectGetMaxY(self.giftTableView.frame), KScreenW-20, 45);
    }
    else
    {
        [self.view addSubview:self.noRecordView];
        self.findTreasureBtn.frame = CGRectMake(10, CGRectGetMaxY(self.noRecordView.frame)+10, KScreenW-20, 45);
    }
}
- (void)loadData
{
    _userActivityRecord = [NSMutableArray array];
//    for (int i = 0; i < 10; i++) {
//        JRGiftRecord * record = [[JRGiftRecord alloc]init];
//        record.giftName = [NSString stringWithFormat:@"金条%d",i];
//        record.issueNo = [NSString stringWithFormat:@"久融%d",i];
//        record.issueTime = [NSString stringWithFormat:@"时间:%d",i];
//        record.investMoneyAccout = [NSString stringWithFormat:@"100%d",i];
//        record.luckUserName = [NSString stringWithFormat:@"sdfds%d",i];
//        [_userActivityRecord addObject:record];
//    }
}
- (void)setNavbarItem
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage OriginalImageNamed:@"backnav@2x.png"] style:UIBarButtonItemStyleDone target:self action:@selector(backToLastView:)];
}
- (void)backToLastView:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSMutableArray *)controlArray
{
    if (!_controlArray) {
        _controlArray = [NSMutableArray array];
        for (int i = 0; i < self.userActivityRecord.count; i++) {
            int open = 0;
            [_controlArray addObject:@(open)];
        }
    }
    return _controlArray;
}
- (UIView *)tableHeader
{
    if (!_tableHeader) {
        _tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 120)];
        _tableHeader.backgroundColor = [UIColor whiteColor];
        UIImageView * imageview = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW/2.0-30, 20, 60, 60)];
        imageview.image = [UIImage imageNamed:@"award_list_img"];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2.0-75, CGRectGetMaxY(imageview.frame)+5, 150, 30)];
        label.textColor = [UIColor orangeColor];
        label.text = @"夺宝纪录";
        label.textAlignment = NSTextAlignmentCenter;
        [_tableHeader addSubview:label];
        [_tableHeader addSubview:imageview];
        
    }
    return _tableHeader;
}
- (UIView *)noRecordView
{
    if (!_noRecordView) {
        _noRecordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH/2.0)];
        UIImageView * noWin = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW/2.0-75, 50, 150, 150)];
        noWin.image = [UIImage imageNamed:@"not_win_img.png"];
        [_noRecordView addSubview:noWin];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2.0-75, CGRectGetMaxY(noWin.frame)+15, 150, 30)];
        label.text = @"你尚未有中奖纪录";
        label.textColor = [UIColor blackColor];
        [_noRecordView addSubview:label];
    }
    return _noRecordView;
}
- (UIButton *)findTreasureBtn
{
    if (!_findTreasureBtn) {
        _findTreasureBtn = [[UIButton alloc]initWithFrame:CGRectZero];
        [_findTreasureBtn setTitle:@"立即夺宝" forState:UIControlStateNormal];
        _findTreasureBtn.clipsToBounds = YES;
        _findTreasureBtn.layer.cornerRadius = 5;
        [_findTreasureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _findTreasureBtn.backgroundColor = RGBCOLOR(253, 117, 9);
        [_findTreasureBtn addTarget:self action:@selector(findTreasure:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _findTreasureBtn;
}
- (UITableView *)giftTableView
{
    if (!_giftTableView) {
        _giftTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49-64) style:UITableViewStyleGrouped];
        _giftTableView.delegate = self;
        _giftTableView.dataSource = self;
        _giftTableView.tableHeaderView = self.tableHeader;
        _giftTableView.backgroundColor = [UIColor whiteColor];
        _giftTableView.showsVerticalScrollIndicator = NO;
        [_giftTableView registerNib:[UINib nibWithNibName:@"JRGiftRecordCell" bundle:nil] forCellReuseIdentifier:@"JRGiftRecordCell"];
        [_giftTableView registerNib:[UINib nibWithNibName:@"JRPastGiftRecordCell" bundle:nil] forCellReuseIdentifier:@"JRPastGiftRecordCell"];
    }
    return _giftTableView ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.userActivityRecord.count?2:0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.userActivityRecord.count?self.userActivityRecord.count:0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        JRGiftRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRGiftRecordCell" forIndexPath:indexPath];
        JRGiftRecord * record = self.userActivityRecord[indexPath.row];
        cell.backgroundColor = [UIColor whiteColor];
        cell.record = record;
        return cell;
    }
    else
    {
        JRPastGiftRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRPastGiftRecordCell" forIndexPath:indexPath];
        cell.backgroundColor = [UIColor whiteColor];
        [cell hideDetail];
        cell.cellBlock = ^(JRPastGiftRecordCell * cell)
        {
            if (!cell.hideDetail) {
                self.controlArray[indexPath.row] = @(1);
            }
            else
            {
                self.controlArray[indexPath.row] = @(0);
            }
            [tableView reloadData];
            
        };
        JRGiftRecord * record = self.userActivityRecord[indexPath.row];
        cell.record = record;
        return cell;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if(section == 0)
    {
        UIView * view = [[UIView alloc]init];
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 20)];
        [view addSubview:sectionTitle];
        sectionTitle.text = @"我的中奖纪录";
        NSArray * itemTitle = @[@"中奖时间",@"投资金额",@"编码",@"奖金"];
        float width = (KScreenW-20)/4.0;
        for (int i = 0; i < 4; i++) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10+width*i, CGRectGetMaxY(sectionTitle.frame), width, 20)];
            label.text = itemTitle[i];
            i == 0 ? [label setTextAlignment:NSTextAlignmentLeft]:[label setTextAlignment:NSTextAlignmentCenter];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor blackColor];
            [view addSubview:label];
        }
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    else
    {
        UIView * view = [[UIView alloc]init];
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 20)];
        [view addSubview:sectionTitle];
        sectionTitle.text = @"往期开奖纪录";
        NSArray * itemTitle = @[@"期数",@"开奖时间",@"开奖纪录"];
        float width = (KScreenW-20)/4.0;
        for (int i = 0; i < 3; i++) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10+width*i, CGRectGetMaxY(sectionTitle.frame), width, 20)];
            label.text = itemTitle[i];
            i == 0 ? [label setTextAlignment:NSTextAlignmentLeft]:[label setTextAlignment:NSTextAlignmentCenter];
            label.font = [UIFont systemFontOfSize:13];
            label.textColor = [UIColor blackColor];
            [view addSubview:label];
        }
        view.backgroundColor = [UIColor whiteColor];
        return view;
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.controlArray[indexPath.row] integerValue] == 1 && indexPath.section == 1) {
        return 100;
    }
   else
   {
       return 35;
   }
}
- (void)findTreasure:(id)sender
{
    
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
