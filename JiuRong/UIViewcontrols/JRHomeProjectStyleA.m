//
//  JRHomeProjectStyleA.m
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import "JRHomeProjectStyleA.h"

@implementation JRHomeProjectStyleA

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
        self.frame = frame;
    }
    return self;
}
- (void)initUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, 375,150) collectionViewLayout:flowLayout];
    [self addSubview:self.collectionView];
    self.collectionView.backgroundColor = [UIColor redColor];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
        [self.collectionView registerNib:[UINib nibWithNibName:@"JRHomeStyleA" bundle:nil] forCellWithReuseIdentifier:@"JRHomeStyleColCellID"];
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.bounds.size.width-30), self.bounds.size.height);
}
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 15, 0, 15);
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 5;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section;
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JRHomeStyleA * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"JRHomeStyleColCellID" forIndexPath:indexPath];
    cell.centerImage.image = [UIImage imageNamed:@"零元夺宝.png"];
    return cell;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
