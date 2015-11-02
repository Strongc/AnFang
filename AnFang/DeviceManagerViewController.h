//
//  DeviceManagerViewController.h
//  AnBao
//
//  Created by mac   on 15/9/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceManagerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,copy) NSString *deviceName;
@property (nonatomic,copy) NSString *deviceState;
@property (nonatomic,copy) NSString *devVendor;
@property (nonatomic,copy) NSString *devParam;
@property (nonatomic,copy) NSString *devModel;
@property (nonatomic,copy) NSString *devId;

@end
