//
//  PlayViewController.m
//  Demo-SDK3.0
//
//  Created by HuYafeng on 15/9/1.
//  Copyright (c) 2015年 sunda. All rights reserved.
//

#import "PlayViewController.h"
#import "VideoPlaySDK.h"
#import "VideoPlayInfo.h"
#import "CaptureInfo.h"
#import "VideoPlayUtility.h"
#import "RecordInfo.h"
#import "Common.h"

static void *_vpHandle = NULL;

@interface PlayViewController ()

@property (strong, nonatomic) UIView *playView;
@property (strong, nonatomic) UIImageView *captureImageView;

@end

@implementation PlayViewController {
    CRealPlayURL *_realPlayURL;
    VP_HANDLE _handle;
    BOOL _isPlayBacking;
    CGFloat _startPlayBackTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _playView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*HEIGHT/667, WIDTH, 225*HEIGHT/667)];
    _playView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_playView];

    //[self initControlData];
    // Do any additional setup after loading the view from its nib.
}

//配置界面的控件
-(void)initControlData
{

    _playView = [[UIView alloc] initWithFrame:CGRectMake(0, 70*HEIGHT/667, WIDTH, 225*HEIGHT/667)];
    _playView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_playView];
    
    UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(43*WIDTH/375, 362*HEIGHT/667, 100*WIDTH/375, 30*HEIGHT/667)];
    field.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:field];
    
    UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(60*WIDTH/375, 354*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    playBtn.titleLabel.text = @"预览";
    playBtn.titleLabel.textColor = [UIColor blueColor];
    playBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:playBtn];
    
    UIButton *stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(98*WIDTH/375, 362*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    stopBtn.titleLabel.text = @"停止";
    stopBtn.titleLabel.textColor = [UIColor blueColor];
    stopBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:stopBtn];
    
    UIButton *pictureBtn = [[UIButton alloc]initWithFrame:CGRectMake(182*WIDTH/375, 362*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    pictureBtn.titleLabel.text = @"抓图";
    pictureBtn.titleLabel.textColor = [UIColor blueColor];
    pictureBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:pictureBtn];
    
    _captureImageView = [[UIImageView alloc]initWithFrame:CGRectMake(214*WIDTH/375, 353*HEIGHT/667, 70*WIDTH/375, 45*HEIGHT/667)];

    UITextField *field1 = [[UITextField alloc] initWithFrame:CGRectMake(30*WIDTH/375, 406*HEIGHT/667, 122*WIDTH/375, 30*HEIGHT/667)];
    field1.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:field1];
    
    UIButton *repeatedBtn = [[UIButton alloc]initWithFrame:CGRectMake(38*WIDTH/375, 406*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    repeatedBtn.titleLabel.text = @"回放";
    repeatedBtn.titleLabel.textColor = [UIColor blueColor];
    repeatedBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:repeatedBtn];
    
    UIButton *pauseBtn = [[UIButton alloc]initWithFrame:CGRectMake(76*WIDTH/375, 406*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    pauseBtn.titleLabel.text = @"暂停";
    pauseBtn.titleLabel.textColor = [UIColor blueColor];
    pauseBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:pauseBtn];
    
    UIButton *stopBtn1 = [[UIButton alloc]initWithFrame:CGRectMake(114*WIDTH/375, 406*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    stopBtn1.titleLabel.text = @"停止";
    stopBtn1.titleLabel.textColor = [UIColor blueColor];
    stopBtn1.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:stopBtn1];
    
    UITextField *field2 = [[UITextField alloc] initWithFrame:CGRectMake(187*WIDTH/375, 406*HEIGHT/667, 122*WIDTH/375, 30*HEIGHT/667)];
    field2.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:field2];
    
    UIButton *videoBtn = [[UIButton alloc]initWithFrame:CGRectMake(203*WIDTH/375, 406*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    videoBtn.titleLabel.text = @"录像";
    videoBtn.titleLabel.textColor = [UIColor blueColor];
    videoBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:videoBtn];

    UIButton *stopBtn2 = [[UIButton alloc]initWithFrame:CGRectMake(241*WIDTH/375, 406*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    stopBtn2.titleLabel.text = @"停止";
    stopBtn2.titleLabel.textColor = [UIColor blueColor];
    stopBtn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.view addSubview:stopBtn2];

    UIView *controlView = [[UIView alloc] initWithFrame:CGRectMake(33*WIDTH/375, 461*HEIGHT/667, 254*WIDTH/375, 87*HEIGHT/667)];
    controlView.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview:controlView];
    
    UIButton *upBtn = [[UIButton alloc]initWithFrame:CGRectMake(38*WIDTH/375, 8*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    [controlView addSubview:upBtn];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(99*WIDTH/375, 8*HEIGHT/667, 56*WIDTH/375, 21*HEIGHT/667)];
    title.textColor = [UIColor grayColor];
    title.text = @"云台控制";
    title.font = [UIFont systemFontOfSize:14];
    [controlView addSubview:title];
    
    UIButton *stopBtn3 = [[UIButton alloc]initWithFrame:CGRectMake(112*WIDTH/375, 37*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    stopBtn3.titleLabel.text = @"停";
    stopBtn3.titleLabel.textColor = [UIColor brownColor];
    stopBtn3.titleLabel.font = [UIFont systemFontOfSize:15];
    [controlView addSubview:stopBtn3];
    
    UIButton *yuanBtn = [[UIButton alloc]initWithFrame:CGRectMake(176*WIDTH/375, 16*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    yuanBtn.titleLabel.text = @"远";
    yuanBtn.titleLabel.textColor = [UIColor brownColor];
    yuanBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [controlView addSubview:yuanBtn];
    
    UIButton *jinBtn = [[UIButton alloc]initWithFrame:CGRectMake(206*WIDTH/375, 16*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    jinBtn.titleLabel.text = @"近";
    jinBtn.titleLabel.textColor = [UIColor brownColor];
    jinBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [controlView addSubview:jinBtn];
    
    UIButton *lightBtn = [[UIButton alloc]initWithFrame:CGRectMake(176*WIDTH/375, 54*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    lightBtn.titleLabel.text = @"明";
    lightBtn.titleLabel.textColor = [UIColor brownColor];
    lightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [controlView addSubview:lightBtn];
    
    UIButton *anBtn = [[UIButton alloc]initWithFrame:CGRectMake(206*WIDTH/375, 54*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    anBtn.titleLabel.text = @"暗";
    anBtn.titleLabel.textColor = [UIColor brownColor];
    anBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [controlView addSubview:anBtn];

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//状态回调函数
void StatusCallBack(PLAY_STATE playState, VP_HANDLE hLogin, void *pHandl)
{
    NSLog(@"playState is %d", playState);
}

- (IBAction)playAction:(UIButton *)sender {
    
    //获取播放地址
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _realPlayURL = [[CRealPlayURL alloc] init];
    BOOL result = [vmsNetSDK getRealPlayURL:_serverAddress
                                toSessionID:_mspInfo.sessionID
                                 toCameraID:_cameraInfo.cameraID
                              toRealPlayURL:_realPlayURL
                               toStreamType:STREAM_SUB]; //StreamType＝0时，返回主码流和MAG地址，其＝1时返回子码流和MAG地址
    if (NO == result) {
        [[[UIAlertView alloc] initWithTitle:@"提示"
                                    message:@"获取播放地址失败"
                                   delegate:nil
                          cancelButtonTitle:@"好"
                          otherButtonTitles:nil, nil] show];
    }
    
    //获取设备信息
    VideoPlayInfo *videoInfo = [[VideoPlayInfo alloc] init];
    CDeviceInfo *deviceInfo = [[CDeviceInfo alloc] init];
    result = [vmsNetSDK getDeviceInfo:_serverAddress
                          toSessionID:_mspInfo.sessionID
                           toDeviceID:_cameraInfo.deviceID
                         toDeviceInfo:deviceInfo];
    
    // 设备的用户名和密码, 需要调用VMSNetSDK中的接口 getDeviceInfo 获得的CDeviceInfo中属性：userName和password获取。
    if(result)
    {
        videoInfo.strUser = deviceInfo.userName;
        NSLog(@"姓名：%@",deviceInfo.userName);
        videoInfo.strPsw = deviceInfo.password;
    }
    else
    {
        videoInfo.strUser   = @"admin";
        videoInfo.strPsw    = @"12345";
    }
    
    //填充vidioInfo
    videoInfo.strID =  _cameraInfo.cameraID;
    videoInfo.protocalType  = PROTOCAL_UDP;
    videoInfo.playType      = REAL_PLAY;
    videoInfo.streamMethod  = STREAM_METHOD_VTDU;
    VP_STREAM_TYPE streamType = STREAM_SUB;
    videoInfo.streamType    = streamType;
    videoInfo.pPlayHandle   = (id)self.playView;
    videoInfo.bSystransform = NO;
    videoInfo.strPlayUrl = _realPlayURL.url1;
    
    if (_vpHandle != NULL)
    {
        VP_Logout(_vpHandle);
        _vpHandle = NULL;
    }
    
    // 获取VideoPlaySDK 播放句柄
    if (_vpHandle == NULL)
    {
        _vpHandle = VP_Login(videoInfo);
    }
    
    // 设置状态回调
    if (_vpHandle != NULL)
    {
        VP_SetStatusCallBack(_vpHandle, StatusCallBack, (__bridge void *)self);
    }
    
    // 开始实时预览
    if (_vpHandle != NULL)
    {
        if (!VP_RealPlay(_vpHandle))
        {
            NSLog(@"start VP_RealPlay failed");
        }
    }

}

//停止预览或回放
- (IBAction)stopAction:(UIButton *)sender {
    if (_vpHandle != NULL)
    {
        VP_Logout(_vpHandle);
        _vpHandle = NULL;
    }
}

#pragma mark - PlayBack
//开始回放
- (IBAction)playBackAction:(UIButton *)sender {
    [self startPlayBackFromTheTime:[NSDate date].timeIntervalSince1970 - 5*60]; //从5分钟前开始回放
}

//开始回放
- (BOOL)startPlayBackFromTheTime:(NSTimeInterval)timeInterval {
    if (_vpHandle != NULL)
    {
        VP_Logout(_vpHandle);
        _vpHandle = NULL;
    }
    
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval]; //Demo演示从5分钟前开始回放.如需在回放时调整回放时间，可以停止回放后立即用新的回放开始时间进行回放
    NSString *startPlayTimeStr = [formatter stringFromDate:date];
    ABSTIME stratTime; // ={2015,4,9,0,0,0};
    ABSTIME endTime; // ={2015,4,9,23,59,59};
    
    NSRange range;
    range.length = 4;
    range.location = 0;
    stratTime.year = endTime.year = [[startPlayTimeStr substringWithRange:range] integerValue];
    
    range.location = 5;
    range.length = 2;
    stratTime.month = endTime.month = [[startPlayTimeStr substringWithRange:range] integerValue];
    
    range.location = 8;
    stratTime.day = endTime.day = [[startPlayTimeStr substringWithRange:range] integerValue];
    
    stratTime.hour = 0;
    stratTime.minute = 0;
    stratTime.second = 0;
    
    endTime.hour = 23;
    endTime.minute = 59;
    endTime.second = 59;
    
    CRecordInfo *recordInfo = [[CRecordInfo alloc] init];
    NSString *serverAddr = [[NSUserDefaults standardUserDefaults] objectForKey:_serverAddress];
    BOOL result = [vmsNetSDK queryCameraRecord:_serverAddress
                                   toSessionID:_mspInfo.sessionID
                                    toCameraID:_cameraInfo.cameraID
                                  toRecordType:@"1"
                                   toRecordPos:@"1"
                                   toStartTime:&stratTime
                                     toEndTime:&endTime
                                  toRecordInfo:recordInfo];
    if(!result)
    {
        NSLog(@"get playback URL error");
        return NO;
    }
    
    // 设置播放信息
    VideoPlayInfo *videoInfo = [[VideoPlayInfo alloc] init];
    
    // 此为设备的用户名和密码, 需要调用VMSNetSDK中的接口 getDeviceInfo 获得的CDeviceInfo中属性：userName和password获取。
    CDeviceInfo *deviceInfo = [[CDeviceInfo alloc] init];
    result = [vmsNetSDK getDeviceInfo:serverAddr
                          toSessionID:_mspInfo.sessionID
                           toDeviceID:_cameraInfo.deviceID
                         toDeviceInfo:deviceInfo];
    if(result)
    {
        videoInfo.strUser = deviceInfo.userName;
        videoInfo.strPsw = deviceInfo.password;
    }
    else
    {
        videoInfo.strUser   = @"admin";
        videoInfo.strPsw    = @"12345";
    }
    videoInfo.strPlayUrl    = recordInfo.segmentListPlayUrl;
    videoInfo.protocalType  = PROTOCAL_TCP;
    videoInfo.playType      = PLAY_BACK;
    videoInfo.streamMethod  = STREAM_METHOD_VTDU;
    videoInfo.streamType    = STREAM_SUB;
    videoInfo.pPlayHandle   = (id)self.playView;
    
    NSString *tmpEndDateStr = [NSString stringWithFormat:@"%4d-%02d-%02d 23:59:59",stratTime.year,stratTime.month,stratTime.day];
    videoInfo.fStartTime    = [NSDate date].timeIntervalSince1970 - 5*60; //开始回放时间
    videoInfo.fStopTime     = [[formatter dateFromString:tmpEndDateStr] timeIntervalSince1970];//结束回放时间
    
    // 获取VideoPlaySDK 播放句柄
    if (_vpHandle == NULL)
    {
        _vpHandle = VP_Login(videoInfo);
    }
    
    // 设置状态回调
    if (_vpHandle != NULL)
    {
        VP_SetStatusCallBack(_vpHandle, StatusCallBack, (__bridge void *)self);
    }
    
    // 开始回放
    if (_vpHandle != NULL)
    {
        if (!VP_PlayBack(_vpHandle, videoInfo.fStartTime, videoInfo.fStopTime))
        {
            NSLog(@"start VP_PlayBack failed");
            return NO;
        }
    }
        return YES;
}

//暂停回放
- (IBAction)pausePlayBackActin:(UIButton *)sender {
    if (NULL == _vpHandle)
    {
        NSLog(@"not playing");
        return;
    }
    if (YES == _isPlayBacking) {
        // 暂停远程回放
        if (!VP_PausePlayBack(_vpHandle))
        {
            NSLog(@"VP_PausePlayBack failed error code is %ld", VP_GetLastError(_vpHandle));
            return;
        }
        _isPlayBacking = NO;
    }

    // 重新开始远程回放
    if (!VP_ResumePlayBack(_vpHandle))
    {
        NSLog(@"VP_ResumePlayBack failed");
        return;
    }
    _isPlayBacking = YES;
}

//停止回放
- (IBAction)stopPlayBackAction:(UIButton *)sender {
    [self stopAction:nil];
}

//云台控制，其他云台控制动作可在SDK的头文件中查看
- (IBAction)ptzAction:(UIButton *)sender {
    
    // 是否有云台控制权限
    if (NO == _cameraInfo.isPTZControl)
    {
        NSLog(@"no ptz Control");
    }
    
    //确认操作类型
    int commandType = 0;
    switch (sender.tag) {
        case 12:
            commandType = PTZ_CMD_UP;
            break;
        case 13:
            commandType = PTZ_CMD_DOWN;
            break;
        case 14:
            commandType = PTZ_CMD_LEFT;
            break;
        case 15:
            commandType = PTZ_CMD_RIGHT;
            break;
        case 16:
            commandType = PTZ_CMD_BRIGHTEN;
            break;
        case 17:
            commandType = PTZ_CMD_DARKEN;
            break;
        case 18:
            commandType = PTZ_CMD_ZOOMOUT;
            break;
        case 19:
            commandType = PTZ_CMD_ZOOMIN;
            break;
        default:
            break;
    }
    
    //判断是开始云台命令还是停止云台
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    if (sender.tag != 20) {
        //发送云台开始动作命令
        [vmsNetSDK sendStartPTZCmd:_cameraInfo.acsIP
                            toPort:_cameraInfo.acsPort
                       toSessionID:_mspInfo.sessionID
                        toCameraID:self.cameraInfo.cameraID
                           toCmdID:PTZ_CMD_LEFT
                          toParam1:1
                          toParam2:0
                          toParam3:0
                          toParam4:0]; //3.0SDK云台控制为UDP方式发送命令
    } else {
        //发送云台停止动作命令
        [vmsNetSDK sendStopPTZCmd:_cameraInfo.acsIP
                           toPort:_cameraInfo.acsPort
                      toSessionID:_mspInfo.sessionID
                       toCameraID:_cameraInfo.cameraID]; //3.0SDK云台控制为UDP方式发送命令
    }
}
- (IBAction)onClickCapture:(UIButton *)sender {
    
    // 获取抓图信息
    CaptureInfo *captureInfo = [[CaptureInfo alloc] init];
    if (![VideoPlayUtility getCaptureInfo:self.cameraInfo.cameraID toCaptureInfo:captureInfo])
    {
        NSLog(@"getCaptureInfo failed");
    }
    
    // 设置抓图质量 1-100 越高质量越高
    captureInfo.nPicQuality = 80;
    if (NULL == _vpHandle)
    {
        NSLog(@"not playing");
        return;
    }
    
    // 抓图
    BOOL result = VP_Capture(_vpHandle, captureInfo);
    if (NO == result)
    {
        NSLog(@"VP_Capture failed");
    }
    [_captureImageView setImage:[UIImage imageWithContentsOfFile:captureInfo.strCapturePath]];

}

// 录像
- (IBAction)onClickStartRecord:(id)sender
{
    // 获取录像信息
    RecordInfo *recordInfo = [[RecordInfo alloc] init];
    BOOL result = [VideoPlayUtility getRecordInfo:self.cameraInfo.cameraID toRecordInfo:recordInfo];
    if (NO == result)
    {
        NSLog(@"getCaptureInfo failed");
    }
    if (NULL == _vpHandle)
    {
        NSLog(@"not playing");
        return;
    }
    
    // 开始录像,录像存储的路径等信息获取成功后会保存在“recordInfo”中，Demo中不再做显示
    result = VP_StartRecord(_vpHandle, recordInfo, false);
    if (NO == result)
    {
        NSLog(@"VP_StartRecord failed, error code is %ld", VP_GetLastError(_vpHandle));
    }
}

// 停止录像
- (IBAction)onClickStopRecord:(id)sender
{
    if (NULL == _vpHandle)
    {
        NSLog(@"not playing");
        return;
    }
    
    // 结束录像
    if (!VP_StopRecord(_vpHandle))
    {
        NSLog(@"VP_StopRecord failed");
    }
}

@end
