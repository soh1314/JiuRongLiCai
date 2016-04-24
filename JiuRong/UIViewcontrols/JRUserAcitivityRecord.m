//
//  JRUserAcitivityRecord.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/3/28.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRUserAcitivityRecord.h"
#import "JRGiftRecordCell.h"
#import "JRGiftRecord.h"
#import "JRPastTotalGIftRecordController.h"
#import "ViewController_ProjectList.h"
@interface JRUserAcitivityRecord ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,retain)UIView * tableHeader;
@property (nonatomic,strong)NSMutableArray * m_dataArray;
@property (nonatomic,strong)UITableView * JRUsrTableView;
@property (nonatomic,strong)UIView * noRecordView;
@property (nonatomic,strong)UIButton * findTreasureBtn;
@property (nonatomic,assign)BOOL push;
@property (nonatomic,copy)NSString * mycodeNums;
@property (nonatomic,strong)UIView * mycodeView;
@property (nonatomic,strong)UIView * pastRecord;
@property (nonatomic,strong)UILabel * codeLabel;
@end

@implementation JRUserAcitivityRecord

- (void)viewDidLoad {
    [super viewDidLoad];
    self.extendedLayoutIncludesOpaqueBars = NO;
    self.edgesForExtendedLayout = UIRectEdgeBottom | UIRectEdgeLeft | UIRectEdgeRight;
    [self loadData];
    
}
- (id)init
{
    if (self = [super init]) {
        self.title = @"我的中奖记录";
        self.view.backgroundColor = [UIColor whiteColor];
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}
- (void)loadData
{
    [JiuRongHttp JRGetDuobaoUserRecord:[UserInfo GetUserInfo].uid success:^(NSInteger iStatus, NSString *error, NSMutableDictionary *info) {
        NSArray * records = [info objectForKey:@"myAwardRecords"];
        NSString * myCodeNums = [info objectForKey:@"myCodeNums"];
        self.mycodeNums = [NSString stringWithFormat:@"%@",myCodeNums];
        for (int i = 0; i < records.count; i++) {
            JRGiftRecord * record = [JRGiftRecord creatItemWith:records[i]];
            [self.m_dataArray addObject:record];
            
        }
        [self updateUI];
    } failure:^(NSError *error) {
        
    }];
}
- (void)updateUI
{
    [self.view addSubview:self.findTreasureBtn];
    
    if (self.m_dataArray.count) {
        [self.view addSubview:self.JRUsrTableView];
        self.findTreasureBtn.frame = CGRectMake(10, CGRectGetMaxY(self.JRUsrTableView.frame)+5, KScreenW-20, 40);
    }
    else
    {
        [self.view addSubview:self.noRecordView];
        if (self.mycodeNums.length > 0) {
            _codeLabel.text = self.mycodeNums;
            [UserInfo GetUserInfo].codeNum = self.mycodeNums;
        }
        else
        {
            _codeLabel.text = @"您还未参与本次夺宝";
            [UserInfo GetUserInfo].codeNum = @"您还未参与本次夺宝";
        }
        
        self.findTreasureBtn.frame = CGRectMake(50, CGRectGetMaxY(self.noRecordView.frame)+5, KScreenW-100, 40);
    }
    [self.JRUsrTableView reloadData];
}
- (NSMutableArray *)m_dataArray
{
    if (!_m_dataArray) {
        _m_dataArray = [NSMutableArray array];
        
    }
    return _m_dataArray;
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
        label.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        label.textAlignment = NSTextAlignmentCenter;
        [_tableHeader addSubview:label];
        [_tableHeader addSubview:imageview];
    }
    return _tableHeader;
}
- (UIView *)noRecordView
{
    if (!_noRecordView) {
        _noRecordView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 320)];
        UIImageView * noWin = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW/2.0-75, 30, 150, 150)];
        noWin.image = [UIImage imageNamed:@"not_win_img.png"];
        [_noRecordView addSubview:noWin];
        UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(KScreenW/2.0-75, CGRectGetMaxY(noWin.frame)+15, 150, 30)];
        label.text = @"你尚未有中奖纪录";
        label.textColor = [UIColor blackColor];
        [_noRecordView addSubview:label];
        self.mycodeView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(label.frame)+15, KScreenW, 30)];
        [_noRecordView addSubview:_mycodeView];
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 120, 20)];;
        [self.mycodeView addSubview:sectionTitle];
        sectionTitle.font = [UIFont systemFontOfSize:14];
        sectionTitle.text = @"我的最新夺宝编码:";
        _codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sectionTitle.frame), 5, 150, 20)];
        [self.mycodeView addSubview:_codeLabel];
        _codeLabel.font = [UIFont systemFontOfSize:14];
        _codeLabel.text = self.mycodeNums;
        _codeLabel.textColor = [UIColor orangeColor];
        self.pastRecord = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.mycodeView.frame)+2, KScreenW, 30)];
        [_noRecordView addSubview:self.pastRecord];
        UILabel * Title = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
        Title.font = [UIFont systemFontOfSize:14];
        Title.text = @"往期开奖记录";
        [_pastRecord addSubview:Title];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW-40, 5, 12, 15)];
        imageView.image = [UIImage imageNamed:@"next@2x.png"];
        [_pastRecord addSubview:imageView];
        UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNext:)];
        [_pastRecord addGestureRecognizer:viewTap];
    }
    return _noRecordView;
}
- (UITableView *)JRUsrTableView
{
    if (!_JRUsrTableView) {
        _JRUsrTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, KScreenW, KScreenH-49-64) style:UITableViewStyleGrouped];
        _JRUsrTableView.delegate = self;
        _JRUsrTableView.dataSource = self;
        _JRUsrTableView.tableHeaderView = self.tableHeader;
        _JRUsrTableView.backgroundColor = [UIColor whiteColor];
        _JRUsrTableView.showsVerticalScrollIndicator = NO;
        _JRUsrTableView.separatorInset = UIEdgeInsetsZero;
