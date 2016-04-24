//
//  UINavigationBar+Awesome.m
//  LTNavigationBar
//
//  Created by ltebean on 15-2-15.
//  Copyright (c) 2015 ltebean. All rights reserved.
//

#import "UINavigationBar+Awesome.h"
#import <objc/runtime.h>

@implementation UINavigationBar (Awesome)
//static char overlayKey;

- (UIView *)overlaykey
{
    return objc_getAssociatedObject(self, @selector(overlaykey));
}

- (void)setOverlaykey:(UIView *)overlaykey
{
    objc_setAssociatedObject(self, @selector(overlaykey), overlaykey, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)lt_setBackgroundColor:(UIColor *)backgroundColor
{
    if (!self.overlaykey) {
        [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
        self.overlaykey = [[UIView alloc] initWithFrame:CGRectMake(0, -20, [UIScreen mainScreen].bounds.size.width, CGRectGetHeight(self.bounds) + 20)];
        self.overlaykey.userInteractionEnabled = NO;
        self.overlaykey.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self insertSubview:self.overlaykey atIndex:0];
    }
    self.overlaykey.backgroundColor = backgroundColor;
}

- (void)lt_setTranslationY:(CGFloat)translationY
{
    self.transform = CGAffineTransformMakeTranslation(0, translationY);
}

- (void)lt_setElementsAlpha:(CGFloat)alpha
{
    [[self valueForKey:@"_leftViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    [[self valueForKey:@"_rightViews"] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger i, BOOL *stop) {
        view.alpha = alpha;
    }];
    
    UIView *titleView = [self valueForKey:@"_titleView"];
    titleView.alpha = alpha;
//    when viewController first load, the titleView maybe nil
    [[self subviews] enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:NSClassFromString(@"UINavigationItemView")]) {
            obj.alpha = alpha;
            *stop = YES;
        }
    }];
}

- (void)lt_reset
{
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.overlaykey removeFromSuperview];
    self.overlaykey = nil;
}

@end
