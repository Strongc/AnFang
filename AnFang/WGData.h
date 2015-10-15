//
//  WGData.h
//  AnFang
//
//  Created by mac   on 15/9/30.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WGUserData.h"

@interface WGData : NSObject

+ (NSString*) getStringInDefByKey:(NSString*)key;

+ (NSString*) getStringInDefByKey:(NSString*)key Default:(NSString*) strDefault;

// 查询登录返回的token

+(void)setToken:(NSString*)token;
+(void)setVersion:(NSString*)Version;
+(void)setUserId:(NSString *)userId;
+(void)setUserName:(NSString *)name;
+(void)setPassword:(NSString *)password;

+(void)setLoginType:(BOOL )type;
+(BOOL)getLoginType;

+(NSString*) getToken;
+(NSString*) getVersion;
+(NSString*) getUserName;
+(NSString*) getUserId;
+(NSString*)getPassword;


@end
