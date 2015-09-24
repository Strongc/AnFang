//
//  MenuTimeTableViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuTimeTableViewCell : UITableViewCell

/** 套餐名称*/
@property (nonatomic,weak) UILabel *menuTime;

/** 套餐介绍*/
@property (nonatomic,weak) UILabel *menuPrice;

- (void)setHightlightBackground:(BOOL)isSelected withAimate:(BOOL)animate;
- (void)setNormalBackground:(BOOL)animate;
- (void)setHightlightBackground;

@end
