//
//  ResourceTreeViewController.h
//  Demo-SDK3.0
//
//  Created by HuYafeng on 15/9/1.
//  Copyright (c) 2015年 sunda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMSNetSDK.h"

@interface ResourceTreeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) CMSPInfo *mspInfo;
@property (nonatomic, copy)   NSString *serverAddress;
@property (nonatomic, strong) CControlUnitInfo *controlUnitInfo;
@property (nonatomic, strong) CRegionInfo *regionInfo;

@end
