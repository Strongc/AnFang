//
//  StringToBytes.h
//  AnFang
//
//  Created by mac   on 15/10/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BigInt.h"

@interface StringToBytes : NSObject

//字符串转字节数组
+(Byte *)stringToBytes:(NSString *)str;

//字节数组转字符串
+(NSString *)bytesToString:(Byte *)bytes;

//Big型数据转字节数组
+(Byte *)bigDataToBytes:(BigInt *)bigData;

//将data字节型数据转换为0~255 (0xFF 即BYTE)
+(NSInteger) getUnsignedByte:(Byte) data;

//将字节数组已字符串的形式输出
+(NSString *) BytesToString:(Byte *) bytes;

//将字符串转换为字节数组
+(Byte *) stringTobytes:(NSString *) str;

@end
