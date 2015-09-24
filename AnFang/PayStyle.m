//
//  PayStyle.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PayStyle.h"

@implementation PayStyle

-(PayStyle *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
    
        self.icon = dict[@"icon"];
    
    }

    return self;
}

+(PayStyle *)appWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];

}

@end
