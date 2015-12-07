//
//  schoolClassModel.m
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "SchoolClassModel.h"

@implementation SchoolClassModel

-(SchoolClassModel *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        self.titleImage = dict[@"icon"];
        self.titleName = dict[@"name"];
        
    }
    
    return self;
}

+(SchoolClassModel *)schoolClassModelWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
    
}


@end
