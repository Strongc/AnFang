//
//  VoiceAlarmModel.h
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VoiceAlarmModel : NSObject

@property (nonatomic,copy) NSData *voice;
@property (nonatomic,copy) NSString *strVoiceTime;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) VoiceAlarmModelWithDict:(NSDictionary *)dict;

@end
