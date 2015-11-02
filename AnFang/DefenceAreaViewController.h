//
//  DefenceAreaViewController.h
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DefenceAreaViewController : UIViewController

/** 防区照片*/
@property (nonatomic,weak) UIImageView *areaImage;

/** 防区名称*/
@property (nonatomic,weak) UILabel *areaName;

/** 防区信息*/
@property (nonatomic,weak) UILabel *areaDetailInfo;

@property (nonatomic,copy) NSString *defenceAreaName;

@end
