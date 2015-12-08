//
//  SchoolClassCell.m
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "SchoolClassCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"

@implementation SchoolClassCell

-(void)setSchoolClassModel:(SchoolClassModel *)schoolClassModel
{
    _schoolClassModel = schoolClassModel;
    self.titleImage.image = [UIImage imageNamed:schoolClassModel.titleImage];
    self.titleName.text = schoolClassModel.titleName;

}

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self){
        
        UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 40*WIDTH/375, 40*HEIGHT/667)];
        [self.contentView addSubview:titleImage];
        self.titleImage = titleImage;
        
        UILabel *titleName = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-20*HEIGHT/667, self.frame.size.width, 20*HEIGHT/667)];
        titleName.font = [UIFont boldSystemFontOfSize:14*HEIGHT/667];
        titleName.textColor = [UIColor colorWithHexString:@"ce7031"];
        titleName.numberOfLines = 0;
        titleName.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:titleName];
        self.titleName = titleName;
        
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;
    
}

@end
