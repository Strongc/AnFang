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
#import "UIColor+Extensions.h"
#import "MenuTabBarViewController.h"

static void *_vpHandle = NULL;

@interface PlayViewController ()

@property (strong, nonatomic) UIView *playView;
@property (strong, nonatomic) UIImageView *captureImageView;
@property (strong, nonatomic) UIView *headView;
@property (strong, nonatomic) UIButton *backBtn;

@end

@implementation PlayViewController {
    CRealPlayURL *_realPlayURL;
    VP_HANDLE _handle;
    BOOL _isPlayBacking;
    CGFloat _startPlayBackTime;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.view.backgroundColor = [UIColor whiteColor];
    self.headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    self.headView.backgroundColor = [UIColor colorWithHexString:@"ffd700"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"视频";
    title.textColor = [UIColor whiteColor];
    [self.headView addSubview:title];
    [self.view addSubview:self.headView];
    
    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH/375, 7*HEIGHT/667, 32, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont systemFontOfSize:16];
    backTitle.textColor = [UIColor whiteColor];
    [self.backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5*HEIGHT/667, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [self.backBtn addSubview:backImage];
    [self.backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.backBtn];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(doRotateAction:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];

    [self initViewControllerData];
    
    
    // Do any additional setup after loading the view from its nib.
}

- (void)doRotateAction:(NSNotification *)notification {
    CGRect frame = self.playView.frame;
    UIDevice *device = [UIDevice currentDevice] ;
//    if ([device orientation] == UIDeviceOrientationPortraitUpsideDown) {
//        
//        [self.headView removeFromSuperview];
//        [self.backBtn removeFromSuperview];
//        //CGAffineTransform transform =CGAffineTransformMakeRotation(M_PI/2);
//        //[self.playView setTransform:transform];
//        frame = CGRectMake(0, 0, HEIGHT, WIDTH);
//       
//    } else {
//        
//        [self.view addSubview:self.headView];
//        [self.view addSubview:self.backBtn];
//        //CGAffineTransform transform =CGAffineTransformMakeRotation(-M_PI/2);
//        //[self.playView setTransform:transform];
//        
//        frame = CGRectMake(0, 65*HEIGHT/667, WIDTH, 290*HEIGHT/667);
//    }
//    
}

-(BOOL)shouldAutorotate
{
    
    return YES;
}

-(void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGRect frame = self.playView.frame;
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];

    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight){
       [[NSNotificationCenter defaultCenter] postNotificationName:@"hideTabBar" object:nil];
        [self.headView removeFromSuperview];
        [self.backBtn removeFromSuperview];
        self.playView.transform = CGAffineTransformMakeRotation(M_PI/2);
        frame = CGRectMake(0, 0, 300, 200);
       
        
    
    }else{
       [[NSNotificationCenter defaultCenter] postNotificationName:@"showTabBar" object:nil];
        [self.view addSubview:self.headView];
        [self.view addSubview:self.backBtn];
        self.playView.transform = CGAffineTransformMakeRotation(0);
        frame = CGRectMake(0, 65*HEIGHT/667, WIDTH, 290*HEIGHT/667);
    
    }

}

