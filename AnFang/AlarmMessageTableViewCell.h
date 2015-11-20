//
//  AlarmMessageTableViewCell.h
//  AnBao
//
//  Created by mac   on 15/9/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmMessageModel.h"
#import "SystemMessageModel.h"

@interface AlarmMessageTableViewCell : UITableViewCell

/** 报警时间*/
@property (nonatomic,weak) UILabel *messageTime;

/** 防区信息*/
@property (nonatomic,weak) UILabel *messageInfo;

//@property (nonatomic,weak) UIButton *checkBtn;

@property (nonatomic,strong) AlarmMessageModel *alarmMessage;

@property (nonatomic,strong) SystemMessageModel *sysMessage;
/** 资讯来源*/
@property (nonatomic,weak) UILabel *messageSource;
@end
