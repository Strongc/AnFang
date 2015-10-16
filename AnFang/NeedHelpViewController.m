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
#import <CoreLocation/CoreLocation.h>
#import "NSDateString.h"
#import "ImagePickerViewController.h"

@interface NeedHelpViewController ()<CLLocationManagerDelegate,PickImageDelegate,UIImagePickerControllerDelegate>
{
    UITableView *helpMessage;
    CLLocationManager *locManager;
    NSString *locationTime;
    NSString *coordinateInfo;
    ImagePickerViewController* pickImageViewController;
    UITextView *text;

}

@property (nonatomic,strong) NSMutableArray *keyAlarmData;
@property (nonatomic,strong) NSMutableArray *photoAlarmData;
@property (nonatomic,strong) NSArray *voiceAlarmData;

@end

@implementation NeedHelpViewController
@synthesize avPalyer;

-(NSMutableArray *)keyAlarmData
{
    if(_keyAlarmData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"KeyAlarm.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
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

-(NSArray *)voiceAlarmData
{

    if(_voiceAlarmData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"VoiceAlarm.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
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

//-(NSArray *)photoAlarmData
//{
//
//    if(_photoAlarmData == nil){
//        
//        //1.获取PayStyleIcon.plist文件的路径
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"TextAndPhotoAlarm.plist" ofType:nil];
//        //2.根据路径加载数据
//        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
//        
//        //3.创建一个可变数组来保存一个一个对象
//        NSMutableArray *arrayModels = [NSMutableArray array];
//        
//        //4.循环字典数组，把每个字典对象转化成一个模型对象
//        for(NSDictionary *dict in arrayDict){
//            
//            TextPhotoAlarmModel *model = [TextPhotoAlarmModel TextPhotoAlarmModelWithDict:dict];
//            
//            [arrayModels addObject:model];
//        }
//        
//        _photoAlarmData = arrayModels;
//        
//    }
//    
//    return _photoAlarmData;
//
//}

- (void)viewDidLoad {
    
    [super viewDidLoad];
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
    
    // Do any additional setup after loading the view.
}

-(void)keyBoardWillChangeFrame:(NSNotification *)noteInfo
{

    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y-self.view.frame.size.height;
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
    
    text = [[UITextView alloc]initWithFrame:voiceInfoView.frame];
    [alarmView addSubview:text];
    
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
    
    UIButton *speakBtn = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH/375, 35*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [alarmView addSubview:speakBtn];
    
    UIImageView *voiceImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50*WIDTH/375, 50*HEIGHT/667)];
    voiceImage.image = [UIImage imageNamed:@"voice.png"];
    [speakBtn addSubview:voiceImage];
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(280*WIDTH/375, 35*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    [alarmView addSubview:addBtn];
    
    UIImageView *addImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50*WIDTH/375, 50*HEIGHT/667)];
    addImage.image = [UIImage imageNamed:@"plus19.png"];
    [addBtn addSubview:addImage];
    [addBtn addTarget:self action:@selector(AddPhotoImage) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)playRecordSound
{
    if(self.avPalyer.playing){
        [self.avPalyer stop];
        return;
    
    }
    AVAudioPlayer *player = [[AVAudioPlayer alloc]initWithContentsOfURL:urlPlay error:nil];
    self.avPalyer = player;
    [self.avPalyer play];

}

- (IBAction)btnDown:(id)sender
{
    //创建录音文件，准备录音
    if ([recorder prepareToRecord]) {
        //开始
        [recorder record];
    }
    
    //设置定时检测
    //timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
}
- (IBAction)btnUp:(id)sender
{
    double cTime = recorder.currentTime;
    if (cTime > 2) {//如果录制时间<2 不发送
        NSLog(@"发出去");
    }else {
        //删除记录的文件
        [recorder deleteRecording];
        //删除存储的
    }
    [recorder stop];
    [timer invalidate];
}
- (IBAction)btnDragUp:(id)sender
{
    //删除录制文件
    [recorder deleteRecording];
    [recorder stop];
    [timer invalidate];
    
    NSLog(@"取消发送");
}

//一键报警按钮触发事件
-(void)KeyAlarm
{

    OneKeyAlarmModel *model = [[OneKeyAlarmModel alloc] init];
    model.time = @"2015-10-21 09:21:36";
    model.location = @"X 1345 , y 3456";
    model.state = @"发送失败";
    [_keyAlarmData addObject:model];
    [helpMessage reloadData];
  
 
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

-(void)flushImageViews:(NSMutableArray *)arrayMutable
{
    
    
    TextPhotoAlarmModel *model;
    NSDate *sendDate;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
   [dateformatter setDateFormat:@"YY-MM-dd hh:mm:ss"];
    
    for (UIImage* image in arrayMutable) {
        
        sendDate = [NSDate date];
        NSString *  locationString=[dateformatter stringFromDate:sendDate];
        model = [[TextPhotoAlarmModel alloc]init];
        model.image = image;
        model.time = locationString;
        model.message = text.text;
        [_photoAlarmData addObject:model];
        
        
    }
    
    text.text = nil;
    [helpMessage reloadData];
   
}

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
