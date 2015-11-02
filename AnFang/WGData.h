//
//  WGData.h
//  AnFang
//
//  Created by mac   on 15/9/30.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGUserInfo.h"
#import "AppDelegate.h"

@interface WGData : NSObject

+ (NSString*) getStringInDefByKey:(NSString*)key;

+ (NSString*) getStringInDefByKey:(NSString*)key Default:(NSString*) strDefault;
+(NSString *)getUserName;
+(NSString *)getPwd;
+(NSString *)getuserId;

+(void)setUser:(NSDictionary *)user;
+(WGUserInfo *)getUser;


@end
