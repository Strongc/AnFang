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
        _titleLab.frame = CGRectMake(15, 0, self.frame.size.width, self.frame.size.height);
        _titleLab.textAlignment = NSTextAlignmentLeft;
        _titleLab.font = [UIFont fontWithName:@"MicrosoftYaHei" size:24];
        _titleLab.textColor = [UIColor colorWithHexString:@"ce7031"];
        //_titleLab.backgroundColor = [UIColor colorWithHexString:@"ffd700"];
        [self addSubview:_titleLab];
        
        _moreBtn = [[UIButton alloc] init];
        _moreBtn.frame = CGRectMake(self.frame.size.width-103, 6, 88, 28);
        [self addSubview:_moreBtn];
        [_moreBtn addTarget:self action:@selector(clickClassVideoCell) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"more.png" ofType:nil];
        [_moreBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
        
        UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 88, 24)];
        title.text = @"更多";
        [_moreBtn addSubview:title];
        title.textAlignment = NSTextAlignmentCenter;
        title.font = [UIFont fontWithName:@"MicrosoftYaHei" size:24];
        title.textColor = [UIColor whiteColor];
        
        
    }
    return self;
}

/**
 *  点击cell调用的方法
 */
-(void)clickClassVideoCell
{
    if([self.delegate respondsToSelector:@selector(jumpToSheQuVideo:)]){
        
        [self.delegate jumpToSheQuVideo:self];
    }
    
}


@end