-(void)initViewControllerData
{
    
    self.playView = [[UIView alloc] initWithFrame:CGRectMake(0, 65*HEIGHT/667, WIDTH, 290*HEIGHT/667)];
    [self.view addSubview:self.playView];
    self.playView.backgroundColor = [UIColor blackColor];
    
    UITextField *text1 = [[UITextField alloc]initWithFrame:CGRectMake(50*WIDTH/375, 365*HEIGHT/667, 120*WIDTH/375, 40*HEIGHT/667)];
    [self.view addSubview:text1];
    
    text1.borderStyle = UITextBorderStyleRoundedRect;
    
    UIButton *playBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 5*HEIGHT/667, 45*WIDTH/375, 30*HEIGHT/667)];
    [text1 addSubview:playBtn];
    playBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [playBtn setTitle:@"预览" forState:UIControlStateNormal];
    playBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [playBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [playBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [playBtn addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *stopBtn = [[UIButton alloc] initWithFrame:CGRectMake(70*WIDTH/375, 5*HEIGHT/667, 45*WIDTH/375, 30*HEIGHT/667)];
    [text1 addSubview:stopBtn];
    stopBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    stopBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [stopBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [stopBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [stopBtn addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];

    UIButton *getImageBtn = [[UIButton alloc] initWithFrame:CGRectMake(215*WIDTH/375, 370*HEIGHT/667, 30*WIDTH/375, 30*HEIGHT/667)];
    [self.view addSubview:getImageBtn];
    getImageBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [getImageBtn setTitle:@"抓图" forState:UIControlStateNormal];
    getImageBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [getImageBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [getImageBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [getImageBtn addTarget:self action:@selector(onClickCapture:) forControlEvents:UIControlEventTouchUpInside];
    
    self.captureImageView = [[UIImageView alloc] initWithFrame:CGRectMake(250*WIDTH/375, 345*HEIGHT/667, 100*WIDTH/375, 70*HEIGHT/667)];
    [self.view addSubview:self.captureImageView];
    
    UITextField *text2 = [[UITextField alloc]initWithFrame:CGRectMake(35*WIDTH/375, 415*HEIGHT/667, 160*WIDTH/375, 40*HEIGHT/667)];
    [self.view addSubview:text2];
    text2.borderStyle = UITextBorderStyleRoundedRect;
    
    UIButton *backPlayBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 5*HEIGHT/667, 40*WIDTH/375, 30*HEIGHT/667)];
    [text2 addSubview:backPlayBtn];
    backPlayBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [backPlayBtn setTitle:@"回放" forState:UIControlStateNormal];
    backPlayBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backPlayBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [backPlayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [backPlayBtn addTarget:self action:@selector(playBackAction:) forControlEvents:UIControlEventTouchUpInside];
 
    UIButton *pauseBtn = [[UIButton alloc] initWithFrame:CGRectMake(60*WIDTH/375, 5*HEIGHT/667, 40*WIDTH/375, 30*HEIGHT/667)];
    [text2 addSubview:pauseBtn];
    pauseBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [pauseBtn setTitle:@"暂停" forState:UIControlStateNormal];
    pauseBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [pauseBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [pauseBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [pauseBtn addTarget:self action:@selector(pausePlayBackActin:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *backStopBtn = [[UIButton alloc] initWithFrame:CGRectMake(110*WIDTH/375, 5*HEIGHT/667, 40*WIDTH/375, 30*HEIGHT/667)];
    [text2 addSubview:backStopBtn];
    backStopBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [backStopBtn setTitle:@"停止" forState:UIControlStateNormal];
    backStopBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [backStopBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [backStopBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [backStopBtn addTarget:self action:@selector(stopPlayBackAction:) forControlEvents:UIControlEventTouchUpInside];

    UITextField *text3 = [[UITextField alloc]initWithFrame:CGRectMake(240*WIDTH/375, 415*HEIGHT/667, 100*WIDTH/375, 40*HEIGHT/667)];
    [self.view addSubview:text3];
    text3.borderStyle = UITextBorderStyleRoundedRect;
    UIButton *videoBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 5*HEIGHT/667, 45*WIDTH/375, 30*HEIGHT/667)];
    [text3 addSubview:videoBtn];
    videoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [videoBtn setTitle:@"录像" forState:UIControlStateNormal];
    videoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [videoBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [videoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [videoBtn addTarget:self action:@selector(makeVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *stopVideoBtn = [[UIButton alloc] initWithFrame:CGRectMake(50*WIDTH/375, 5*HEIGHT/667, 45*WIDTH/375, 30*HEIGHT/667)];
    [text3 addSubview:stopVideoBtn];
    stopVideoBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [stopVideoBtn setTitle:@"停止" forState:UIControlStateNormal];
    stopVideoBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [stopVideoBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [stopVideoBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [stopVideoBtn addTarget:self action:@selector(onClickStopRecord:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(33*WIDTH/375, 460*HEIGHT/667, 310*WIDTH/375, 140*HEIGHT/667)];
    backView.backgroundColor = [UIColor colorWithHexString:@"d3d3d3"];
    [self.view addSubview:backView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 8*HEIGHT/667, backView.frame.size.width, 21*HEIGHT/667)];
    [backView addSubview:title];
    title.text = @"云台控制";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:20];
    
    UIButton *upBtn = [[UIButton alloc]initWithFrame:CGRectMake(38*WIDTH/375, 20*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    upBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [upBtn setTitle:@"⬆️" forState:UIControlStateNormal];
    upBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    upBtn.tag = 12;
    upBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [upBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [upBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [upBtn addTarget:self action:@selector(ptzAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:upBtn];
    
    UIButton *leftBtn = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH/375, 55*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [leftBtn setTitle:@"⬅️" forState:UIControlStateNormal];
    leftBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    leftBtn.tag = 14;
    [leftBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [leftBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [leftBtn addTarget:self action:@selector(ptzAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:leftBtn];
    
    UIButton *rightBtn = [[UIButton alloc]initWithFrame:CGRectMake(70*WIDTH/375, 55*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [rightBtn setTitle:@"➡️" forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    rightBtn.tag = 15;
    [rightBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];

    [rightBtn addTarget:self action:@selector(ptzAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:rightBtn];

    UIButton *downBtn = [[UIButton alloc]initWithFrame:CGRectMake(38*WIDTH/375, 85*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [downBtn setTitle:@"⬇️" forState:UIControlStateNormal];
    downBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    downBtn.tag =13;
    [downBtn setTitleColor:[UIColor colorWithHexString:@"1e90ff"] forState:UIControlStateNormal];
    [downBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [downBtn addTarget:self action:@selector(ptzAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:downBtn];
    
    UIButton *stopContolBtn = [[UIButton alloc] initWithFrame:CGRectMake(130*WIDTH/375, 55*HEIGHT/667, 50*WIDTH/375, 30*HEIGHT/667)];
    [stopContolBtn setTitle:@"停" forState:UIControlStateNormal];
    stopContolBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [stopContolBtn setTitleColor:[UIColor colorWithHexString:@"4682b4"] forState:UIControlStateNormal];
    [stopContolBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [backView addSubview:stopContolBtn];
    
    UIButton *yuanBtn = [[UIButton alloc] initWithFrame:CGRectMake(200*WIDTH/375, 20*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [yuanBtn setTitle:@"远" forState:UIControlStateNormal];
    yuanBtn.tag = 18;
    yuanBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [yuanBtn setTitleColor:[UIColor colorWithHexString:@"4682b4"] forState:UIControlStateNormal];
    [yuanBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [yuanBtn addTarget:self action:@selector(ptzAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:yuanBtn];
    
    UIButton *jinBtn = [[UIButton alloc] initWithFrame:CGRectMake(250*WIDTH/375, 20*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [jinBtn setTitle:@"近" forState:UIControlStateNormal];
    jinBtn.tag = 19;
    jinBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [jinBtn setTitleColor:[UIColor colorWithHexString:@"4682b4"] forState:UIControlStateNormal];
    [jinBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [jinBtn addTarget:self action:@selector(ptzAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:jinBtn];
    
    UIButton *lightBtn = [[UIButton alloc] initWithFrame:CGRectMake(200*WIDTH/375, 85*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [lightBtn setTitle:@"明" forState:UIControlStateNormal];
    lightBtn.tag = 16;
    lightBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [lightBtn setTitleColor:[UIColor colorWithHexString:@"4682b4"] forState:UIControlStateNormal];
    [lightBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [lightBtn addTarget:self action:@selector(ptzAction:) forControlEvents:UIControlEventTouchUpInside];
    [backView addSubview:lightBtn];
    
    UIButton *grayBtn = [[UIButton alloc] initWithFrame:CGRectMake(250*WIDTH/375, 85*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [grayBtn setTitle:@"暗" forState:UIControlStateNormal];
    grayBtn.tag = 17;
    grayBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    [grayBtn setTitleColor:[UIColor colorWithHexString:@"4682b4"] forState:UIControlStateNormal];
    [grayBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [backView addSubview:grayBtn];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{
    //NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
}


//状态回调函数
void StatusCallBack(PLAY_STATE playState, VP_HANDLE hLogin, void *pHandl)
{
    NSLog(@"playState is %d", playState);
}

#pragma mark - Preview
- (void)playAction:(UIButton *)sender {

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
    NSLog(@"Id %@",videoInfo.strID);
    videoInfo.protocalType  = PROTOCAL_UDP;
    videoInfo.playType      = REAL_PLAY;
    videoInfo.streamMethod  = STREAM_METHOD_VTDU;
    VP_STREAM_TYPE streamType = STREAM_SUB;
    videoInfo.streamType    = streamType;
    videoInfo.pPlayHandle   = (id)self.playView;
    videoInfo.bSystransform = NO;
    videoInfo.strPlayUrl = _realPlayURL.url1;
    NSLog(@"视频播放地址：%@",videoInfo.strPlayUrl);
    
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
- (void)stopAction:(UIButton *)sender {
    if (_vpHandle != NULL)
    {
        VP_Logout(_vpHandle);
        _vpHandle = NULL;
    }
}

#pragma mark - PlayBack
//开始回放
- (void)playBackAction:(UIButton *)sender {
    [self playAction:sender];
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
- (void)pausePlayBackActin:(UIButton *)sender {
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
- (void)stopPlayBackAction:(UIButton *)sender {
    [self stopAction:nil];
}

//云台控制，其他云台控制动作可在SDK的头文件中查看
- (void)ptzAction:(UIButton *)sender {
    
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

//抓图
- (void)onClickCapture:(id)sender
{
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

//录像
-(void)makeVideo:(id)sender
{
    [self onClickCapture:sender];
    [self onClickStartRecord:sender];


}

// 停止录像
- (IBAction)onClickStopRecord:(id)sender
{
    [self onClickCapture:sender];
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
