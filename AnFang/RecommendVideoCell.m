//
//  RecommendVideoCell.m
//  AnFang
//
//  Created by MyOS on 15/12/5.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "RecommendVideoCell.h"
#import "UIColor+Extensions.h"

@implementation RecommendVideoCell

-(void)setRecommendVideoModel:(RecommendVideoModel *)recommendVideoModel
{
    
    _recommendVideoModel = recommendVideoModel;
    //self.publicVideoImage.image = [UIImage imageNamed:recommendVideoModel.classImage];
    self.className.text = recommendVideoModel.className;
    
}

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self){
        
        UIImageView *publicVideoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:publicVideoImage];
        self.publicVideoImage = publicVideoImage;
        
        UILabel *className = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-45, self.frame.size.width, 50)];
        className.font = [UIFont boldSystemFontOfSize:14];
        className.textColor = [UIColor whiteColor];
        className.numberOfLines = 0;
        className.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:className];
        self.className = className;
        UIButton *backViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
        [self.contentView addSubview:backViewBtn];
        backViewBtn.backgroundColor = [UIColor blackColor];
        backViewBtn.alpha = 0.45;
        self.backViewBtn = backViewBtn;
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;
    
    
}


@end
