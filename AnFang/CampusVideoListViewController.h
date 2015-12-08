//
//  CampusVideoListViewController.h
//  AnFang
//
//  Created by MyOS on 15/12/8.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CampusVideoListViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *campusVideoView;
@end
