//
//  PhotoAlarmCell.m
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PhotoAlarmCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "UIView+KGViewExtend.h"

@implementation PhotoAlarmCell


-(void)setPhotoKeyAlarm:(TextPhotoAlarmModel *)photoKeyAlarm
{
    
    _photoKeyAlarm = photoKeyAlarm;
    self.messageLab.text = photoKeyAlarm.message;
    NSString *strUrl = photoKeyAlarm.imageUrl;
    if(strUrl==nil){
        self.locationImage.image = photoKeyAlarm.image;
    }else{
        NSURL *url = [NSURL URLWithString:strUrl];
        [self.locationImage setImageWithURL:url];
    }
    self.timeLab.text = photoKeyAlarm.time;

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

        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(15*WIDTH/375, 24*HEIGHT/667, WIDTH-30*WIDTH/375, 90*HEIGHT/667)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backgroundView];
        
        UILabel *messageLab = [[UILabel alloc] initWithFrame:CGRectMake(80*WIDTH/375, 20*HEIGHT/667, 180*WIDTH/375, 80*HEIGHT/667)];
        messageLab.textAlignment = NSTextAlignmentCenter;
        messageLab.textColor = [UIColor colorWithHexString:@"666666"];
        messageLab.numberOfLines = 0;
        messageLab.font = [UIFont systemFontOfSize:12*WIDTH/375];
        [backgroundView addSubview:messageLab];
        self.messageLab = messageLab;
        //self.contentView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5*WIDTH/375, 5*HEIGHT/667, 60*WIDTH/375, 20*HEIGHT/667)];
        [backgroundView addSubview:titleLab];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        titleLab.text = @"图文报警";
        
        UIImageView *locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
        [backgroundView addSubview:locationImage];
      
        self.locationImage = locationImage;
        
        UILabel *stateLab = [[UILabel alloc]initWithFrame:CGRectMake(280*WIDTH/375, 70*HEIGHT/667, 50*WIDTH/375, 20*HEIGHT/667)];
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
    self.backgroundColor = [UIColor clearColor];
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
