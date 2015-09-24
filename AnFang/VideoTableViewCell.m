//
//  VideoTableViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "VideoTableViewCell.h"
#import "Common.h"

@implementation VideoTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5, 5,WIDTH-10, 60)];
        // [self.contentView addSubview:lab];
        lab.backgroundColor = [UIColor whiteColor];
        
        UIImageView *videoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, 50, 60)];
        videoImage.image = [UIImage imageNamed:@"alarm.png"];
        [self.contentView addSubview:videoImage];
        self.videoImage = videoImage;
        
        UILabel *videoTime = [[UILabel alloc]initWithFrame:CGRectMake(250, 18, 200, 15)];
        videoTime.text = @"2015-5-21  23:25";
        videoTime.textColor = [UIColor blackColor];
        videoTime.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:videoTime];
        self.videoTime = videoTime;
        
        UILabel *videoTitle = [[UILabel alloc]initWithFrame:CGRectMake(80, 5, 230, 40)];
        videoTitle.text = @"北区停车过道出现可疑人物";
        //areaDetailInfo.numberOfLines = 0;
        videoTitle.textColor = [UIColor blackColor];
        videoTitle.font = [UIFont systemFontOfSize:13];
        [self.contentView addSubview:videoTitle];
        self.videoTitle = videoTitle;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 64*HEIGHT/667, WIDTH, 1.0)];
        line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:line];
        
        
    }
    
    return self;
    
}


@end
