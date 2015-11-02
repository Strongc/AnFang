//
//  VideoModel.m
//  AnFang
//
//  Created by mac   on 15/10/30.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "VideoModel.h"

@implementation VideoModel

-(VideoModel *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        self.videoName = dict[@"video_name"];
        self.videoUrl = dict[@"video_url"];
        self.videoTime = dict[@"createDate"];
        
    }
    
    return self;
}

+(VideoModel *) VideoWithDict:(NSDictionary *)dict
{
    
    return [[self alloc] initWithDict:dict];
}


@end
