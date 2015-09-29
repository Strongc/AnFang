//
//  MonitorInfoTableViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DefenceAreaModel.h"

@interface MonitorInfoTableViewCell : UITableViewCell

@property (nonatomic,strong) DefenceAreaModel *defenceArea;

///** 防区照片*/
//@property (nonatomic,weak) UIImageView *areaImage;
//
///** 防区名称*/
//@property (nonatomic,weak) UILabel *areaName;
//
///** 防区信息*/
//@property (nonatomic,weak) UILabel *areaDetailInfo;


/** 设备照片*/
@property (nonatomic,weak) UIImageView *devImage;

/** 设备名称*/
@property (nonatomic,weak) UILabel *devName;

/** 设备状态*/
@property (nonatomic,weak) UILabel *devState;

@end
