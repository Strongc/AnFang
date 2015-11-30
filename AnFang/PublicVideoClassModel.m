//
//  PublicVideoClassModel.m
//  AnFang
//
//  Created by MyOS on 15/11/21.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicVideoClassModel.h"

@implementation PublicVideoClassModel

-(PublicVideoClassModel *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
    
        self.classImage = dict[@"icon"];

        self.className = dict[@"name"];
        self.regionId = dict[@"regionId"];
        self.regionCount = dict[@"count"];
       
    }
    
    return self;
}

+(PublicVideoClassModel *)publicVideoClassModel:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
    
}

@end
