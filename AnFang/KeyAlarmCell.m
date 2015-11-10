//
//  KeyAlarmCell.m
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "KeyAlarmCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "UIView+KGViewExtend.h"

@implementation KeyAlarmCell

-(void)setOneKeyAlarm:(OneKeyAlarmModel *)oneKeyAlarm
{
    
   // NSString *str = @"位置:";
    //NSString *str1 = oneKeyAlarm.location;
    
    _oneKeyAlarm = oneKeyAlarm;
    self.timeLab.text = oneKeyAlarm.time;
    self.locationLab.text = oneKeyAlarm.location;
    //self.stateLab.text = oneKeyAlarm.state;

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
        self.contentView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(15*WIDTH/375, 24*HEIGHT/667, WIDTH-30*WIDTH/375, 44*HEIGHT/667)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backgroundView];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5*WIDTH/375, 5*HEIGHT/667, 60*WIDTH/375, 20*HEIGHT/667)];
        [backgroundView addSubview:titleLab];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        titleLab.text = @"一键报警";
        
        UILabel *locationLab = [[UILabel alloc]initWithFrame:CGRectMake(80*WIDTH/375, 5*HEIGHT/667, 220*WIDTH/375, 30*HEIGHT/667)];
        self.locationLab = locationLab;
        locationLab.numberOfLines = 0;
        [backgroundView addSubview:locationLab];
        locationLab.textAlignment = NSTextAlignmentCenter;
        locationLab.textColor = [UIColor blackColor];
        locationLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        
        UILabel *stateLab = [[UILabel alloc]initWithFrame:CGRectMake(280*WIDTH/375, 25*HEIGHT/667, 50*WIDTH/375, 20*HEIGHT/667)];
        self.stateLab = stateLab;
        [backgroundView addSubview:stateLab];
        stateLab.textAlignment = NSTextAlignmentRight;
        NSString *content = self.stateLab.text;
        if([content isEqualToString:@"已发送"]){
            
            self.stateLab.textColor = [UIColor greenColor];
        }
        else{
             self.stateLab.textColor = [UIColor redColor];
        }
        
        stateLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        
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
