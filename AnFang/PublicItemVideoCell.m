//
//  PublicItemVideoCell.m
//  AnFang
//
//  Created by MyOS on 15/11/23.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicItemVideoCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@implementation PublicItemVideoCell

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
        
        UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(20, 0,WIDTH-40, 60)];
        [self.contentView addSubview:backView];
        backView.backgroundColor = [UIColor colorWithHexString:@"082e54"];
        
        UILabel *videoNameLab = [[UILabel alloc] initWithFrame:CGRectMake(80, 10,WIDTH-80, 18)];
        [backView addSubview:videoNameLab];
        videoNameLab.font = [UIFont systemFontOfSize:16];
        videoNameLab.textColor = [UIColor whiteColor];
        self.videoNameLab = videoNameLab;
        
        UILabel *stateLab = [[UILabel alloc]initWithFrame:CGRectMake((WIDTH-130)/2, 10, 130, 12)];
        stateLab.textColor = [UIColor whiteColor];
        stateLab.font = [UIFont systemFontOfSize:12];
        [backView addSubview:stateLab];
        self.stateLab = stateLab;
    
    
    }
    self.backgroundColor = [UIColor clearColor];
    return self;
}

@end
