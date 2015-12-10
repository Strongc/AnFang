//
//  CommunityViewController.h
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VMSNetSDK.h"

@interface CommunityViewController : UIViewController<UICollectionViewDataSource,UIBarPositioningDelegate,UICollectionViewDelegateFlowLayout>

@property(nonatomic,copy) NSString *communityName;
@property(nonatomic,strong) NSMutableArray *videoSourceArray;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, strong) CMSPInfo *mspInfo;


@end
