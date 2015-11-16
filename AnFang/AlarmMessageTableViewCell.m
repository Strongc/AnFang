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
  
}


-(void)setSysMessage:(SystemMessageModel *)sysMessage
{

    _sysMessage = sysMessage;
    self.messageInfo.text = sysMessage.content;
    self.messageTime.text = sysMessage.time;

}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,WIDTH-10, 60)];
       // [self.contentView addSubview:lab];
        lab.backgroundColor = [UIColor whiteColor];
        
        UIImageView *areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 60*HEIGHT/667)];
        areaImage.image = [UIImage imageNamed:@"alarm.png"];
        [self.contentView addSubview:areaImage];
        //self.areaImage = areaImage;
        
        UILabel *messageTime = [[UILabel alloc]initWithFrame:CGRectMake(90, 15, 200, 15)];
        //messageTime.text = @"2015-5-21  23:25";
        messageTime.textColor = [UIColor blackColor];
        messageTime.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:messageTime];
        self.messageTime = messageTime;
        
        UILabel *areaDetailInfo = [[UILabel alloc]initWithFrame:CGRectMake(80, 26, 200, 40)];
        //areaDetailInfo.text = @"食堂防区异常";
        //areaDetailInfo.numberOfLines = 0;
        areaDetailInfo.textColor = [UIColor blackColor];
        areaDetailInfo.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:areaDetailInfo];
        self.messageInfo = areaDetailInfo;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 64*HEIGHT/667, WIDTH, 1.0)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
        
        UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(280*WIDTH/375, 40*HEIGHT/667, 90*WIDTH/375, 14*HEIGHT/667)];
        
        [btn setTitle:@"点击查看详情" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"a9a9a9"] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13*WIDTH/375];
        [self.contentView addSubview:btn];
        self.checkBtn = btn;
        
        //self.areaDetailInfo = areaDetailInfo;
        
    }
    
    return self;
    
}


@end
