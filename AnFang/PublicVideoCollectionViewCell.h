//
//  PublicVideoCollectionViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/17.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PublicVideoSource.h"


@interface PublicVideoCollectionViewCell : UICollectionViewCell

/** 视频截图*/
@property (nonatomic,weak) UIImageView *publicVideoImage;

/** 视频简介*/
@property (nonatomic,weak) UILabel *videoTitle;

/** 视频时间*/
@property (nonatomic,weak) UILabel * videoTimeLab;

@property (nonatomic,strong) PublicVideoSource *publicSource;
@end
