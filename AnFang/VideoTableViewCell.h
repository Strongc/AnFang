//
//  VideoTableViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VideoTableViewCell : UITableViewCell

/** 视频截图*/
@property (nonatomic,weak) UIImageView *videoImage;

/** 视频简介*/
@property (nonatomic,weak) UILabel *videoTitle;

/** 视频时间*/
@property (nonatomic,weak) UILabel * videoTime;

@end
