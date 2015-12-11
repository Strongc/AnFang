//
//  RecommendCell.h
//  AnFang
//
//  Created by MyOS on 15/12/4.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecommendVideoCell.h"
#import "VMSNetSDK.h"
#import "PublicVideoClassCell.h"

@class RecommendCell;
@protocol RecommendCellDelegate <NSObject>

-(void)jumpToPlayView:(RecommendCell *) recommendCell;

@end

@interface RecommendCell : UITableViewCell<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UICollectionView *recommendVideo;
@property (nonatomic,strong) NSArray *recondVideoArray;
@property (nonatomic,strong) NSMutableArray *videoSourceArray;
@property (nonatomic,weak) id<RecommendCellDelegate> delegate;
@property (nonatomic, strong) CCameraInfo *cameraInfo;
@property (nonatomic,assign) int selectedIndex;

@end
