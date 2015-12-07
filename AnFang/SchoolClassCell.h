//
//  SchoolClassCell.h
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SchoolClassModel.h"

@interface SchoolClassCell : UICollectionViewCell
/** 分类图片*/
@property (nonatomic,weak) UIImageView *titleImage;

/** 分类名称*/
@property (nonatomic,weak) UILabel *titleName;

@property (nonatomic,strong) SchoolClassModel *schoolClassModel;

@end
