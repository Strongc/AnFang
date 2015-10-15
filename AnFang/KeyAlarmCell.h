//
//  KeyAlarmCell.h
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OneKeyAlarmModel.h"

@interface KeyAlarmCell : UITableViewCell

@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *locationLab;
@property (nonatomic,strong) UILabel *stateLab;
@property (nonatomic,strong) OneKeyAlarmModel *oneKeyAlarm;

@end
