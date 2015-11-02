//
//  AccountCollectionViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCollectionViewCell : UICollectionViewCell

/** 金额数量*/
@property (nonatomic,weak) UILabel *accountLab;

- (void)setHightlightBackground:(BOOL)isSelected withAimate:(BOOL)animate;
- (void)setNormalBackground:(BOOL)animate;
- (void)setHightlightBackground;

@end
