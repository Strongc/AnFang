//
//  RSA.h
//  AnFang
//
//  Created by mac   on 15/10/8.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <openssl/rsa.h>


@interface RSA : NSObject
{
    SecKeyRef publicKey;
    SecCertificateRef certificate;

    SecPolicyRef policy;
    SecTrustRef trust;
    size_t maxPlainLen;
}

// return base64 encoded string
+ (NSString *)encryptString:(NSString *)str publicKey:(NSString *)pubKey;
// return raw data
+ (NSData *)encryptData:(NSData *)data publicKey:(NSString *)pubKey;
// return base64 encoded string
// enc with private key NOT working YET!
//+ (NSString *)encryptString:(NSString *)str privateKey:(NSString *)privKey;
// return raw data
//+ (NSData *)encryptData:(NSData *)data privateKey:(NSString *)privKey;

// decrypt base64 encoded string, convert result to string(not base64 encoded)
//+ (NSString *)decryptString:(NSString *)str publicKey:(NSDictionary *)pubKey;
+ (NSData *)decryptData:(NSData *)data publicKey:(NSString *)pubKey;
+ (NSString *)decryptString:(NSString *)str privateKey:(NSString *)privKey;
+ (NSData *)decryptData:(NSData *)data privateKey:(NSString *)privKey;

//生成密钥对
+(NSDictionary *)generateKeyPair:(NSInteger)length;

- (NSData *) encryptWithData:(NSData *)content;

- (NSData *) encryptWithString:(NSString *)content;

@end
