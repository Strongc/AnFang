//
//  RecommendVideoCell.h
//  AnFang
//
//  Created by MyOS on 15/12/5.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendVideoModel.h"

@interface RecommendVideoCell : UICollectionViewCell

/** 分类图片*/
@property (nonatomic,weak) UIImageView *publicVideoImage;

/** 分类名称*/
@property (nonatomic,weak) UILabel *className;

@property (nonatomic,weak) UIButton *backViewBtn;

@property (nonatomic,strong) RecommendVideoModel *recommendVideoModel;


@end
