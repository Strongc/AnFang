//
//  NeedHelpViewController.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "NeedHelpViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "KeyAlarmCell.h"
#import "PhotoAlarmCell.h"
#import "VoiceAlarmCell.h"
#import "FSVoiceBubble.h"
#import <CoreLocation/CoreLocation.h>
#import "NSDateString.h"
#import "ImagePickerViewController.h"
//#import "AudioRecorderViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "NSDateString.h"


#define kRecordAudioFile @".caf"

@interface NeedHelpViewController ()<CLLocationManagerDelegate,PickImageDelegate,FSVoiceBubbleDelegate,UIImagePickerControllerDelegate,AVAudioRecorderDelegate,AVAudioPlayerDelegate>
{
    UITableView *helpMessage;
    CLLocationManager *locManager;
    NSString *locationTime;
    NSString *coordinateInfo;
    ImagePickerViewController* pickImageViewController;
    UITextView *infoText;
    NSMutableArray *arrayPlist;
    NSString *plistPath;
    NSMutableArray *saveArray;
    UIImage *photoImage;
    
    NSString *keyInfoPlistPath;
    NSMutableArray *keyInfoArrayPlist;
    NSMutableArray *saveKeyInfoArray;
    AVAudioRecorder *MyAudioRecorder;
    UIImageView *voiceImage;
   
    NSString *urlStr;
    NSMutableArray *voicePathArray;
    NSString *voicePlistPath;
    NSMutableArray *saveVoiceInfoArray;
    NSMutableArray *voiceInfoArrayPlist;
    NSString *playAudioUrl;
    UIProgressView *playProgress;//播放进度
    NSMutableArray *volumImages;
    NSString *urlStr2;

}
@property (assign, nonatomic) NSInteger currentRow;
@property (nonatomic,strong) NSMutableArray *keyAlarmData;
@property (nonatomic,strong) NSMutableArray *photoAlarmData;
@property (nonatomic,strong) NSMutableArray *voiceAlarmData;
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;//音频录音机
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;//音频播放器，用于播放录音文件
@property (nonatomic,strong) NSTimer *timer;//录音声波监控（注意这里暂时不对播放进行监控）
@property (nonatomic,strong) NSTimer *playTimer;
@property (strong, nonatomic) UIProgressView *audioPower;//音频波动

@end

@implementation NeedHelpViewController
@synthesize avPalyer;

-(NSMutableArray *)keyAlarmData
{
    if(_keyAlarmData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"keyInfo.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:keyInfoPlistPath];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            OneKeyAlarmModel *model = [OneKeyAlarmModel OneKeyAlarmModelWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _keyAlarmData = arrayModels;
        
    }
    
    return _keyAlarmData;
}

-(NSMutableArray *)voiceAlarmData
{

    if(_voiceAlarmData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"VoiceAlarm.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:voicePlistPath];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            VoiceAlarmModel *model = [VoiceAlarmModel VoiceAlarmModelWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _voiceAlarmData = arrayModels;
        
    }
    
    return _voiceAlarmData;

}

