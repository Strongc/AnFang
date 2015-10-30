//
//  CameraModel.h
//  AnFang
//
//  Created by mac   on 15/10/29.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CameraModel : NSObject

@property(nonatomic,copy) NSString *cameraName;
@property(nonatomic,copy) NSString *cameraState;
@property(nonatomic,copy) NSString *cameraId;
@property(nonatomic,copy) NSString *cameraParam;
@property(nonatomic,copy) NSString *cameraVendor;

//@property(nonatomic,copy) NSString *videoUrl;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) CameraWithDict:(NSDictionary *)dict;


@end
