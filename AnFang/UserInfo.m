//
//  UserInfo.m
//  AnFang
//
//  Created by mac   on 15/10/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "UserInfo.h"
#import "WGData.h"
#import "CoreArchive.h"

@implementation UserInfo

+(void)saveUserId:(NSString *)userId
{

    [CoreArchive setStr:userId key:[WGData getUserName]];

}

+(NSString *)getUserId
{

    return [CoreArchive strForKey:[WGData getUserName]];

}

@end
