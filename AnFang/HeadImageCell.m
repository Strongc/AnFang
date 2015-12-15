//
//  HeadImageCell.m
//  AnFang
//
//  Created by MyOS on 15/12/4.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "HeadImageCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@implementation HeadImageCell

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
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"head.png" ofType:nil];
        UIImageView *headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, -10, WIDTH-30, 150)];
        [self.contentView addSubview:headImageView];
        headImageView.image = [UIImage imageWithContentsOfFile:path];
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, headImageView.frame.size.height-40, headImageView.frame.size.width, 40)];
        [headImageView addSubview:backView];
        backView.backgroundColor = [UIColor blackColor];
        backView.alpha = 0.65;
        UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height)];
        [backView addSubview:title1];
        title1.textAlignment = NSTextAlignmentCenter;
        title1.text = @"最热门点击视频";
        title1.font = [UIFont boldSystemFontOfSize:14];
        title1.textColor = [UIColor whiteColor];
        
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 76, backView.frame.size.height)];
        [backView addSubview:title2];
        title2.textAlignment = NSTextAlignmentCenter;
        title2.text = @"热门视频";
        title2.font = [UIFont boldSystemFontOfSize:18];
        title2.textColor = [UIColor colorWithHexString:@"db0303"];
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;

}

@end
