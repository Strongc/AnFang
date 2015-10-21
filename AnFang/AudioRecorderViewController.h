//
//  AudioRecorderViewController.h
//  AnFang
//
//  Created by mac   on 15/10/19.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AudioRecoderDelegate <NSObject>

-(void) flushRecoder:(NSMutableArray *)arrayMutable;

@end

@interface AudioRecorderViewController : UIViewController
@property (nonatomic,weak) id<AudioRecoderDelegate> delegate;

@end
