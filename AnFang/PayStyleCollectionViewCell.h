//
//  PayStyleCollectionViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PayStyleCollectionViewCell : UICollectionViewCell

/** 付款方式*/
@property (nonatomic,weak) UIImageView *payStyle;

- (void)setHightlightBackground:(BOOL)isSelected withAimate:(BOOL)animate;
- (void)setNormalBackground:(BOOL)animate;
- (void)setHightlightBackground;

@end
