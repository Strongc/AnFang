//
//  PublicVideoitemViewController.h
//  AnFang
//
//  Created by MyOS on 15/11/27.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"
#import "VMSNetSDK.h"

@interface PublicVideoitemViewController : UIViewController<LMComBoxViewDelegate>

@property (nonatomic,copy) NSString *regionId;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, strong) CMSPInfo *mspInfo;

@end
