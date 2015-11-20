//
//  VideoListViewController.h
//  AnBao
//
//  Created by mac   on 15/9/8.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMSNetSDK.h"

@interface VideoListViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

//@property (nonatomic) MHTabBarController *mhtTabBarController;
@property (nonatomic, strong) CMSPInfo *mspInfo;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, strong) CControlUnitInfo *controlUnitInfo;
@property (nonatomic, strong) CRegionInfo *regionInfo;

@end