-(NSMutableArray *)photoAlarmData
{

    if(_photoAlarmData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        //NSString *path = [[NSBundle mainBundle] pathForResource:@"TextAndPhotoAlarm.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:plistPath];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            TextPhotoAlarmModel *model = [TextPhotoAlarmModel TextPhotoAlarmModelWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _photoAlarmData = arrayModels;
        
    }
    
    return _photoAlarmData;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    
    NSFileManager *manager=[NSFileManager defaultManager];
    //文件路径
    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"voice.plist"];
    if(![filepath isEqualToString:@""]){
        if ([manager removeItemAtPath:filepath error:nil]) {
            NSLog(@"文件删除成功");
        }

    }
    
    volumImages = [[NSMutableArray alloc]initWithObjects:@"丽晶宾馆基站.jpg",@"新天地大厦基站.jpg",@"磐安移动_公司大门口.jpg",
                   @"新天地大厦基站.jpg", @"武义移动_环城北路营业厅大门.jpg",@"永康移动_公司楼顶基站.jpg",@"武义移动_环城北路营业厅大门.jpg",@"兰溪移动_公司大门进出口.jpg",@"武义移动_环城北路营业厅大门.jpg",@"浦江移动_蔬菜基地1.jpg",@"浦江移动_蔬菜基地2.jpg",@"",@"浙江大学附属第四医院.jpg",
                   @"武义移动_环城北路营业厅大门.jpg",@"东阳移动_主营业厅.jpg",nil];

    MyAudioRecorder = [[AVAudioRecorder alloc]init];
    _currentRow = -1;
    voicePathArray = [[NSMutableArray alloc]init];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self ConfigControl];
    helpMessage = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 360*HEIGHT/667) style:UITableViewStylePlain];
    [self.view addSubview:helpMessage];
    helpMessage.delegate = self;
    helpMessage.dataSource = self;
    helpMessage.separatorStyle = UITableViewCellSeparatorStyleNone;
    helpMessage.backgroundColor = [UIColor colorWithHexString:@"ededed"];
  
    //实例化一个位置管理器
    locManager = [[CLLocationManager alloc]init];
    //设置代理
    locManager.delegate = self;
    // 设置定位精度
    // kCLLocationAccuracyNearestTenMeters:精度10米
    // kCLLocationAccuracyHundredMeters:精度100 米
    // kCLLocationAccuracyKilometer:精度1000 米
    // kCLLocationAccuracyThreeKilometers:精度3000米
    // kCLLocationAccuracyBest:设备使用电池供电时候最高的精度
    // kCLLocationAccuracyBestForNavigation:导航情况下最高精度，一般要有外接电源时才能使用
    locManager.desiredAccuracy = kCLLocationAccuracyBest;
    [locManager startUpdatingLocation];
    
    pickImageViewController.delegate = self;
    _photoAlarmData = [[NSMutableArray alloc] init];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //获取完整路径
    NSString *documentsDirectory = [paths objectAtIndex:0];
    plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
    arrayPlist = [[NSMutableArray alloc]init];
    saveArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
   
    _photoAlarmData = nil;
    
    keyInfoPlistPath = [documentsDirectory stringByAppendingPathComponent:@"keyInfo.plist"];
    keyInfoArrayPlist = [[NSMutableArray alloc]init];
    saveKeyInfoArray = [NSMutableArray arrayWithContentsOfFile:keyInfoPlistPath];
    
    _keyAlarmData = nil;
    
    voicePlistPath = [documentsDirectory stringByAppendingPathComponent:@"voice.plist"];
    saveVoiceInfoArray = [NSMutableArray arrayWithContentsOfFile:voicePlistPath];
    voiceInfoArrayPlist = [[NSMutableArray alloc]init];
    _voiceAlarmData = nil;
    NSLog(@"%@",voicePlistPath);
    [self ConfigControl];
    [self setAudioSession];
   
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideKeyBoard) name:@"hideKeyBoard" object:nil];

    // Do any additional setup after loading the view.
}

-(void)hideKeyBoard
{
    //[self.view endEditing:YES];
     [infoText resignFirstResponder];
    
}


//监听键盘弹出事件
-(void)keyBoardWillChangeFrame:(NSNotification *)noteInfo
{

    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y - self.view.frame.size.height;
    CGFloat tranformValue = keyboardY;
    self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue);

}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    //获取最后一次位置
    CLLocation *location = [locations lastObject];
    //获取纬度
    float latitude = location.coordinate.latitude;
    //获取经度
    float longitude = location.coordinate.longitude;
    
    NSString *str1 = [NSString stringWithFormat:@"%f",latitude];
    NSString *str2 = [NSString stringWithFormat:@"%f",longitude];
    NSString *str3 = [@"x " stringByAppendingString:str1];
    NSString *str4 = [@"y " stringByAppendingString:str2];
    NSString *str5 = [str3 stringByAppendingString:@" ,"];
    coordinateInfo = [str5 stringByAppendingString:str4];
   
    NSDate *time = location.timestamp;
    locationTime = [NSDateString stringFromDate:time];
    NSLog(@"%@",locationTime);
    
}

