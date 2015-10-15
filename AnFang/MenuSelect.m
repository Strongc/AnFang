//
//  MenuSelect.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuSelect.h"

@implementation MenuSelect

-(MenuSelect *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        self.icon = dict[@"icon"];
        self.name = dict[@"title"];
        self.intruction = dict[@"intruction"];
        self.details = dict [@"detail"];
       // [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}

+(MenuSelect *)appWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
    
}

@end
