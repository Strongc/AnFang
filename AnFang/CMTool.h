//
//  CMTool.h
//  CM
//
//  Created by 付晨鸣 on 14/12/23.
//  Copyright (c) 2014年 AventLabs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "NSDate+TimeAgo.h"
//#import "MD5.h"

@interface CMTool : NSObject

//判断网络连接状态
+(BOOL) isConnectionAvailable;

+ (NSString*)dictionaryToJson:(NSDictionary *)dic;
+ (NSDictionary *)parseJSONStringToNSDictionary:(NSString *)JSONString;
+ (NSDictionary*) strDic:(NSString*) str;
@end
