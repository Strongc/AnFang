//
//  PublicVideoClassCell.m
//  AnFang
//
//  Created by MyOS on 15/11/21.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicVideoClassCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"

@implementation PublicVideoClassCell

-(void)setPublicClass:(PublicVideoClassModel *)publicClass
{
    
    _publicClass = publicClass;
    self.publicVideoImage.image = [UIImage imageNamed:publicClass.classImage];
    self.className.text = publicClass.className;

}

-(void)setShangmengClassModel:(ShangMengClassModel *)shangmengClassModel
{
    
    _shangmengClassModel = shangmengClassModel;
    self.publicVideoImage.image = [UIImage imageNamed:shangmengClassModel.classImage];
    self.className.text = shangmengClassModel.className;
    
}

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if(self){
        
        UIImageView *publicVideoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:publicVideoImage];
        self.publicVideoImage = publicVideoImage;
        
        UILabel *className = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
        className.font = [UIFont boldSystemFontOfSize:14];
        className.textColor = [UIColor colorWithHexString:@"ededed"];
        className.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:className];
        self.className = className;
        UIButton *backViewBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
        [self.contentView addSubview:backViewBtn];
        backViewBtn.backgroundColor = [UIColor blackColor];
        backViewBtn.alpha = 0.35;
        self.backViewBtn = backViewBtn;
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;


}


@end
