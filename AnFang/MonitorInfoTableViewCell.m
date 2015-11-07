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

-(void)setCameraModel:(CameraModel *)cameraModel
{
    _cameraModel = cameraModel;
    self.devName.text = cameraModel.cameraName;
    self.devState.text = cameraModel.cameraState;
    
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
//        UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(5*WIDTH/375, 5*HEIGHT/667,WIDTH-10*WIDTH/375, 60*HEIGHT/667)];
//        [self.contentView addSubview:lab];
//        lab.backgroundColor = [UIColor whiteColor];
        
        UIImageView *areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(16*WIDTH/375, 9*HEIGHT/667, 60*WIDTH/375, 50*HEIGHT/667)];
        areaImage.image = [UIImage imageNamed:@"dev.png"];
        [self.contentView addSubview:areaImage];
        self.devImage = areaImage;
        
        UILabel *areaName = [[UILabel alloc]initWithFrame:CGRectMake(90*WIDTH/375, 15*HEIGHT/667, 200*WIDTH/375, 15*HEIGHT/667)];
        //areaName.text = @"大楼西侧朝南监控";
        areaName.textColor = [UIColor colorWithHexString:@"666666"];
        areaName.font = [UIFont systemFontOfSize:14*WIDTH/375];
        [self.contentView addSubview:areaName];
        self.devName = areaName;
        
        UILabel *areaDetailInfo = [[UILabel alloc]initWithFrame:CGRectMake(90*WIDTH/375, 26*HEIGHT/667, 230*WIDTH/375, 40*HEIGHT/667)];
        //areaDetailInfo.text = @"工作正常";
        //areaDetailInfo.numberOfLines = 0;
        areaDetailInfo.textColor = [UIColor colorWithHexString:@"666666"];
        areaDetailInfo.font = [UIFont systemFontOfSize:13*WIDTH/375];
        [self.contentView addSubview:areaDetailInfo];
        self.devState = areaDetailInfo;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 79*HEIGHT/667, WIDTH, 1)];
        line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
        [self.contentView addSubview:line];
        
    }

    return self;
}

//-(void)setDefenceArea:(DefenceAreaModel *)defenceArea
//{
//    _defenceArea = defenceArea;
//    
//    self.areaName.text = [NSString stringWithFormat:@"%@",defenceArea.areaName];
//    self.areaDetailInfo.text = [NSString stringWithFormat:@"%@",defenceArea.areaDetailInfo];
//
//
//
//}

@end
