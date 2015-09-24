//
//  PublicVideoSource.m
//  AnBao
//
//  Created by mac   on 15/9/23.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PublicVideoSource.h"

@implementation PublicVideoSource

-(PublicVideoSource *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        self.videoId = dict[@"id"];
        self.videoUrl = dict[@"url"];
        self.videoImage = dict[@"icon"];
        self.videoTime = dict[@"time"];
        self.videoName = dict[@"name"];
        
    }
    
    return self;
}

+(PublicVideoSource *)videoWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
    
}


@end
