//
//  HttpRequest.h
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HttpRequest : NSObject

/**
 *  发送一个GET请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;

/**
 *  发送一个POST请求
 *
 *  @param url     请求路径
 *  @param params  请求参数
 *  @param success 请求成功后的回调（请将请求成功后想做的事情写到这个block中）
 *  @param failure 请求失败后的回调（请将请求失败后想做的事情写到这个block中）
 */
//+ (void)post:(NSString *)url params:(NSDictionary *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;
+ (void)post:(NSString *)url params:(NSString *)params success:(void(^)(id responseObj))success failure:(void(^)(NSError *error))failure;


+(void)post:(NSString *)url params:(NSDictionary *)params FileData:(NSData*)filedata OpName:(NSString*)opname FileName:(NSString*)filename FileType:(NSString*)filetype success:(void(^)(id responseObj))success failure:(void(^)(NSError *))failure;

+(void)post:(NSString*)strUrl params:(NSDictionary *)params ImageDatas:(NSArray*)imageDatas Key:(NSString*)key success:(void(^)(id responseObj))success failure:(void(^)(NSError *))failure;
@end
