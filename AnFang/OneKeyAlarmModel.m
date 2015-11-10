//
//  OneKeyAlarmModel.m
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "OneKeyAlarmModel.h"

@implementation OneKeyAlarmModel

-(OneKeyAlarmModel *) initWithDict:(NSDictionary *)dict
{

    if(self = [super init]){
        
        self.time = dict[@"createDate"];
        self.location = dict[@"content"];
        self.state = dict[@"is_access"];
        
    }
    return self;

}

+(OneKeyAlarmModel *) OneKeyAlarmModelWithDict:(NSDictionary *)dict
{
    
     return [[self alloc] initWithDict:dict];

}

@end
