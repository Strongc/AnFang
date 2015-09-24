//
//  PersonCenterTableViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/18.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PersonCenterTableViewCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@implementation PersonCenterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
     self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        UIImageView *cellImage = [[UIImageView alloc]initWithFrame:CGRectMake(15*WIDTH/375, 10*HEIGHT/667, 40*WIDTH/375, 40*HEIGHT/667)];
        cellImage.image = [UIImage imageNamed:@"alarm.png"];
        [self.contentView addSubview:cellImage];
        self.cellImage = cellImage;
        
        UILabel *cellTitle = [[UILabel alloc]initWithFrame:CGRectMake(80*WIDTH/375, 10*HEIGHT/667, 80*WIDTH/375, 40*HEIGHT/667)];
        cellTitle.text = @"北区停车过道出现可疑人物";
        //areaDetailInfo.numberOfLines = 0;
        cellTitle.textColor = [UIColor blackColor];
        cellTitle.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:cellTitle];
        self.cellTitle = cellTitle;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 59*HEIGHT/667, WIDTH, 1.0)];
        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self.contentView addSubview:line];
        
    }

     return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
