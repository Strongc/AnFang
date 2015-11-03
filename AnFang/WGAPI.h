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
//用户登录
#define API_USER_LOGIN @"user/login"
//分页获取用户信息
#define API_GET_USERINFO @"user/page"
//获取用户信息
#define API_GET_USEDATA  @"user/getUser"
//获取报警数据
#define API_GET_ALARMINFO @"alarm/page"
//获取防区数据
#define API_GET_AREAINFO @"area/page"
//获取摄像头数据
#define API_GET_CAMERAINFO @"camera/page"
//获取主机数据
#define API_GET_HOSTINFO @"host/page"
//获取消息数据
#define API_GET_MESSAGEINFO @"message/page"
//获取单位数据
#define API_GET_ORGANIZATIONINFO @"organization/page"
//获取传感器数据
#define API_GET_SENSORINFO @"sensor/page"
//获取任务数据
#define API_GET_TASKINFO @"task/page"
//获取视频资源
#define API_GET_VIDEOINFO @"video/page"
//获取系统分组数据
#define API_GET_SYSGROUPINFO @"sysGroup/page"
//获取系统角色数据
#define API_GET_SYSROLEINFO @"sysRole/page"
//获取系统权限数据
#define API_GET_SYSPERMISSIONINFO @"sysPermission/page"
//布防
#define API_ADDLINE @"host/addLine"
//撤防
#define API_REMOVELINE @"host/removeLine"

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
