//
//  MenuConfig.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuConfig.h"

@implementation MenuConfig

-(MenuConfig *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        self.time = dict[@"time"];
        self.price = dict[@"price"];
       // [self setValuesForKeysWithDictionary:dict];
       
    }
    
    return self;
}

+(MenuConfig *)appWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
    
}


@end
