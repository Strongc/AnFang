//
//  VoiceAlarmCell.m
//  AnFang
//
//  Created by mac   on 15/10/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "VoiceAlarmCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "UIView+KGViewExtend.h"

@implementation VoiceAlarmCell

-(void)setVoiceModel:(VoiceAlarmModel *)voiceModel
{
    
    _voiceModel = voiceModel;
    self.timeLab.text = voiceModel.strVoiceTime;
    

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
    
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 24*HEIGHT/667)];
        timeLab.textAlignment = NSTextAlignmentCenter;
        timeLab.textColor = [UIColor colorWithHexString:@"666666"];
        timeLab.font = [UIFont systemFontOfSize:14*WIDTH/375];
        [self.contentView addSubview:timeLab];
        self.timeLab = timeLab;

        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(15*WIDTH/375, 24*HEIGHT/667, WIDTH-30*WIDTH/375, 80*HEIGHT/667)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backgroundView];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5*WIDTH/375, 5*HEIGHT/667, 60*WIDTH/375, 20*HEIGHT/667)];
        [backgroundView addSubview:titleLab];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        titleLab.text = @"语音报警";
        
        FSVoiceBubble *voiceBubble = [[FSVoiceBubble alloc] initWithFrame:CGRectMake(60*WIDTH/375, 20*HEIGHT/667, backgroundView.frame.size.width-120, 40*HEIGHT/667)];
        [backgroundView addSubview:voiceBubble];
        self.voiceBubble = voiceBubble;
        
        UILabel *stateLab = [[UILabel alloc]initWithFrame:CGRectMake(280*WIDTH/375, 60*HEIGHT/667, 50*WIDTH/375, 20*HEIGHT/667)];
        self.stateLab = stateLab;
        [backgroundView addSubview:stateLab];
        stateLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        stateLab.textAlignment = NSTextAlignmentRight;
        
//        UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(130*WIDTH/375, 33*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
//        [playBtn setTitle:@"播放语音" forState:UIControlStateNormal];
//        playBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
//        
//        self.playBtn = playBtn;
//        //[backgroundView addSubview:playBtn];
//        [playBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//        [playBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        
        
    
    }
    
    return self;
    
}


- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
