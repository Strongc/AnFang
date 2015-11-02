//
//  LocalVideo.m
//  AnFang
//
//  Created by mac   on 15/9/29.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "LocalVideoModel.h"

@implementation LocalVideoModel


-(LocalVideoModel *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        self.videoName = dict[@"name"];
       
        self.localVideoUrl = dict[@"url"];
        
    }
    
    return self;
}

+(LocalVideoModel *)monitorWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
    
}


@end
