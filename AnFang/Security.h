//
//  Security.h
//  AnFang
//
//  Created by mac   on 15/10/13.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/Foundation.h>
#import <Security/Security.h>
#import <CommonCrypto/CommonDigest.h>

@interface Security : NSObject
{

    SecKeyRef _privateKey;
    SecKeyRef _publicKey;
}

@property (nonatomic, readonly) SecKeyRef privateKey;
@property (nonatomic, readonly) SecKeyRef publicKey;

+ (Security *)sharedSecurity;

// 可以从PKCS#12文件中提取身份、信任、证书、公钥、私钥，这里，我们只需要保留私钥
- (OSStatus)extractEveryThingFromPKCS12File:(NSString *)pkcsPath passphrase:(NSString *)pkcsPassword;
// 从证书文件中提取公钥
- (OSStatus)extractPublicKeyFromCertificateFile:(NSString *)certPath;
// RSA公钥加密，支持长数据加密
- (NSData *)encryptWithPublicKey:(NSData *)plainData;
// RSA私钥解密，支持长数据解密
- (NSData *)decryptWithPrivateKey:(NSData *)cipherData;

@end
