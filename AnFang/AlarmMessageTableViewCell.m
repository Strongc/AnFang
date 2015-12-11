//
//  AlarmMessageTableViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AlarmMessageTableViewCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"

@interface AlarmMessageTableViewCell ()

///** 防区照片*/
//@property (nonatomic,weak) UIImageView *areaImage;



@end

@implementation AlarmMessageTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAlarmMessage:(AlarmMessageModel *)alarmMessage
{
    _alarmMessage = alarmMessage;
    
    self.messageTime.text = alarmMessage.time;
    self.messageInfo.text = alarmMessage.content;
    self.messageSource.text = alarmMessage.messageSource;
    
}

-(void)setSysMessage:(SystemMessageModel *)sysMessage
{

    _sysMessage = sysMessage;
    self.messageInfo.text = sysMessage.content;
    self.messageTime.text = sysMessage.time;
    self.messageSource.text = sysMessage.messageSource;

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        UIView *background = [[UIView alloc] initWithFrame:CGRectMake(15, 24, WIDTH-30, 60)];
        background.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:background];
        
        UILabel *messageSource = [[UILabel alloc] initWithFrame:CGRectMake(80, 30,WIDTH-80, 20)];
        [self.contentView addSubview:messageSource];
        messageSource.font = [UIFont systemFontOfSize:18];
        messageSource.textColor = [UIColor blueColor];
        self.messageSource = messageSource;
        
        UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH-80, 10, 60, 15)];
        [self.contentView addSubview:timeLab];
        timeLab.font = [UIFont systemFontOfSize:13];
        timeLab.text = @"更新时间";
        
        UIImageView *areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 25, 50, 50*HEIGHT/667)];
        areaImage.image = [UIImage imageNamed:@"alert"];
        [self.contentView addSubview:areaImage];
        //self.areaImage = areaImage;
        
        UILabel *messageTime = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-130)/2, 10, 130, 12)];
        //messageTime.text = @"2015-5-21  23:25";
        messageTime.textColor = [UIColor blackColor];
        messageTime.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:messageTime];
        self.messageTime = messageTime;
        
        UILabel *areaDetailInfo = [[UILabel alloc]initWithFrame:CGRectMake(80, 50, 100, 30)];
        //areaDetailInfo.text = @"食堂防区异常";
        //areaDetailInfo.numberOfLines = 0;
        areaDetailInfo.textColor = [UIColor blackColor];
        areaDetailInfo.font = [UIFont fontWithName:@"MicrosoftYaHei" size:16];
        [self.contentView addSubview:areaDetailInfo];
        self.messageInfo = areaDetailInfo;
        
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 70, WIDTH, 1.0)];
//        line.backgroundColor = [UIColor grayColor];
//        [self.contentView addSubview:line];
        
//        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(280*WIDTH/375, 40*HEIGHT/667, 90*WIDTH/375, 14*HEIGHT/667)];
//        
//        [btn setTitle:@"点击查看详情" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor colorWithHexString:@"a9a9a9"] forState:UIControlStateNormal];
//        btn.titleLabel.font = [UIFont systemFontOfSize:13*WIDTH/375];
//        [self.contentView addSubview:btn];
//        self.checkBtn = btn;
        
        //self.areaDetailInfo = areaDetailInfo;
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
    
}


@end
