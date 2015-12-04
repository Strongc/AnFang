//
//  ClassVideoCell.h
//  AnFang
//
//  Created by MyOS on 15/12/4.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClassVideoCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *videoClass;
@property (nonatomic,strong) NSArray *classDataArray;

@end
