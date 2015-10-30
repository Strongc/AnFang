//
//  JRPlayerViewController.h
//  JRVideoPlayer
//
//  Created by 湛家荣 on 15/5/8.
//  Copyright (c) 2015年 Zhan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "ASIHTTPRequest.h"

@interface JRPlayerViewController : UIViewController<AVAudioPlayerDelegate>
{
    ASIHTTPRequest *videoRequest;
    unsigned long long Recordull;
    BOOL isPlay;

}

@property (nonatomic,copy) NSString *mediaTitle;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,copy) NSString *videoName;
@property (nonatomic,copy) NSString *cameraId;

- (instancetype)initWithHTTPLiveStreamingMediaURL:(NSURL *)url;
- (instancetype)initWithLocalMediaURL:(NSURL *)url;

@end
