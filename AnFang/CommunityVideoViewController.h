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
#import "PublicHeaderView.h"

@interface  CommunityVideoViewController: UIViewController<PublicHeaderViewDelegate,LMComBoxViewDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,copy) NSString *regionId;
@property (nonatomic, copy) NSString *serverAddress;
@property (nonatomic, strong) CMSPInfo *mspInfo;
@property (nonatomic,copy) NSString *itemStr;
@property (nonatomic,assign) int countStr;
@property (nonatomic,strong) UITableView *publicItemTable;
@property (nonatomic,strong) UICollectionView *videoCollectionView;

@end
