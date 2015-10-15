//
//  RsaFactory.h
//  AnFang
//
//  Created by mac   on 15/10/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StringToBytes.h"
#import "BigInt.h"

@interface RsaFactory : NSObject

//加密数据
+(NSString *) encryptDataWithData:(NSString *)data data2:(NSString *) Exponent andData3:(NSString *) Modulus;

//解密数据
+(NSString *) decryptDataWithData:(NSString *)data data2:(NSString *) Exponent andData3:(NSString *) Modulus;

@end
