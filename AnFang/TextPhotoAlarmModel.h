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

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *message;
@property (nonatomic,copy) NSString *state;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) UIImage *image;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) TextPhotoAlarmModelWithDict:(NSDictionary *)dict;

@end
