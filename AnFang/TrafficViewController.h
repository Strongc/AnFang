//
//  TrafficViewController.h
//  AnFang
//
//  Created by MyOS on 15/12/8.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LMComBoxView.h"
#import "VMSNetSDK.h"

@interface TrafficViewController : UIViewController<LMComBoxViewDelegate,UIScrollViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,copy) NSString *itemStr;
@property (nonatomic,copy) NSString *regionId;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, strong) CMSPInfo *mspInfo;
@property (nonatomic, strong) UICollectionView *trafficEvent;
@property (nonatomic, strong) UICollectionView *roadVideoList;
@property (nonatomic, assign) int type;

@end
