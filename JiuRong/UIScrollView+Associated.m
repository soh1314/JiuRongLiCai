//
//  UIScrollView+Associated.m
//  RefreshTest
//
//  Created by CtreeOne on 15/11/18.
//  Copyright © 2015年 tion126. All rights reserved.
//

#import "UIScrollView+Associated.h"
#import <objc/runtime.h>

//static void *refreshIdf = (void *)@"refresh_view";
static void *kHeaderRefresh = (void *)@"kHeaderRefresh";
static void *qHeaderRefresh = (void *)@"qHeaderRefresh";

@implementation UIScrollView (Associated)

@dynamic refreshView;

- (TiRefreshView *)refreshView {
    return objc_getAssociatedObject(self, kHeaderRefresh);
}
- (QSRefreshView *)refreshView2
{
    return objc_getAssociatedObject(self, qHeaderRefresh);
}
- (void)setRefreshView2:(QSRefreshView *)refreshView2
{
    id header_ = [self refreshView2];
    if (header_) {
        [header_ removeFromSuperview];
    }
    if (refreshView2) {
        [self addSubview:refreshView2];
    }
    objc_setAssociatedObject(self, qHeaderRefresh, refreshView2, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (void)setRefreshView:(TiRefreshView *)refreshView {
    id header_ = [self refreshView];
    if (header_) {
        [header_ removeFromSuperview];
    }
    if (refreshView) {
        [self addSubview:refreshView];
    }
    objc_setAssociatedObject(self, kHeaderRefresh, refreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}



@end
