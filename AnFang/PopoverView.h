//
//  PopoverView.h
//  AnBao
//
//  Created by mac   on 15/9/17.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PopoverViewChooseDelegate <NSObject>

@optional

-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index;

@end

@protocol PopoverViewChooseDataSource <NSObject>

-(NSInteger)numberOfSections;
-(NSInteger)numberOfRowsInSection:(NSInteger)section;
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index;
-(NSInteger)defaultShowSection:(NSInteger)section;


@end

@interface PopoverView : UIView

-(id)initWithPoint:(CGPoint)point titles:(NSArray *)titles images:(NSArray *)images;
-(void)show;
-(void)dismiss;
-(void)dismiss:(BOOL)animated;

@property (nonatomic, copy) UIColor *borderColor;
@property (nonatomic, copy) void (^selectRowAtIndex)(NSInteger index);
@property (nonatomic, assign) id<PopoverViewChooseDelegate> dropDownDelegate;
@property (nonatomic, assign) id<PopoverViewChooseDataSource> dropDownDataSource;


@end
