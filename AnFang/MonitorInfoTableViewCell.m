//
//  MonitorInfoTableViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MonitorInfoTableViewCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "UIView+KGViewExtend.h"

@interface MonitorInfoTableViewCell()




@end

@implementation MonitorInfoTableViewCell

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
        
        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5*WIDTH/375, 5*WIDTH/375,WIDTH-10*WIDTH/375, 75*WIDTH/375)];
        [self.contentView addSubview:lab];
        lab.backgroundColor = [UIColor whiteColor];
        
        UIImageView *areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(16*WIDTH/375, 9*WIDTH/375, 60*WIDTH/375, 67*WIDTH/375)];
        areaImage.image = [UIImage imageNamed:@"bg.png"];
        [self.contentView addSubview:areaImage];
        self.areaImage = areaImage;
        
        UILabel *areaName = [[UILabel alloc]initWithFrame:CGRectMake(90*WIDTH/375, 10*WIDTH/375, 200*WIDTH/375, 15*WIDTH/375)];
        areaName.text = @"防区001：华业大厦广场北区";
        areaName.textColor = [UIColor colorWithHexString:@"666666"];
        areaName.font = [UIFont systemFontOfSize:14*WIDTH/375];
        [self.contentView addSubview:areaName];
        self.areaName = areaName;
        
        UILabel *areaDetailInfo = [[UILabel alloc]initWithFrame:CGRectMake(90*WIDTH/375, 26*WIDTH/375, 230*WIDTH/375, 40*WIDTH/375)];
        //areaDetailInfo.text = @"dddfwfwefwefwefewfgwefweffhheffhwefwegfbhwefwefgbhwefwefhw";
        areaDetailInfo.numberOfLines = 0;
        areaDetailInfo.textColor = [UIColor colorWithHexString:@"666666"];
        areaDetailInfo.font = [UIFont systemFontOfSize:13*WIDTH/375];
        [self.contentView addSubview:areaDetailInfo];
        self.areaDetailInfo = areaDetailInfo;
    
    }

    return self;
}

-(void)setDefenceArea:(DefenceAreaModel *)defenceArea
{
    _defenceArea = defenceArea;
    
    self.areaName.text = [NSString stringWithFormat:@"%@",defenceArea.areaName];
    self.areaDetailInfo.text = [NSString stringWithFormat:@"%@",defenceArea.areaDetailInfo];



}

@end
