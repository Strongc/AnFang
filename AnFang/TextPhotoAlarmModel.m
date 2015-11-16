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
    
    if(self = [super init]){
        
//        self.icon = dict[@"icon"];
        self.message = dict[@"content"];
//        self.state = dict[@"state"];
        self.time = dict[@"createDate"];
        self.imageUrl = dict[@"image_url"];
    }
    return self;
    
}

+(TextPhotoAlarmModel *) TextPhotoAlarmModelWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
    
}


@end
