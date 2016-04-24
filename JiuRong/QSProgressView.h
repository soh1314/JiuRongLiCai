//
//  QSProgressView.h
//  test-progressView
//
//  Created by 刘仰清 on 16/4/22.
//  Copyright © 2016年 刘仰清. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum tagLProgressType
{
    LProgressTypeAnnular,
    LProgressTypeCircle = 1,
    LProgressTypePie = 2
}
LProgressType;
@class QSProgressAppearance;
@interface QSProgressView : UIView



@property (assign, nonatomic) float progress;
@property (strong, nonatomic) QSProgressAppearance *progressAppearance;


@end


@interface QSProgressAppearance : NSObject


@property (assign, nonatomic) LProgressType type;
//percentage supported for LProgressTypeAnnular and LProgressTypeCircle
@property (assign, nonatomic) BOOL showPercentage;

//setting schemeColor will set progressTintColor, backgroundTintColor and percentageTextColor
@property (strong, nonatomic) UIColor *schemeColor;
@property (strong, nonatomic) UIColor *progressTintColor;
@property (strong, nonatomic) UIColor *backgroundTintColor;
@property (strong, nonatomic) UIColor *percentageTextColor;

@property (strong, nonatomic) UIFont *percentageTextFont;
@property (assign, nonatomic) CGPoint percentageTextOffset;


+ (QSProgressAppearance *)sharedProgressAppearance;


@end

