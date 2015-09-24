//
//  DefenceAreaDevTableViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefenceAreaDevTableViewCell : UITableViewCell

/** 设备照片*/
@property (nonatomic,weak) UIImageView *devImage;

/** 设备名称*/
@property (nonatomic,weak) UILabel *devName;

/** 设备状态*/
@property (nonatomic,weak) UILabel *devState;

@end
