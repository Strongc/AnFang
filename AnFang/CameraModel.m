//
//  CameraModel.m
//  AnFang
//
//  Created by mac   on 15/10/29.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "CameraModel.h"

@implementation CameraModel

-(CameraModel *)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        self.cameraName = dict[@"cam_vendor"];
        self.cameraState = dict[@"deleteStatus"];
        self.cameraId = dict[@"cam_id"];
    }
    
    return self;
}

+(CameraModel *) CameraWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];
}

@end
