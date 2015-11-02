//
//  PublicVideoSource.h
//  AnBao
//
//  Created by mac   on 15/9/23.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicVideoSource : NSObject

/** 视频序号*/
@property (nonatomic,copy) NSString *videoId;

/** 视频的地址*/
@property (nonatomic,copy) NSString *videoUrl;

/** 视频的截图*/
@property (nonatomic,copy) NSString *videoImage;

/** 视频的时间*/
@property (nonatomic,copy) NSString *videoTime;

/** 视频的名称*/
@property (nonatomic,copy) NSString *videoName;

-(PublicVideoSource *)initWithDict:(NSDictionary *)dict;
+(PublicVideoSource *)videoWithDict:(NSDictionary *)dict;

@end
