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

-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if(self){
        
        UIImageView *publicVideoImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        [self.contentView addSubview:publicVideoImage];
        self.publicVideoImage = publicVideoImage;
        
        UILabel *className = [[UILabel alloc]initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
        className.font = [UIFont boldSystemFontOfSize:14];
        className.textColor = [UIColor colorWithHexString:@"ffffff"];
        className.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:className];
        self.className = className;
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-40, self.frame.size.width, 40)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.65;
        
    }
    
    self.backgroundColor = [UIColor clearColor];
    return self;


}


@end
