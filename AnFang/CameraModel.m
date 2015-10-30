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
        self.cameraName = dict[@"cam_model"];
        
        if(dict[@"is_access"]){
        
            self.cameraState = @"已关闭";
        }else {
        
            self.cameraState = @"工作正常";
        }
        
        self.cameraId = dict[@"cam_id"];
        self.cameraParam = dict[@"cam_param"];
        self.cameraVendor = dict[@"cam_vendor"];
    }
    
    return self;
}

+(CameraModel *) CameraWithDict:(NSDictionary *)dict
{

    return [[self alloc] initWithDict:dict];
}

@end