//-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
//{
//    
//
//
//}

-(void)ConfigControl
{
    
    UIView *alarmView = [[UIView alloc]initWithFrame:CGRectMake(15*WIDTH/375, 380*HEIGHT/667, WIDTH-30*WIDTH/375, 150*HEIGHT/667)];
    alarmView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:alarmView];
    
    UIView *voiceInfoView = [[UIView alloc]initWithFrame:CGRectMake(80*WIDTH/375, 20*HEIGHT/667
     , 180*WIDTH/375, 40*HEIGHT/375)];
    [alarmView addSubview:voiceInfoView];
    
    infoText = [[UITextView alloc]initWithFrame:voiceInfoView.frame];
    [alarmView addSubview:infoText];
    
    voiceInfoView.backgroundColor = [UIColor whiteColor];

    UIButton *alarmBtn = [[UIButton alloc]initWithFrame:CGRectMake(80*WIDTH/375, 105*HEIGHT/667, 180*WIDTH/375, 30*HEIGHT/667)];
    alarmBtn.backgroundColor = [UIColor redColor];
    
    [alarmBtn setTitle:@"一 键 报 警" forState:UIControlStateNormal];
    [alarmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alarmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    alarmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    [alarmBtn addTarget:self action:@selector(KeyAlarm) forControlEvents:UIControlEventTouchUpInside];
    //[alarmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
    [alarmView addSubview:alarmBtn];
    
    UIButton *speakBtn = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH/375, 20*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [alarmView addSubview:speakBtn];
    
    voiceImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50*WIDTH/375, 50*HEIGHT/667)];
    voiceImage.image = [UIImage imageNamed:@"mic_normal_358x358@2x.png"];
    [speakBtn addSubview:voiceImage];
    //[speakBtn addTarget:self action:@selector(recordVoice) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *recoderBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH/375, 90*HEIGHT/667, 40*WIDTH/375, 20*HEIGHT/667)];
    [alarmView addSubview:recoderBtn];
    [recoderBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [recoderBtn setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateHighlighted];
    recoderBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [recoderBtn setTitle:@"录音" forState:UIControlStateNormal];
    [recoderBtn addTarget:self action:@selector(startRecord) forControlEvents:UIControlEventTouchUpInside];
    //[recoderBtn addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpOutside];
    
    UIButton *cancleBtn = [[UIButton alloc]initWithFrame:CGRectMake(15*WIDTH/375, 120*HEIGHT/667, 40*WIDTH/375, 20*HEIGHT/667)];
    [alarmView addSubview:cancleBtn];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"btn1.png"] forState:UIControlStateNormal];
    [cancleBtn setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateHighlighted];
    cancleBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [cancleBtn setTitle:@"停止" forState:UIControlStateNormal];
    [cancleBtn addTarget:self action:@selector(stopRecord) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(280*WIDTH/375, 35*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [alarmView addSubview:addBtn];
    
    UIImageView *addImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50*WIDTH/375, 50*HEIGHT/667)];
    addImage.image = [UIImage imageNamed:@"plus19.png"];
    [addBtn addSubview:addImage];
    [addBtn addTarget:self action:@selector(AddPhotoImage) forControlEvents:UIControlEventTouchUpInside];
    
    playProgress = [[UIProgressView alloc] initWithFrame:CGRectMake(20, 400*HEIGHT/667, WIDTH-40, 10)];
    playProgress.backgroundColor = [UIColor redColor];
    [playProgress setProgressViewStyle:UIProgressViewStyleDefault];
   // playProgress.hidden = YES;
    [self.view addSubview:playProgress];
    
}

/**
 *  设置音频会话
 */
-(void)setAudioSession{
    AVAudioSession *audioSession=[AVAudioSession sharedInstance];
    //设置为播放和录音状态，以便可以在录制完之后播放录音
    //[audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];
}

/**
 *  取得录音文件设置
 *
 *  @return 录音设置
 */
