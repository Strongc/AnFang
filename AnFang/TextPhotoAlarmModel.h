//
//  TextPhotoAlarmModel.h
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TextPhotoAlarmModel : NSObject


@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) UIImage *image;
@property (nonatomic,copy) NSString *imageUrl;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) TextPhotoAlarmModelWithDict:(NSDictionary *)dict;

@end
