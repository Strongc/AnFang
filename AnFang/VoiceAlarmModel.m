//
//  VoiceAlarmModel.m
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "VoiceAlarmModel.h"

@implementation VoiceAlarmModel

-(VoiceAlarmModel *) initWithDict:(NSDictionary *)dict
{
    
    if(self = [super init]){
        
        self.voice = dict[@"voice"];
        self.strVoiceTime = dict[@"time"];
        self.voiceStr = dict[@"voice_url"];
        
    }
    return self;
    
}

+(VoiceAlarmModel *) VoiceAlarmModelWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
    
}

@end