-(NSDictionary *)getAudioSetting{
    NSMutableDictionary *dicM=[NSMutableDictionary dictionary];
    //设置录音格式
    [dicM setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样率，8000是电话采样率，对于一般录音已经够了
    [dicM setObject:@(8000) forKey:AVSampleRateKey];
    //设置通道
    [dicM setObject:@(1) forKey:AVNumberOfChannelsKey];
    //每个采样点位数,分为8、16、24、32
    [dicM setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [dicM setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    //....其他设置等
    return dicM;
}

/**
 *  获得录音机对象
 *
 *  @return 录音机对象
 */
-(AVAudioRecorder *)audioRecorder{
    
    if (!_audioRecorder) {
        //创建录音文件保存路径
        NSURL *url=[NSURL fileURLWithPath:urlStr];
        NSLog(@"%@",urlStr);
        //创建录音格式设置
        NSDictionary *setting=[self getAudioSetting];
        //创建录音机
        NSError *error=nil;
        AVAudioRecorder *audioRecorderTemp=[[AVAudioRecorder alloc]initWithURL:url settings:setting error:&error];
        audioRecorderTemp.delegate=self;
        audioRecorderTemp.meteringEnabled=YES;//如果要监控声波则必须设置为YES
        if (error) {
            NSLog(@"创建录音机对象时发生错误，错误信息：%@",error.localizedDescription);
            return nil;
        }
    
        _audioRecorder.meteringEnabled = YES;
        _audioRecorder = audioRecorderTemp;
    }
    
    
    //NSLog(@"dddddd");

    return _audioRecorder;
}





/**
 *  录音声波状态设置
 */
-(void)audioPowerChange{
    [self.audioRecorder updateMeters];//更新测量值
    float power= [self.audioRecorder averagePowerForChannel:0];//取得第一个通道的音频，注意音频强度范围时-160到0
    CGFloat progress=(1.0/160.0)*(power+160.0);
    [self.audioPower setProgress:progress];
}


#pragma mark - UI事件
/**
 *  点击录音按钮
 *
 *  @param sender 录音按钮
 */
- (void)recordClick {
    
   
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *fileName = [NSDateString ret32bitString];
    NSString *fileName1 = [fileName stringByAppendingString:kRecordAudioFile];
    urlStr2 =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    urlStr = [urlStr2 stringByAppendingPathComponent:fileName1];
    [voicePathArray addObject:urlStr];
    
    NSLog(@"file path:%@",urlStr);
    if (![self.audioRecorder isRecording]) {
        [self.audioRecorder record];//首次使用应用时如果调用record方法会询问用户是否允许使用麦克风
        self.timer.fireDate=[NSDate distantPast];
    }
}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
-(NSTimer *)timer{
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    }
    return _timer;
}


- (void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //获取音量的平均值  [recorder averagePowerForChannel:0];
    //音量的最大值  [recorder peakPowerForChannel:0];
    
    double lowPassResults = pow(10, (0.05 * [recorder peakPowerForChannel:0]));
    NSLog(@"%lf",lowPassResults);
    //最大50  0
    //图片 小-》大
    if (0<lowPassResults<=0.6) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_01.png"]];
        
    }else if (0.6<lowPassResults<=1.3) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_02.png"]];
        
    }else if (1.3<lowPassResults<=2.0) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_03.png"]];
        
    }else if (2.00<lowPassResults<=2.7) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_04.png"]];
        
    }else if (2.7<lowPassResults<=3.4) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_05.png"]];
        
    }else if (3.4<lowPassResults<=4.1) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_06.png"]];
        
    }else if (4.1<lowPassResults<=4.8) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_07.png"]];
        
    }else if (4.8<lowPassResults<=5.5) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_08.png"]];
        
    }else if (5.5<lowPassResults<=6.2) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_09.png"]];
        
    }else if (6.2<lowPassResults<=6.9) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_10.png"]];
        
    }else if (6.9<lowPassResults<=7.6) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_11.png"]];
        
    }else if (7.6<lowPassResults<=8.3) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_12.png"]];
        
    }else if (8.3<lowPassResults<=9.0) {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_13.png"]];
        
    }else {
        [voiceImage setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
}


///**
// *  点击暂定按钮
// *
// *  @param sender 暂停按钮
// */
//- (void)pauseClick:(UIButton *)sender {
//    if ([self.audioRecorder isRecording]) {
//        [self.audioRecorder pause];
//        self.timer.fireDate=[NSDate distantFuture];
//    }
//}

///**
// *  点击恢复按钮
// *  恢复录音只需要再次调用record，AVAudioSession会帮助你记录上次录音位置并追加录音
// *
// *  @param sender 恢复按钮
// */
//- (void)resumeClick:(UIButton *)sender {
//    [self recordClick];
//}
//
/**
 *  点击停止按钮
 *
 *  @param sender 停止按钮
 */
- (void)stopClick {
    [self.audioRecorder stop];
   // NSLog(@"ffffff");
    self.timer.fireDate=[NSDate distantFuture];
    self.audioPower.progress=0.0;
    
}

#pragma mark - 录音机代理方法
/**
 *  录音完成，录音完成后播放录音
 *
 *  @param recorder 录音机对象
 *  @param flag     是否成功
 */
-(void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    
    //    if (![self.audioPlayer isPlaying]) {
    //        [self.audioPlayer play];
    //    }
    //[self.delegate flushRecoder:(NSMutableArray *)];
    
   // [self backAction];
    self.audioRecorder = nil;
    NSLog(@"录音完成!");
}

-(void)startRecord
{
    
    voiceImage.image = [UIImage imageNamed:@"mic_talk_358x358@2x.png"];
    [self recordClick];
    
}

-(void)stopRecord
{
    voiceImage.image = [UIImage imageNamed:@"mic_normal_358x358@2x.png"];
    [self stopClick];
    [self flushRecoder];
    
}

//添加图片
-(void)AddPhotoImage
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    pickImageViewController = [mainView instantiateViewControllerWithIdentifier:@"imagePicker"];
    pickImageViewController.delegate = self;
    [self.navigationController pushViewController:pickImageViewController animated:YES];
    [self.view endEditing:YES];
    
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n;

    if(section == 0){
    
        n = self.keyAlarmData.count;
    }else if (section == 1){
    
        n = self.photoAlarmData.count;
    }else if (section == 2){
    
        n = self.voiceAlarmData.count;
    }
    
    return n;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    
    if(indexPath.section == 0){
    
        static NSString *reuseIdentify = @"cell1";
        KeyAlarmCell *keycell = (KeyAlarmCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
        
        if(keycell == nil){
            
            keycell = [[KeyAlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
            
            keycell.accessoryType = UITableViewCellAccessoryNone;
            //cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
            keycell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        OneKeyAlarmModel *model = [self.keyAlarmData objectAtIndex:indexPath.row];
        keycell.oneKeyAlarm = model;
    
        NSString *content = keycell.stateLab.text;
        if([content isEqualToString:@"已发送"]){
            
            keycell.stateLab.textColor = [UIColor greenColor];
        }else{
            
            keycell.stateLab.textColor = [UIColor redColor];
            
        }

        cell = keycell;
    
    }else if (indexPath.section == 1){
    
        static NSString *reuseIdentify = @"cell2";
        PhotoAlarmCell *photocell = (PhotoAlarmCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
        
        if(photocell == nil){
            
            photocell = [[PhotoAlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
            
            photocell.accessoryType = UITableViewCellAccessoryNone;
            //cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
            photocell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        TextPhotoAlarmModel *model = [self.photoAlarmData objectAtIndex:indexPath.row];
        photocell.photoKeyAlarm = model;
        
        NSString *content = photocell.stateLab.text;
        if([content isEqualToString:@"已发送"]){
            
            photocell.stateLab.textColor = [UIColor greenColor];
        }else{
            
            photocell.stateLab.textColor = [UIColor redColor];
            
        }

        cell = photocell;

    }else if (indexPath.section == 2){
    
        static NSString *reuseIdentify = @"cell3";
        VoiceAlarmCell *voicecell = (VoiceAlarmCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
        
        if(voicecell == nil){
            
            voicecell = [[VoiceAlarmCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
            
            voicecell.accessoryType = UITableViewCellAccessoryNone;
            voicecell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
            voicecell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        
        VoiceAlarmModel *model = [self.voiceAlarmData objectAtIndex:indexPath.row];
        voicecell.voiceModel = model;
        NSString *strUrl = model.url;
        NSLog(@"%@",strUrl);
      
        NSURL *url=[NSURL fileURLWithPath:strUrl];
        voicecell.voiceBubble.contentURL = url;
        voicecell.timeLab.text = model.time;
       
        voicecell.voiceBubble.tag = indexPath.row;
        if (indexPath.row == _currentRow ) {
            
            [voicecell.voiceBubble startAnimating];
        } else {
            
            [voicecell.voiceBubble stopAnimating];
        }

        //[voicecell.playBtn addTarget:self action:@selector(playAudio) forControlEvents:UIControlEventTouchUpInside];
        
        NSString *content = voicecell.stateLab.text;
        if([content isEqualToString:@"已发送"]){
            
            voicecell.stateLab.textColor = [UIColor greenColor];
        }else{
            
            voicecell.stateLab.textColor = [UIColor redColor];
            
        }

        cell = voicecell;

    }
    
    return cell;

}

- (void)voiceBubbleDidStartPlaying:(FSVoiceBubble *)voiceBubble
{
    NSLog(@"ddddd");
    _currentRow = voiceBubble.tag;
}


#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat h;
    
    if(indexPath.section == 0){
    
        h = 68*HEIGHT/667;
    }else if (indexPath.section == 1){
    
        h = 120*HEIGHT/667;
    }else if (indexPath.section == 2){
    
        h = 100*HEIGHT/667;
    }
    
    return h;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

//    NSInteger row = indexPath.row;
//    NSLog(@"%ld",(long)row);
////    playAudioUrl = [saveVoiceInfoArray[indexPath.row] objectForKey:@"url"];
////   // [self playAudio];
//    NSLog(@"%@",playAudioUrl);

}


-(void)flushImageViews:(NSMutableArray *)arrayMutable
{
    
    TextPhotoAlarmModel *model;
    NSDate *sendDate;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
   [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    for (UIImage* image in arrayMutable) {
        
        sendDate = [NSDate date];
        NSString *  locationString=[dateformatter stringFromDate:sendDate];
        model = [[TextPhotoAlarmModel alloc]init];
        
        photoImage = image;
        model.image = image;
        model.time = locationString;
        model.message = infoText.text;
        [_photoAlarmData addObject:model];
        
        
    }
    
    [self savePhotoAlarmInfo];
    
    infoText.text = nil;
   // [self.view endEditing:YES];
    [helpMessage reloadData];
    
}


//保存图文报警信息
-(void)savePhotoAlarmInfo
{
   
    NSDate *sendDate;
    sendDate = [NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    NSString *time=[dateformatter stringFromDate:sendDate];
    
   
    //判断是否以创建文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
    {
        //此处可以自己写显示plist文件内容
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:infoText.text forKey:@"message"];
        [dict setObject:time forKey:@"time"];
        //[dict setObject:photoImage forKey:@"icon"];
        [saveArray addObject:dict];
        [saveArray writeToFile:plistPath atomically:YES];
        //NSLog(@"文件已存在");
    }
    else
    {
        
        [arrayPlist writeToFile:plistPath atomically:YES];
        
    }

}

//一键报警按钮触发事件
-(void)KeyAlarm
{
    
    NSDate *sendDate;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    sendDate = [NSDate date];
    NSString * time=[dateformatter stringFromDate:sendDate];
    OneKeyAlarmModel *model = [[OneKeyAlarmModel alloc] init];
    model.time = time;
    NSString *location = @"X 1345 , y 3456";
    model.location = location;
    //    model.state = @"发送失败";
    [_keyAlarmData addObject:model];
    [helpMessage reloadData];
    
    
    //判断是否以创建文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:keyInfoPlistPath])
    {
        //此处可以自己写显示plist文件内容
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:location forKey:@"message"];
        [dict setObject:time forKey:@"time"];
        [dict setObject:location forKey:@"location"];
        [saveKeyInfoArray addObject:dict];
        [saveKeyInfoArray writeToFile:keyInfoPlistPath atomically:YES];
        //NSLog(@"文件已存在");
    }
    else
    {
        
        [keyInfoArrayPlist writeToFile:keyInfoPlistPath atomically:YES];
        
    }
    
}

//刷新录音列表
-(void)flushRecoder
{
    
        VoiceAlarmModel *model;
        NSDate *sendDate;
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
        sendDate = [NSDate date];
        NSString *recordTime = [dateformatter stringFromDate:sendDate];
        model = [[VoiceAlarmModel alloc]init];
        model.time = recordTime;
        model.url = urlStr;
        [_voiceAlarmData addObject:model];
    
        [helpMessage reloadData];
    
    //判断是否以创建文件
    if ([[NSFileManager defaultManager] fileExistsAtPath:voicePlistPath])
    {
        //此处可以自己写显示plist文件内容
        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
        [dict setObject:urlStr forKey:@"url"];
        [dict setObject:recordTime forKey:@"time"];
        //[dict setObject:location forKey:@"state"];
        [saveVoiceInfoArray addObject:dict];
        [saveVoiceInfoArray writeToFile:voicePlistPath atomically:YES];
        NSLog(@"文件已存在");
    }
    else
    {
        
        [voiceInfoArrayPlist writeToFile:voicePlistPath atomically:YES];
        
    }

}

/**
 *  录音声波监控定制器
 *
 *  @return 定时器
 */
//-(NSTimer *)playTimer{
//    if (!_playTimer) {
//        _playTimer=[NSTimer scheduledTimerWithTimeInterval:0.1f target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
//    }
//    return _playTimer;
//}


/**
 *  创建播放器
 *
 *  @return 播放器
 */
//-(AVAudioPlayer *)audioPlayer{
//    
//    
//    // NSString *string = [[NSBundle mainBundle] pathForResource:@"NLOmyRecord.caf" ofType:nil];
//    if (!_audioPlayer) {
//        NSURL *url=[NSURL fileURLWithPath:playAudioUrl];
//        //NSLog(@"%@",url);
//        NSError *error=nil;
//        _audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//        _audioPlayer.numberOfLoops=0;
//        _audioPlayer.delegate=self;
//        [_audioPlayer prepareToPlay];
//        if (error) {
//            NSLog(@"创建播放器过程中发生错误，错误信息：%@",error.localizedDescription);
//            return nil;
//        }
//    }
//    return _audioPlayer;
//}



//-(void)playAudio
//{
//    NSURL *url=[[NSBundle mainBundle] URLForResource:@"aa" withExtension:@"mp3"];
//    //NSLog(@"%@",url);
//    NSError *error=nil;
//   AVAudioPlayer *audioPlayer=[[AVAudioPlayer alloc]initWithContentsOfURL:url error:&error];
//    audioPlayer.numberOfLoops=0;
//    audioPlayer.delegate=self;
//    [audioPlayer prepareToPlay];
//    
//    playProgress.hidden = NO;
//    if (![audioPlayer isPlaying]) {
//        [audioPlayer play];
//        self.playTimer.fireDate = [NSDate distantPast];//恢复定时器
//    }
//    self.audioPlayer = audioPlayer;
//
//}

///**
// *  更新播放进度
// */
//-(void)updateProgress{
//    float progress= self.audioPlayer.currentTime /self.audioPlayer.duration;
//    [playProgress setProgress:progress animated:true];
//    if(progress ==1.0){
//    
//        [self.audioPlayer stop];
//         playProgress.progress = 0.0;
//    }
//}
//
//#pragma mark - 播放器代理方法
//-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{
//    
//    playProgress.hidden = YES;
//    playProgress.progress = 0.0;
//    _audioPlayer = nil;
//    [_playTimer invalidate];
//    NSLog(@"音乐播放完成...");
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
