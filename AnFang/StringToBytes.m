//
//  StringToBytes.m
//  AnFang
//
//  Created by mac   on 15/10/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "StringToBytes.h"

@implementation StringToBytes

+(Byte *)stringToBytes:(NSString *)str
{

    NSData *testData = [str dataUsingEncoding: NSUTF8StringEncoding];
    Byte* bytes = (Byte*)[testData bytes];

    return bytes;
}

+(NSString *)bytesToString:(Byte *)bytes
{
    NSInteger size = sizeof(bytes)-2;
    
    NSData *testData = [[NSData alloc] initWithBytes:bytes length:size];
    NSString *testString = [[NSString alloc] initWithData:testData encoding:NSUTF8StringEncoding];
    
    return testString;

}

+(Byte *)bigDataToBytes:(BigInt *)bigData
{
   
    NSString *str = [bigData toStringWithRadix:10];
    
    return [self stringToBytes:str];
}

+(NSInteger)getUnsignedByte:(Byte)data
{

    return data&0x0FF;

}

+(NSString *)BytesToString:(Byte *)bytes
{
    NSString *result = @"";
    NSString *charCode = @"";
    
    for(int i=0;i< sizeof(bytes)-2;i++){
        
        NSInteger unsignByte = [self getUnsignedByte:bytes[i]];
        NSString *str1 = [NSString stringWithFormat:@"%ld",(long)unsignByte];
        charCode = [@"" stringByAppendingString:str1];
        if(charCode.length < 2){
          
            charCode = [@"00" stringByAppendingString:charCode];
        }else if (charCode.length < 3){
        
            charCode = [@"0" stringByAppendingString:charCode];
        }
    
        result = [result stringByAppendingString:charCode];
    }
    
    return result;
}

+(Byte *)stringTobytes:(NSString *)str
{
    
    NSInteger n = str.length;
    Byte *byteBuf;
    for(int i=0; i<n/3; i++){
        
        NSRange range = NSMakeRange(i*3, 4);
        NSString *subStr = [str substringWithRange:range];
        NSInteger intStr = subStr.integerValue;
        byteBuf[i] = (Byte)intStr;
    
    }
   
    return byteBuf;
}

@end
