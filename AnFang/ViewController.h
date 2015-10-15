//
//  ViewController.h
//  AnFang
//
//  Created by mac   on 15/9/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WGAPI.h"
#import "SVProgressHUD.h"
#import "CMTool.h"
#import <Security/Security.h>

@interface ViewController : UIViewController
{

    UITextField *passWordField;
    UITextField *name;
    SecKeyRef publicKey;
    SecKeyRef privateKey;
    
    NSData *publicTag;
    NSData *privateTag;
    //SecKeyGeneratePair *
    //SecRandomRef
    
}

- (void)generateKeyPair:(NSUInteger)keySize;

@end

