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

@interface NeedHelpViewController ()
{
    UITableView *helpMessage;

}

@property (nonatomic,strong) NSArray *menuData;
@property (nonatomic,strong) NSArray *photoAlarmData;

@end

@implementation NeedHelpViewController
@synthesize avPalyer;

-(NSArray *)menuData
{
    if(_menuData == nil){
        
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
        
        _menuData = arrayModels;
        
    }
    
    return _menuData;
}

-(NSArray *)photoAlarmData
{

    if(_photoAlarmData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TextAndPhotoAlarm.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
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
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self ConfigControl];
    helpMessage = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,WIDTH, 360*HEIGHT/667) style:UITableViewStylePlain];
    [self.view addSubview:helpMessage];
    helpMessage.delegate = self;
    helpMessage.dataSource = self;
    helpMessage.separatorStyle = UITableViewCellSeparatorStyleNone;
    helpMessage.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    // Do any additional setup after loading the view.
}

-(void)ConfigControl
{

//    UILabel *oneKeyAlarmTime = [[UILabel alloc]initWithFrame:CGRectMake(120*WIDTH/375, 10*HEIGHT/667, 150*WIDTH/375, 15*HEIGHT/667)];
//    oneKeyAlarmTime.textColor = [UIColor grayColor];
//    oneKeyAlarmTime.font = [UIFont systemFontOfSize:15*WIDTH/375];
//    oneKeyAlarmTime.text = @"2014-12-21 03:24:51";
//    [self.view addSubview:oneKeyAlarmTime];
//    
//    UIView *oneKeyView = [[UIView alloc]initWithFrame:CGRectMake(15*WIDTH/375, 35*HEIGHT/667, WIDTH-30*WIDTH/375, 60*HEIGHT/667)];
//    oneKeyView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:oneKeyView];
//    
//    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(8*WIDTH/375, 8*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
//    title1.text = @"一键报警";
//    title1.textColor = [UIColor blackColor];
//    title1.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [oneKeyView addSubview:title1];
//    
//    UILabel *position = [[UILabel alloc]initWithFrame:CGRectMake(200*WIDTH/375, 8*HEIGHT/667, 255*WIDTH/375, 15*HEIGHT/667)];
//    position.text = @"位置:x 1682，y 3577";
//    position.textColor = [UIColor blackColor];
//    position.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [oneKeyView addSubview:position];
//    
//    UILabel *state1 = [[UILabel alloc]initWithFrame:CGRectMake(295*WIDTH/375, 35*HEIGHT/667, 45*WIDTH/375, 15*HEIGHT/667)];
//    state1.textColor = [UIColor greenColor];
//    state1.text = @"已解决";
//    state1.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [oneKeyView addSubview:state1];
//    
//    UILabel *imageAlarmTime = [[UILabel alloc]initWithFrame:CGRectMake(120*WIDTH/375, 106*HEIGHT/667,150*WIDTH/375, 15*HEIGHT/667)];
//    imageAlarmTime.textColor = [UIColor grayColor];
//    imageAlarmTime.font = [UIFont systemFontOfSize:15*WIDTH/375];
//    imageAlarmTime.text = @"2015-3-21 03:24:51";
//    [self.view addSubview:imageAlarmTime];
    
//    UIView *imageView = [[UIView alloc]initWithFrame:CGRectMake(15*WIDTH/375, 130*HEIGHT/667, WIDTH-30*WIDTH/375, 100*HEIGHT/667)];
//    imageView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:imageView];
//    
//    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(8*WIDTH/375, 8*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
//    title2.text = @"图文报警";
//    title2.textColor = [UIColor blackColor];
//    title2.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [imageView addSubview:title2];
//    
//    UIImageView *alarmImage = [[UIImageView alloc]initWithFrame:CGRectMake(8*WIDTH/375, 28*HEIGHT/667, 62*WIDTH/375, 60*HEIGHT/667)];
//    alarmImage.image = [UIImage imageNamed:@"dev.png"];
//    [imageView addSubview:alarmImage];
//    
//    UILabel *state2 = [[UILabel alloc]initWithFrame:CGRectMake(295*WIDTH/375, 75*HEIGHT/667, 45*WIDTH/375, 15*HEIGHT/667)];
//    state2.textColor = [UIColor greenColor];
//    state2.text = @"已解决";
//    state2.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [imageView addSubview:state2];
//    
//    UILabel *detailInfo = [[UILabel alloc]initWithFrame:CGRectMake(100*WIDTH/375, 28*HEIGHT/667, 180*WIDTH/375, 55*HEIGHT/667)];
//    detailInfo.textColor = [UIColor grayColor];
//    detailInfo.numberOfLines = 0;
//    detailInfo.text = @"发现东门有两个窃贼，欲抓捕发遭持刀威胁，已成功逃脱，现保持跟踪，等待支援！";
//    detailInfo.font = [UIFont boldSystemFontOfSize:13*WIDTH/375];
//    [imageView addSubview:detailInfo];
//    
//    UIView *voiceView = [[UIView alloc]initWithFrame:CGRectMake(15*WIDTH/375, 265*HEIGHT/667, WIDTH-30*WIDTH/375, 100*HEIGHT/667)];
//    voiceView.backgroundColor = [UIColor whiteColor];
//    [self.view addSubview:voiceView];
//
//    UILabel *voiceAlarmTime = [[UILabel alloc]initWithFrame:CGRectMake(120*WIDTH/375, 240*HEIGHT/667,150*WIDTH/375, 15*HEIGHT/667)];
//    voiceAlarmTime.textColor = [UIColor grayColor];
//    voiceAlarmTime.font = [UIFont systemFontOfSize:15*WIDTH/375];
//    voiceAlarmTime.text = @"2015-5-26 03:24:51";
//    [self.view addSubview:voiceAlarmTime];
    
//    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(8*WIDTH/375, 8*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
//    title3.text = @"语音报警";
//    title3.textColor = [UIColor blackColor];
//    title3.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [voiceView addSubview:title3];
//    
//    UIButton *voiceBtn = [[UIButton alloc]initWithFrame:CGRectMake(140*WIDTH/375, 40*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
//    [voiceBtn setTitle:@"播放语音" forState:UIControlStateNormal];
//    [voiceBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    voiceBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [voiceBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
//    [voiceView addSubview:voiceBtn];
//    
//    UILabel *state3 = [[UILabel alloc]initWithFrame:CGRectMake(295*WIDTH/375, 75*HEIGHT/667, 45*WIDTH/375, 15*HEIGHT/667)];
//    state3.textColor = [UIColor redColor];
//    state3.text = @"等待";
//    state3.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
//    [voiceView addSubview:state3];
    
    UIView *alarmView = [[UIView alloc]initWithFrame:CGRectMake(15*WIDTH/375, 380*HEIGHT/667, WIDTH-30*WIDTH/375, 150*HEIGHT/667)];
    alarmView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:alarmView];
    
    UIView *voiceInfoView = [[UIView alloc]initWithFrame:CGRectMake(80*WIDTH/375, 20*HEIGHT/667
     , 180*WIDTH/375, 40*HEIGHT/375)];
    [alarmView addSubview:voiceInfoView];
    voiceInfoView.backgroundColor = [UIColor whiteColor];

    UIButton *alarmBtn = [[UIButton alloc]initWithFrame:CGRectMake(80*WIDTH/375, 105*HEIGHT/667, 180*WIDTH/375, 30*HEIGHT/667)];
    alarmBtn.backgroundColor = [UIColor redColor];
    [alarmBtn setTitle:@"一 键 报 警" forState:UIControlStateNormal];
    [alarmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alarmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    alarmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    [alarmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateSelected];
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

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger n;

    if(section == 0){
    
        n = self.menuData.count;
    }else if (section == 1){
    
        n = self.photoAlarmData.count;
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
        
        OneKeyAlarmModel *model = [self.menuData objectAtIndex:indexPath.row];
        keycell.oneKeyAlarm = model;
    
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
        
        cell = photocell;

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
    }
    
    return h;
    
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
