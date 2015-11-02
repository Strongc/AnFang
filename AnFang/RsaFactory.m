//
//  RsaFactory.m
//  AnFang
//
//  Created by mac   on 15/10/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "RsaFactory.h"

@implementation RsaFactory

/**
 *	加密数据
 *
 *	@param 	data 	      要加密的数据
 *	@param 	Exponent      加密算法参数1
 *  @param 	Modulus       加密算法参数2
 */
+(NSString *) encryptDataWithData:(NSString *)data data2:(NSString *) Exponent andData3:(NSString *) Modulus
{
   
    BigInt *bigExponent = [BigInt createFromString:Exponent andRadix:10];
    BigInt *bigModulus = [BigInt createFromString:Modulus andRadix:10];
    
   // Byte *dataByte = (Byte *)[StringToBytes stringToBytes:data];
    
    //NSString *str = (NSString *)[StringToBytes BytesToString:dataByte];
    BigInt *bigData = [BigInt createFromString:data andRadix:10];
    
    BigInt *bigResult = [bigData modPow:bigExponent withMod:bigModulus];
    
    NSString *result = [bigResult toStringWithRadix:10];
    
    return result;

}


/**
 *	解密数据
 *
 *	@param 	encryptdata 	要解密的数据
 *	@param 	Exponent        解密算法参数1
 *  @param 	Modulus         解密算法参数2
 */
+(NSString *) decryptDataWithData:(NSString *)encryptdata data2:(NSString *)Exponent andData3:(NSString *)Modulus
{
    BigInt *bigData = [BigInt createFromString:encryptdata andRadix:10];
    BigInt *bigExponent = [BigInt createFromString:Exponent andRadix:10];
    BigInt *bigModulus = [BigInt createFromString:Modulus andRadix:10];
    
    BigInt *bigResult = [bigData modPow:bigExponent withMod:bigModulus];
    NSString *str = [bigResult toStringWithRadix:10];
    
    //Byte *byteData = [StringToBytes stringTo];
    
    //NSString *result = [StringToBytes bytesToString:byteData];
    
    return str;
}

@end
