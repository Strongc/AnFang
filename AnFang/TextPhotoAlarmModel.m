//
//  TextPhotoAlarmModel.m
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "TextPhotoAlarmModel.h"

@implementation TextPhotoAlarmModel

-(TextPhotoAlarmModel *) initWithDict:(NSDictionary *)dict
{
    NSString *const CMAPIBaseURL = @"http://192.168.0.41:8080";
    if(self = [super init]){
       
        NSString *dictUrl = dict[@"image_url"];
        self.message = dict[@"content"];
        self.time = dict[@"createDate"];
        self.imageUrl = [CMAPIBaseURL stringByAppendingString:dictUrl];
        
    }
    return self;
    
}

+(TextPhotoAlarmModel *) TextPhotoAlarmModelWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
    
}


@end
