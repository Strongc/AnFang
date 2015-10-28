//
//  VoiceAlarmCell.h
//  AnFang
//
//  Created by mac   on 15/10/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VoiceAlarmModel.h"
#import "FSVoiceBubble.h"

@interface VoiceAlarmCell : UITableViewCell

@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *stateLab;
@property (nonatomic,strong) VoiceAlarmModel *voiceModel;
@property (nonatomic,strong) UIButton *playBtn;

@property (strong, nonatomic) UIImageView *portraitImageView;
@property (strong, nonatomic) FSVoiceBubble *voiceBubble;
@end
