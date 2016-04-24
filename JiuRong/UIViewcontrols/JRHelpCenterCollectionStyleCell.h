//
//  JRHelpCenterCollectionStyleCell.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/21.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRHelpCenterProjectCategoryCell.h"
@interface JRHelpCenterCollectionStyleCell : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,retain)UICollectionView * collectionView;
@property (nonatomic,copy)NSArray * dataArray;
@property (nonatomic,copy)NSArray * imageArray;
@property (nonatomic,copy)void(^selectItemAction)(NSIndexPath * index);
- (void)setDataArray:(NSArray *)dataArray;
@end
