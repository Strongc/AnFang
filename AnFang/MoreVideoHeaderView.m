//
//  MoreVideoHeaderView.m
//  AnFang
//
//  Created by MyOS on 15/12/11.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "MoreVideoHeaderView.h"
#import "UIColor+Extensions.h"

@implementation MoreVideoHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(15, 0, self.frame.size.width, self.frame.size.height);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont fontWithName:@"MicrosoftYaHei" size:20];
        _titleLab.textColor = [UIColor colorWithHexString:@"ce7031"];
        [self addSubview:_titleLab];
        
    }
    return self;
}

@end
