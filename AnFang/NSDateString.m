//
//  NSDateString.m
//  AnFang
//
//  Created by mac   on 15/10/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "NSDateString.h"

@implementation NSDateString

+(NSString *)stringFromDate:(NSDate *)date
{

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    NSString *destDateString = [dateFormatter stringFromDate:date];

    return destDateString;
}

+(NSString *)ret32bitString

{
    
    char data[3];
    
    for (int x=0;x<3;data[x++] = (char)('A' + (arc4random_uniform(26))));
    
    return [[NSString alloc] initWithBytes:data length:3 encoding:NSUTF8StringEncoding];
    
}

@end
