//
//  PublicVideoClassCell.h
//  AnFang
//
//  Created by MyOS on 15/11/21.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicVideoClassModel.h"
#import "ShangMengClassModel.h"

@interface PublicVideoClassCell : UICollectionViewCell

/** 分类图片*/
@property (nonatomic,weak) UIImageView *publicVideoImage;

/** 分类名称*/
@property (nonatomic,weak) UILabel *className;

@property (nonatomic,weak) UIButton *backViewBtn;

@property (nonatomic,strong) PublicVideoClassModel *publicClass;

@property (nonatomic,strong) ShangMengClassModel *shangmengClassModel;

@end
