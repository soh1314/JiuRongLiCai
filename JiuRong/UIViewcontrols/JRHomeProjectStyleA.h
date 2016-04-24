//
//  JRHomeProjectStyleA.h
//  YingbaFinance
//
//  Created by jingshuihuang on 16/4/20.
//  Copyright © 2016年 huoqiangshou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JRHomeStyleA.h"
@interface JRHomeProjectStyleA : UITableViewCell<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(nonatomic,retain)UICollectionView * collectionView;
@property (nonatomic,copy)NSArray * dataArray;

@end
