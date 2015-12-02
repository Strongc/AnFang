//
//  ShangMengClassModel.m
//  AnFang
//
//  Created by MyOS on 15/12/2.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "ShangMengClassModel.h"

@implementation ShangMengClassModel

-(ShangMengClassModel *)initWithDict:(NSDictionary *)dict
{

    if(self = [super init]){
        
        self.classImage = dict[@"icon"];
        self.className = dict[@"name"];
    }
    
    return self;
}

+(ShangMengClassModel *)shangMengClassModel:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];
}

@end
