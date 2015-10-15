//
//  NeedHelpViewController.h
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>

@interface NeedHelpViewController : UIViewController<AVAudioRecorderDelegate>
{
    AVAudioRecorder *recorder;
    NSURL *urlPlay;
    NSTimer *timer;

}
@property(strong,nonatomic) AVAudioPlayer *avPalyer;

@end
