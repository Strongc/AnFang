//
//  PhotoAlarmCell.h
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TextPhotoAlarmModel.h"
#import "UIImageView+WebCache.h"

@interface PhotoAlarmCell : UITableViewCell

@property (nonatomic,strong) UILabel *messageLab;
@property (nonatomic,strong) UIImageView *locationImage;
@property (nonatomic,strong) UILabel *stateLab;
@property (nonatomic,strong) TextPhotoAlarmModel *photoKeyAlarm;
@property (nonatomic,strong) UILabel *timeLab;

@end
