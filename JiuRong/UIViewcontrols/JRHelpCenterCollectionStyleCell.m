//
//  JRHelpCenterCollectionStyleCell.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRHelpCenterCollectionStyleCell.h"

@implementation JRHelpCenterCollectionStyleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
- (void)initUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, KScreenW,min((KScreenW-2)/3.0f,110)) collectionViewLayout:flowLayout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor lightGrayColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerNib:[UINib nibWithNibName:@"JRHelpCenterProjectCategoryCell" bundle:nil] forCellWithReuseIdentifier:@"JRHelpCenterProjectCategoryCellID"];
//        [self.collectionView registerClass:[JRHelpCenterProjectCategoryCell class] forCellWithReuseIdentifier:@"JRHelpCenterProjectCategoryCellID"];
   
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [self.collectionView reloadData];
    
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((KScreenW-2)/3.0f,min((KScreenW-2)/3.0f,110));
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 0.5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 0.5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JRHelpCenterProjectCategoryCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JRHelpCenterProjectCategoryCellID" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.centerImg.image = [UIImage imageNamed:self.imageArray[indexPath.row]];
    cell.centerLabel.text = self.dataArray[indexPath.row];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    self.selectItemAction(indexPath);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
