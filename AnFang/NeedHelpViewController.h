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
#import "ImagePickerViewController.h"
#import "FSVoiceBubble.h"
#import "CCLocationManager.h"
#import "UUInputFunctionView.h"
#import "UUMessageCell.h"

@interface NeedHelpViewController : UIViewController<CLLocationManagerDelegate,PickImageDelegate,UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,UUInputFunctionViewDelegate,UUMessageCellDelegate>
{
    AVAudioRecorder *recorder;
    NSURL *urlPlay;
}
@property (nonatomic,strong) UIView *netStatusInfo;
@property (nonatomic,strong) UIButton *refreshBtn;

@end
