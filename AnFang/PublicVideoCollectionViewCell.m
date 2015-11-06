//
//  PublicVideoCollectionViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/17.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PublicVideoCollectionViewCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@implementation PublicVideoCollectionViewCell

-(void)setPublicSource:(PublicVideoSource *)publicSource
{
    _publicSource = publicSource;
    
    self.publicVideoImage.image = [UIImage imageNamed:publicSource.videoImage];
    self.videoTimeLab.text = publicSource.videoTime;
    self.videoTitle.text = publicSource.videoName;

}

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if(self){
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        UIImageView *publicVideoImage = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH/375, 10*HEIGHT/667, 80*WIDTH/375, 80*HEIGHT/667)];
        [self.contentView addSubview:publicVideoImage];
        self.publicVideoImage = publicVideoImage;
        
        UILabel *videoTitle = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH/375, 95*HEIGHT/667, 90*WIDTH/375, 40*HEIGHT/667)];
        videoTitle.numberOfLines = 0;
        videoTitle.font = [UIFont systemFontOfSize:10*WIDTH/375];
        videoTitle.textColor = [UIColor blackColor];
       // [videoTitle sizeToFit];
        [self.contentView addSubview:videoTitle];
        self.videoTitle = videoTitle;
        
        UILabel *videoTimeLab = [[UILabel alloc]initWithFrame:CGRectMake(60*WIDTH/375, 120*HEIGHT/667, 60*WIDTH/375, 10*HEIGHT/667)];
        videoTimeLab.font = [UIFont systemFontOfSize:10];
        videoTimeLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:videoTimeLab];
        self.videoTimeLab = videoTimeLab;
    
    }
    
    return self;
}

@end
