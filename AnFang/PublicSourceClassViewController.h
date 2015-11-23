//
//  PublicSourceClassViewController.h
//  AnFang
//
//  Created by MyOS on 15/11/21.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMSNetSDK.h"

@interface PublicSourceClassViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) CMSPInfo *mspInfo;
@property (nonatomic, copy)  NSString *serverAddress;
@property (nonatomic, strong) CControlUnitInfo *controlUnitInfo;
@property (nonatomic, strong) CRegionInfo *regionInfo;


@end
