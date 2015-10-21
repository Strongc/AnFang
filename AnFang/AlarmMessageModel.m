//
//  AlarmMessage.m
//  AnFang
//
//  Created by mac   on 15/10/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AlarmMessageModel.h"

@implementation AlarmMessageModel

-(AlarmMessageModel *) initWithDict:(NSDictionary *)dict
{

    if(self = [super init]){
        
        self.time = dict[@"modifyDate"];
        self.content = dict[@"alrm_info"];
        self.messageId = dict[@"alrm_id"];
        
    }
    return self;

}

+(AlarmMessageModel *) AlarmMessageModelWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];
}
@end
