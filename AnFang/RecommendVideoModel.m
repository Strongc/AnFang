//
//  RecommendVideoModel.m
//  AnFang
//
//  Created by MyOS on 15/12/5.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "RecommendVideoModel.h"

@implementation RecommendVideoModel

-(RecommendVideoModel *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        
        self.classImage = dict[@"icon"];
        
        self.className = dict[@"name"];
        self.regionId = dict[@"regionId"];
        self.regionCount = dict[@"count"];
        
    }
    
    return self;
}

+(RecommendVideoModel *)recommendVideoClassModel:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
    
}

@end
