//
//  LocalVideo.h
//  AnFang
//
//  Created by mac   on 15/9/29.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LocalVideoModel : NSObject

@property (nonatomic,copy) NSString *videoName;
@property (nonatomic,copy) NSString *localVideoUrl;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) monitorWithDict:(NSDictionary *)dict;

@end
