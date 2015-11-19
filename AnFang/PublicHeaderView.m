//
//  PublicHeaderViewCollectionReusableView.m
//  AnFang
//
//  Created by MyOS on 15/11/8.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicHeaderView.h"
#import "UIColor+Extensions.h"

@implementation PublicHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        _titleLab = [[UILabel alloc]init];
        _titleLab.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
        _titleLab.textAlignment = NSTextAlignmentCenter;
        _titleLab.font = [UIFont fontWithName:@"MicrosoftYaHei" size:24];
        _titleLab.backgroundColor = [UIColor colorWithHexString:@"ffd700"];
        [self addSubview:_titleLab];
        
    }
    return self;
}

@end
