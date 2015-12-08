//
//  SchoolVideoViewController.h
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SchoolVideoViewController : UIViewController<UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView *schoolClassView;

@property (nonatomic,strong) UICollectionView *schoolVideoView;

@end
