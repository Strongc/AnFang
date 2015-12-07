//
//  TitleCell.m
//  AnFang
//
//  Created by MyOS on 15/12/4.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "TitleCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"

@implementation TitleCell

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
        
        UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(15, 0, WIDTH-30, 40)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = [UIColor colorWithHexString:@"121d56"];
        
        UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 100, backView.frame.size.height)];
        [backView addSubview:title2];
        title2.textAlignment = NSTextAlignmentLeft;
        title2.text = @"推荐视频";
        title2.font = [UIFont boldSystemFontOfSize:20];
        title2.textColor = [UIColor colorWithHexString:@"ce7031"];
        
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
    
}

@end
