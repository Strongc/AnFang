//
//  UserInfo.h
//  AnFang
//
//  Created by mac   on 15/10/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

+ (NSString*)getUserId;
+ (void)saveUserId:(NSString*)userId;

@end
