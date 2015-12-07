//
//  PublicSourceItemViewController.h
//  AnFang
//
//  Created by MyOS on 15/11/23.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMSNetSDK.h"
#import "LMComBoxView.h"

@interface PublicSourceItemViewController : UIViewController<LMComBoxViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic, copy) NSString *itemStr;
@property (nonatomic, copy) NSString *regionId;
@property (nonatomic, strong) CMSPInfo *mspInfo;
@property (nonatomic, copy)  NSString *serverAddress;
@property (nonatomic, strong) CControlUnitInfo *controlUnitInfo;
@property (nonatomic, strong) CRegionInfo *regionInfo;
@property (nonatomic, strong) NSMutableArray *SectionList;

@end