//        _JRUsrTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_JRUsrTableView registerNib:[UINib nibWithNibName:@"JRGiftRecordCell" bundle:nil] forCellReuseIdentifier:@"JRGiftRecord"];
//        [_JRUsrTableView registerClass:[JRGiftRecordCell class] forCellReuseIdentifier:@"JRGiftRecord"];
    }
    return _JRUsrTableView;
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger sectionNum;
    if (section == 0) {
        sectionNum = 0;
    }
    if (section == 1) {
        sectionNum = self.m_dataArray.count;
        
    }
    else
    {
        sectionNum = 0;
    }
    return sectionNum;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    JRGiftRecordCell * cell = [tableView dequeueReusableCellWithIdentifier:@"JRGiftRecord" forIndexPath:indexPath];
    JRGiftRecord * record = _m_dataArray[indexPath.row];
//    cell.backgroundColor = RGBCOLOR(244, 244, 244);
    cell.record = record;
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView * header = [[UIView alloc]init];
    UILabel * edge1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, KScreenW, 0.5)];
    edge1.backgroundColor = [UIColor lightGrayColor];
    [header addSubview:edge1];
    if (section == 2) {
        UILabel * edge2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 30-0.8, KScreenW, 0.5)];
        edge2.backgroundColor = [UIColor lightGrayColor];
        [header addSubview:edge2];
    }

    if (section == 0) {
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];;
        [header addSubview:sectionTitle];
        sectionTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        sectionTitle.text = @"我的最新夺宝编码:";
        UILabel * codeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(sectionTitle.frame), 5, 150, 20)];
        [header addSubview:codeLabel];
        [UserInfo GetUserInfo];
        codeLabel.font = [UIFont systemFontOfSize:14];
        if (self.mycodeNums.length > 0) {
            codeLabel.text = self.mycodeNums;
            [UserInfo GetUserInfo].codeNum = self.mycodeNums;
        }
        else
        {
            codeLabel.text = @"您还未参与本次夺宝";
            [UserInfo GetUserInfo].codeNum = @"您还未参与本次夺宝";
        }

        codeLabel.textColor = [UIColor orangeColor];
    }
    if(section == 1)
    {
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
        [header addSubview:sectionTitle];
        sectionTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
        sectionTitle.text = @"我的中奖纪录";
        NSArray * itemTitle = @[@"中奖时间",@"投资金额",@"编码",@"奖金"];
        float width = (KScreenW-20)/4.0;
        for (int i = 0; i < 4; i++) {
            UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(10+width*i, CGRectGetMaxY(sectionTitle.frame), width, 20)];
            label.text = itemTitle[i];
            i == 0 ? [label setTextAlignment:NSTextAlignmentLeft]:[label setTextAlignment:NSTextAlignmentCenter];
            label.font = [UIFont fontWithName:@"Helvetica-Bold" size:13];
            label.textColor = [UIColor blackColor];
            [header addSubview:label];
        }
        header.backgroundColor = [UIColor whiteColor];
        return header;
    }
    if(section == 2)
    {
        UILabel * sectionTitle = [[UILabel alloc]initWithFrame:CGRectMake(10, 5, 150, 20)];
        sectionTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        sectionTitle.text = @"往期开奖记录";
        [header addSubview:sectionTitle];
        UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(KScreenW-40, 5, 12, 15)];
        imageView.image = [UIImage imageNamed:@"next@2x.png"];
        [header addSubview:imageView];
        UITapGestureRecognizer * viewTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapToNext:)];
        [header addGestureRecognizer:viewTap];
    }
    return header;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 45;
    }
    else
    {
    return 30;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView * foot = [[UIView alloc]init];
    foot.backgroundColor = RGBCOLOR(224, 224, 224);
    return foot;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}
// btn action
- (void)tapToNext:(UIGestureRecognizer *)gesture
{
    KpushTo(JRPastTotalGIftRecordController);
}
- (void)findTreasure:(id)sender
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    _push = YES;

}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.tabBarController.tabBar.hidden = YES;
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    if (_push) {
        UITabBarController * vc = self.navigationController.tabBarController;
        vc.selectedIndex = 2;
        vc.tabBar.hidden = NO;
    }
    self.tabBarController.tabBar.hidden = NO;
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
