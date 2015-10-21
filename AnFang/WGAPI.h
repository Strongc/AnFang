//
//  WGAPI.h
//  AnFang
//
//  Created by mac   on 15/9/30.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

#define RESULT @"result"
#define API_USER_LOGIN @"user/login"
typedef enum{

  WGResultTypeDictionary,
  PYResultTypeArray
}WGResultType;

@interface WGResult : NSObject

@property BOOL succeed;
@property NSString *code;
@property NSMutableDictionary *result;

@end


@interface WGResultSET : NSObject
@property NSString* key;//自定义的key
@property WGResultType type;//PYResultTypeDictionary:Dictionary PYResultTypeArray:Array//

- (instancetype)initWithKey:(NSString*)key Type:(WGResultType) type;

@end


@interface WGResetValueKey : NSObject

@property NSString *mynewKey;
@property NSString *oldKey;

-(instancetype)initNewkey:(NSString*)newkey OldKey:(NSString*)oldkey;

@end


@interface WGAPI : NSObject

+(void)checkWeb:(void (^)())end;
+(BOOL)checkWeb;


+(NSDictionary*) httpAsynchronousRequestUrl:(NSString*) spec postStr:(NSString *)sData;
/**
    get请求
 */
+ (void)getUrl:(NSString*) url Param:(NSDictionary*) param Settings:settings completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;

/**
    post请求
 */
+ (void)postUrl:(NSString*) url Param:(NSString *) param Settings:settings completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;

//+ (void)postUrl:(NSString*) url Param:(NSString*) param Settings:settings completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;

+ (void)uploadUrl:(NSString*) url Param:(NSDictionary*) param  Image:(NSString*)imagePath  WithCompletion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;

+(void)postUrl:(NSString *)url Param:(NSDictionary *)param Settings:(id)settings FileData:(NSData*)filedata OpName:(NSString*)opname FileName:(NSString*)filename FileType:(NSString*)filetype completion:(void (^)(BOOL succeed,NSDictionary* detailDict,NSError *error))completion;

+(void)postUrl:(NSString*)url Param:(NSDictionary *)param ImageDatas:(NSArray*)imageDatas Settings:(id)settings completion:(void (^)(BOOL, NSDictionary *, NSError *))completion;

+ (void)post:(NSString *)URL RequestParams:(NSString *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block;

+ (NSString *)parseParams:(NSDictionary *)params;

@end
