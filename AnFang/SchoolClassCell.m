//
//  SchoolClassCell.m
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "SchoolClassCell.h"
#import "UIColor+Extensions.h"

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
        
        UIImageView *titleImage = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, 40, 40)];
        [self.contentView addSubview:titleImage];
        self.titleImage = titleImage;
        
        UILabel *titleName = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-25, self.frame.size.width, 30)];
        titleName.font = [UIFont boldSystemFontOfSize:14];
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
