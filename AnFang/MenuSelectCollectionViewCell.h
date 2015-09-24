//
//  MenuSelectCollectionViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuSelectCollectionViewCell : UICollectionViewCell

/** 套餐图标*/
@property (nonatomic,weak) UIImageView *icon;

/** 套餐名称*/
@property (nonatomic,weak) UILabel *styleLab;

/** 套餐介绍*/
@property (nonatomic,weak) UILabel *menuIndruction;

@end
