//
//  DefenceAreaModel.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "DefenceAreaModel.h"

@implementation DefenceAreaModel

-(DefenceAreaModel *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        //self.areaId = dict[@"id"];
        //self.photoPath = dict[@"url"];
        self.photoPath = dict[@"icon"];
        self.devState = dict[@"state"];
        self.devName = dict[@"name"];
        self.videoUrl = dict[@"url"];
        //[self setValuesForKeysWithDictionary:dict];
    }
    
    return self;
}

+(DefenceAreaModel *)monitorWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
    
}



@end
