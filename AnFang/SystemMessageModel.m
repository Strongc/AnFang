//
//  SystemMessageModel.m
//  AnFang
//
//  Created by mac   on 15/10/29.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "SystemMessageModel.h"

@implementation SystemMessageModel

-(SystemMessageModel *) initWithDict:(NSDictionary *)dict
{
    
    if(self = [super init]){
        
        self.time = dict[@"modifyDate"];
        self.content = dict[@"msg_content"];
        self.messageId = dict[@"msg_id"];
        self.messageSource = dict[@"msg_type"];
        
    }
    return self;
    
}

+(SystemMessageModel *) SystemMessageModelWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
}


@end
