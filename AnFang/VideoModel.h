//
//  VideoModel.h
//  AnFang
//
//  Created by mac   on 15/10/30.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

@property (nonatomic,copy) NSString *videoUrl;
@property (nonatomic,copy) NSString *videoName;
@property (nonatomic,copy) NSString *videoTime;

-(instancetype) initWithDict:(NSDictionary *)dict;
+(instancetype) VideoWithDict:(NSDictionary *)dict;


@end
