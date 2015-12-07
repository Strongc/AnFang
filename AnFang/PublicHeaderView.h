//
//  PublicHeaderViewCollectionReusableView.h
//  AnFang
//
//  Created by MyOS on 15/11/8.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PublicHeaderView;
@protocol PublicHeaderViewDelegate <NSObject>

-(void)jumpToSheQuVideo:(PublicHeaderView *)publicHeaderView;

@end

@interface PublicHeaderView : UICollectionReusableView

@property (strong,nonatomic) UILabel *titleLab;
@property (strong,nonatomic) UIButton *moreBtn;
@property (nonatomic,weak) id<PublicHeaderViewDelegate> delegate;

@end
