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
#import "NSDateString.h"
#import "SVProgressHUD.h"
#import "CMTool.h"
#import "WGAPI.h"
#import "JSONKit.h"
#import "ChatModel.h"
#import "ASIFormDataRequest.h"
#import "CoreArchive.h"
#import "UIView+KGViewExtend.h"


#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define kRecordAudioFile @".caf"

@interface NeedHelpViewController ()
{
    UITableView *helpMessage;
    CLLocationManager *locManager;
   // NSString *locationTime;
   // NSString *coordinateInfo;
    ImagePickerViewController* pickImageViewController;
    UITextView *infoText;
    NSMutableArray *arrayPlist;
    NSString *plistPath;
    NSMutableArray *saveArray;
    UIImage *photoImage;
    
    NSString *keyInfoPlistPath;
   // NSMutableArray *keyInfoArrayPlist;
    //NSMutableArray *saveKeyInfoArray;
    AVAudioRecorder *MyAudioRecorder;
    UIImageView *voiceImage;
   
    NSString *urlStr;
    NSMutableArray *voicePathArray;
    NSString *voicePlistPath;
    NSMutableArray *saveVoiceInfoArray;
    NSMutableArray *voiceInfoArrayPlist;
    NSMutableArray *volumImages;
    NSString *helpId;
    NSMutableArray *tempArray;
    NSMutableArray *keyInfoArray;
    NSMutableArray *temp2Array;
    NSMutableArray *photoAlarmArray;
    NSMutableArray *temp3Array;
    NSMutableArray *voiceArray;
    UUInputFunctionView *IFView;
    NSMutableArray *audioArray;
    NSString *imagePath;
    NSString *voicePath;

}
@property (assign, nonatomic) NSInteger currentRow;
//@property (nonatomic,strong) NSMutableArray *keyAlarmData;
//@property (nonatomic,strong) NSMutableArray *photoAlarmData;
@property (nonatomic,strong) NSMutableArray *voiceAlarmData;
@property (strong, nonatomic) ChatModel *chatModel;


@end

@implementation NeedHelpViewController


//-(NSMutableArray *)keyAlarmData
//{
//    if(_keyAlarmData == nil){
//        
//        //1.获取PayStyleIcon.plist文件的路径
//        //NSString *path = [[NSBundle mainBundle] pathForResource:@"keyInfo.plist" ofType:nil];
//        //2.根据路径加载数据
//        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:keyInfoPlistPath];
//        
//        //3.创建一个可变数组来保存一个一个对象
//        NSMutableArray *arrayModels = [NSMutableArray array];
//        
//        //4.循环字典数组，把每个字典对象转化成一个模型对象
//        for(NSDictionary *dict in arrayDict){
//            
//            OneKeyAlarmModel *model = [OneKeyAlarmModel OneKeyAlarmModelWithDict:dict];
//            
//            [arrayModels addObject:model];
//        }
//        
//        _keyAlarmData = arrayModels;
//        
//    }
//    
//    return _keyAlarmData;
//}
//
//-(NSMutableArray *)voiceAlarmData
//{
//
//    if(_voiceAlarmData == nil){
//        
//        //1.获取PayStyleIcon.plist文件的路径
//        //NSString *path = [[NSBundle mainBundle] pathForResource:@"VoiceAlarm.plist" ofType:nil];
//        //2.根据路径加载数据
//        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:voicePlistPath];
//        
//        //3.创建一个可变数组来保存一个一个对象
//        NSMutableArray *arrayModels = [NSMutableArray array];
//        
//        //4.循环字典数组，把每个字典对象转化成一个模型对象
//        for(NSDictionary *dict in arrayDict){
//            
//            VoiceAlarmModel *model = [VoiceAlarmModel VoiceAlarmModelWithDict:dict];
//            
//            [arrayModels addObject:model];
//        }
//        
//        _voiceAlarmData = arrayModels;
//        
//    }
//    
//    return _voiceAlarmData;
//
//}
//
//-(NSMutableArray *)photoAlarmData
//{
//
//    if(_photoAlarmData == nil){
//        
//        //1.获取PayStyleIcon.plist文件的路径
//        //NSString *path = [[NSBundle mainBundle] pathForResource:@"TextAndPhotoAlarm.plist" ofType:nil];
//        //2.根据路径加载数据
//        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:plistPath];
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
    
    tempArray = [[NSMutableArray alloc]init];
    keyInfoArray = [[NSMutableArray alloc] init];
    temp2Array = [[NSMutableArray alloc] init];
    photoAlarmArray = [[NSMutableArray alloc] init];
    temp3Array = [[NSMutableArray alloc] init];
    voiceArray = [[NSMutableArray alloc] init];
    _voiceAlarmData = [[NSMutableArray alloc] init];
    if (IS_IOS8) {
        [UIApplication sharedApplication].idleTimerDisabled = TRUE;
        locManager = [[CLLocationManager alloc] init];
        [locManager requestAlwaysAuthorization];        //NSLocationAlwaysUsageDescription
        [locManager requestWhenInUseAuthorization];     //NSLocationWhenInUseDescription
        locManager.delegate = self;
    }
    
    [self setUpForDismissKeyboard];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tapAnywhereToDismissKeyboard:) name:@"hideKeyBoard" object:nil];
//    NSFileManager *manager=[NSFileManager defaultManager];
//    //文件路径
//    NSString *filepath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)objectAtIndex:0]stringByAppendingPathComponent:@"voice.plist"];
//    if(![filepath isEqualToString:@""]){
//        if ([manager removeItemAtPath:filepath error:nil]) {
//            NSLog(@"文件删除成功");
//        }
//
//    }
    
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
  
    pickImageViewController.delegate = self;
    //_photoAlarmData = [[NSMutableArray alloc] init];
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    //获取完整路径
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    plistPath = [documentsDirectory stringByAppendingPathComponent:@"test.plist"];
//    arrayPlist = [[NSMutableArray alloc]init];
//    saveArray = [NSMutableArray arrayWithContentsOfFile:plistPath];
//    //_photoAlarmData = nil;
//    
//    keyInfoPlistPath = [documentsDirectory stringByAppendingPathComponent:@"keyInfo.plist"];
//    keyInfoArrayPlist = [[NSMutableArray alloc]init];
//    saveKeyInfoArray = [NSMutableArray arrayWithContentsOfFile:keyInfoPlistPath];
//   // _keyAlarmData = nil;
//    
//    voicePlistPath = [documentsDirectory stringByAppendingPathComponent:@"voice.plist"];
//    saveVoiceInfoArray = [NSMutableArray arrayWithContentsOfFile:voicePlistPath];
//    voiceInfoArrayPlist = [[NSMutableArray alloc]init];
//   // _voiceAlarmData = nil;
//    NSLog(@"%@",voicePlistPath);
    [self ConfigControl];
    [self getHelpMessage];
    self.chatModel = [[ChatModel alloc]init];
    self.chatModel.dataSource = [[NSMutableArray alloc] init];
    audioArray = [[NSMutableArray alloc] init];

    // Do any additional setup after loading the view.
}

//监听键盘弹出事件
-(void)keyBoardWillChangeFrame:(NSNotification *)noteInfo
{

    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y - self.view.frame.size.height;
    CGFloat tranformValue = keyboardY;
    self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue);

}

//布局界面的控件
-(void)ConfigControl
{
    
    IFView = [[UUInputFunctionView alloc]initWithSuperVC:self];
    IFView.delegate = self;
    [self.view addSubview:IFView];

    UIView *alarmView = [[UIView alloc]initWithFrame:CGRectMake(15*WIDTH/375, 380*HEIGHT/667, WIDTH-30*WIDTH/375, 150*HEIGHT/667)];
    alarmView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
   // [self.view addSubview:alarmView];
    
    UIView *voiceInfoView = [[UIView alloc]initWithFrame:CGRectMake(90*WIDTH/375, 70*HEIGHT/667
     , 180*WIDTH/375, 40*HEIGHT/375)];
    [alarmView addSubview:voiceInfoView];
    
    infoText = [[UITextView alloc]initWithFrame:voiceInfoView.frame];
    [alarmView addSubview:infoText];
    
    voiceInfoView.backgroundColor = [UIColor whiteColor];

    UIButton *alarmBtn = [[UIButton alloc]initWithFrame:CGRectMake(110*WIDTH/375,IFView.frame.origin.y + 10, 150*WIDTH/375, 40*HEIGHT/667)];
    alarmBtn.backgroundColor = [UIColor redColor];
    [alarmBtn setTitle:@"一 键 报 警" forState:UIControlStateNormal];
    [alarmBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [alarmBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    alarmBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    [alarmBtn addTarget:self action:@selector(KeyAlarm) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:alarmBtn];
    
    UIButton *addBtn = [[UIButton alloc]initWithFrame:CGRectMake(300*WIDTH/375, 380*HEIGHT/667, 50*WIDTH/375, 50*HEIGHT/667)];
    UIImageView *addImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 50*WIDTH/375, 50*HEIGHT/667)];
   // addBtn.backgroundColor = [UIColor blueColor];
    addImage.image = [UIImage imageNamed:@"Chat_take_picture.png"];
    [addBtn addSubview:addImage];
    [addBtn addTarget:self action:@selector(AddPhotoImage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addBtn];
    
      // playProgress.hidden = YES;
   // [self.view addSubview:playProgress];
    
}

//点击空白处隐藏键盘
- (void)setUpForDismissKeyboard {
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    UITapGestureRecognizer *singleTapGR =
    [[UITapGestureRecognizer alloc] initWithTarget:self
                                            action:@selector(tapAnywhereToDismissKeyboard:)];
    NSOperationQueue *mainQuene =[NSOperationQueue mainQueue];
    [nc addObserverForName:UIKeyboardWillShowNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view addGestureRecognizer:singleTapGR];
                }];
    [nc addObserverForName:UIKeyboardWillHideNotification
                    object:nil
                     queue:mainQuene
                usingBlock:^(NSNotification *note){
                    [self.view removeGestureRecognizer:singleTapGR];
                }];
}

- (void)tapAnywhereToDismissKeyboard:(UIGestureRecognizer *)gestureRecognizer {
    //此method会将self.view里所有的subview的first responder都resign掉
    [self.view endEditing:YES];
}


- (void)UUInputFunctionView:(UUInputFunctionView *)funcView sendVoice:(NSData *)voice time:(NSInteger)second
{
    
    //NSData *voiceData = [NSData dataWithContentsOfFile:[self mp3Path]];
    NSDate *sendDate;
    NSString *mp3Path = [CoreArchive strForKey:@"path"];
    NSLog(@"-----%@",mp3Path);

    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    sendDate = [NSDate date];
    NSString *sendTime=[dateformatter stringFromDate:sendDate];

    NSDictionary *dic = @{@"voice": voice,
                          @"voice_time": [NSString stringWithFormat:@"%d",(int)second],@"createDate":sendTime,@"voice_url":mp3Path};
    
    NSString *voiceTime = [NSString stringWithFormat:@"%d",(int)second];
    [CoreArchive setStr:voiceTime key:@"timeLength"];
    UUMessage *message = [UUMessage UUMessageModelWithDict:dic];
    [audioArray addObject:message];
        [WGAPI post:API_UPLOADFILE RequestParam:voice withFileName:mp3Path FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
        
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infoJson = [CMTool parseJSONStringToNSDictionary:json];
            if(infoJson != nil){
                
                NSDictionary *pathJson = [infoJson objectForKey:@"data"];
                voicePath = [pathJson objectForKey:@"path_0"];
                NSLog(@"%@",voicePath);
                
                 [self performSelectorOnMainThread:@selector(saveVoicePath) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
            }
        
        }
        
    }];
    
    [helpMessage reloadData];
}

-(void)saveVoicePath
{

    NSString *path = voicePath;
    [CoreArchive setStr:path key:@"voicePath"];
    [self VoiceAlarm];

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
    
        n = keyInfoArray.count;
    }else if (section == 1){
    
        n = photoAlarmArray.count;
    }else if (section == 2){
    
        n = audioArray.count;
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
        
        OneKeyAlarmModel *model = [keyInfoArray objectAtIndex:indexPath.row];
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
        
        TextPhotoAlarmModel *model = [photoAlarmArray objectAtIndex:indexPath.row];
        photocell.photoKeyAlarm = model;
        
        NSString *content = photocell.stateLab.text;
        if([content isEqualToString:@"已发送"]){
            
            photocell.stateLab.textColor = [UIColor greenColor];
        }else{
            
            photocell.stateLab.textColor = [UIColor redColor];
            
        }
            cell = photocell;

    }else if (indexPath.section == 2){
        
        UUMessageCell *voicecell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
        if (voicecell == nil) {
            
            voicecell = [[UUMessageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
            voicecell.accessoryType = UITableViewCellAccessoryNone;
            voicecell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
            voicecell.selectionStyle = UITableViewCellSelectionStyleNone;
            voicecell.delegate = self;
        }

        UUMessage *message = [audioArray objectAtIndex:indexPath.row];
        voicecell.message = message;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{


}

//将图片保存到document
-(NSString *)saveImage:(UIImage *)tempImage
{
    NSString *fileNameHead = [NSDateString ret32bitString];
    NSString *imageName = [fileNameHead stringByAppendingString:@".png"];
    NSData *imageData = UIImagePNGRepresentation(tempImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString* fullPathToFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSLog(@"%@",fullPathToFile);
    // and then we write it out
    [imageData writeToFile:fullPathToFile atomically:NO];
    //[self upLoadImage:fullPathToFile];
    return fullPathToFile;
}

-(NSString *)documentFolderPath
{
    
    return [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
}

-(void)flushImageViews:(NSMutableArray *)arrayMutable
{
    
    TextPhotoAlarmModel *model;
    NSDate *sendDate;
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
   [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
    
    for (UIImage* image in arrayMutable) {
        
        sendDate = [NSDate date];
        NSString *locationString=[dateformatter stringFromDate:sendDate];
        model = [[TextPhotoAlarmModel alloc]init];
        
        photoImage = image;
        model.image = image;
        model.time = locationString;
        model.message = IFView.TextViewInput.text;
        [photoAlarmArray addObject:model];
        //[self upLoadImage:image];
        NSString *fileName = [self saveImage:image];
        [self upLoadImage:image withFileName:fileName];
        
    }
    
    [helpMessage reloadData];
    [self savePhotoAlarmInfo];
    
    if(IFView.TextViewInput.text != nil){
    
         IFView.TextViewInput.text = nil;
    }
   
    
}

//上传图片
-(void)upLoadImage:(UIImage *)image withFileName:(NSString *)imageName
{
    [WGAPI post:API_UPLOADFILE RequsetParam:image withFileName:imageName FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infoJson = [CMTool parseJSONStringToNSDictionary:json];
            if(infoJson != nil){
            
                NSDictionary *pathJson = [infoJson objectForKey:@"data"];
                imagePath = [pathJson objectForKey:@"path_0"];
                NSLog(@"图片路径%@",imagePath);
                [self performSelectorOnMainThread:@selector(saveImageData) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
            }
            
            //[CoreArchive setStr:imagePath key:@"imagePath"];
            
            
        }
    }];
    
    
}

-(void)saveImageData
{
    NSString *path = imagePath;
    [CoreArchive setStr:path key:@"imagePath"];

}

//保存图文报警信息
-(void)savePhotoAlarmInfo
{
    
    NSString *path = [CoreArchive strForKey:@"imagePath"];
    NSDictionary *params = @{@"type":@"1",@"title":@"图文报警",@"content":IFView.TextViewInput.text,@"image_url":path};
    NSString *paramsStr = [CMTool dictionaryToJson:params];
    NSString *str = @"help=";
    paramsStr = [str stringByAppendingString:paramsStr];
    
    [WGAPI post:API_ADD_HELP RequestParams:paramsStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
            
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
            if(infojson != nil){
                
                NSDictionary *messageJson = [infojson objectForKey:@"data"];
                helpId = [messageJson objectForKey:@"help_id"];
                if(helpId != nil){
                    
                    [self performSelectorOnMainThread:@selector(responseOfKeyAlarm) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
                    
                    
                }
                
            }
            
        }
    }];

    
//    NSDate *sendDate;
//    sendDate = [NSDate date];
//    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//    [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
//    NSString *time=[dateformatter stringFromDate:sendDate];
    
   
//    //判断是否以创建文件
//    if ([[NSFileManager defaultManager] fileExistsAtPath:plistPath])
//    {
//        //此处可以自己写显示plist文件内容
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//        [dict setObject:infoText.text forKey:@"message"];
//        [dict setObject:time forKey:@"time"];
//        //[dict setObject:photoImage forKey:@"icon"];
//        [saveArray addObject:dict];
//        [saveArray writeToFile:plistPath atomically:YES];
//        //NSLog(@"文件已存在");
//    }
//    else
//    {
//        
//        [arrayPlist writeToFile:plistPath atomically:YES];
//        
//    }

}

-(void)VoiceAlarm
{
    NSString *path = [CoreArchive strForKey:@"voicePath"];
    NSString *voiceTime = [CoreArchive strForKey:@"timeLength"];
    NSDictionary *params = @{@"type":@"2",@"title":@"语音报警",@"voice_url":path,@"voice_time":voiceTime};
    NSString *paramsStr = [CMTool dictionaryToJson:params];
    NSString *str = @"help=";
    paramsStr = [str stringByAppendingString:paramsStr];
    
    [WGAPI post:API_ADD_HELP RequestParams:paramsStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
            
            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
            if(infojson != nil){
                
                NSDictionary *messageJson = [infojson objectForKey:@"data"];
                helpId = [messageJson objectForKey:@"help_id"];
                if(helpId != nil){
                    
                    //[self performSelectorOnMainThread:@selector(responseOfKeyAlarm) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
                    
                    
                }
                
            }
            
        }
        
    }];

}

//一键报警按钮触发事件
-(void)KeyAlarm
{

    __block NSString *string;
    if (IS_IOS8) {
        
        [[CCLocationManager shareLocation]getLocationCoordinate:^(CLLocationCoordinate2D locationCorrrdinate) {
            
            string = [NSString stringWithFormat:@"%f %f",locationCorrrdinate.latitude,locationCorrrdinate.longitude];
        } withAddress:^(NSString *addressString) {
           // NSLog(@"%@",addressString);
            string = [NSString stringWithFormat:@"%@\n%@",string,addressString];
            [SVProgressHUD showWithStatus:@"发送中..."];
            if(string != nil){
                OneKeyAlarmModel *model;
                NSDate *sendDate;
                NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
                [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
                NSString *locationString=[dateformatter stringFromDate:sendDate];
                NSDictionary *params = @{@"type":@"0",@"title":@"一键报警",@"content":string};
                
                model = [[OneKeyAlarmModel alloc]init];
                model.location = string;
                model.time = locationString;
                [keyInfoArray addObject:model];

                NSString *paramsStr = [CMTool dictionaryToJson:params];
                NSString *str = @"help=";
                paramsStr = [str stringByAppendingString:paramsStr];
                
                [WGAPI post:API_ADD_HELP RequestParams:paramsStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                        
                    if(data){
                            
                            NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
                            if(infojson != nil){
                            
                                NSDictionary *messageJson = [infojson objectForKey:@"data"];
                                helpId = [messageJson objectForKey:@"help_id"];
                                if(helpId != nil){
                                
                                    [self performSelectorOnMainThread:@selector(responseOfKeyAlarm) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)

                                }
                            
                            }
                        
                        }
                    }];
                
            }else{
            
                 [self performSelectorOnMainThread:@selector(showLocationError) withObject:addressString waitUntilDone:YES];//通知主线程刷新(UI)
            
            }
            
        }];
    }

}

-(void)showLocationError
{

     [SVProgressHUD showWithStatus:@"获取位置信息失败！"];

}

-(void)getHelpMessage
{
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"100"};
    NSDictionary *pageInfo = @{@"page":page};
    NSString *pageStr = [pageInfo JSONString];
    NSString *helpInfoData = [@"help=" stringByAppendingString:pageStr];
    
    
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
        
    }else{
        [SVProgressHUD showWithStatus:@"加载中..."];
        [WGAPI post:API_GETHELPINFO RequestParams:helpInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if(data){
            
                NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSLog(@"%@",jsonStr);
                NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            
                if(infojson != nil){
                
                    tempArray = [infojson objectForKey:@"datas"];
                    for(NSDictionary *dict in tempArray){
                        NSString *type = [NSString stringWithFormat:@"%@",[dict objectForKey:@"type"]];
                   
                        if ([type isEqualToString:@"0"]) {
                        
                            OneKeyAlarmModel *model = [OneKeyAlarmModel OneKeyAlarmModelWithDict:dict];
                            [keyInfoArray addObject:model];
                        }else if ([type isEqualToString:@"1"]){
                    
                            TextPhotoAlarmModel *model = [TextPhotoAlarmModel TextPhotoAlarmModelWithDict:dict];
                            [photoAlarmArray addObject:model];
                        }else if ([type isEqualToString:@"2"]){
                    
                            UUMessage *model = [UUMessage UUMessageModelWithDict:dict];
                            model.voice =[NSData dataWithContentsOfURL:[NSURL URLWithString:model.voiceUrl]];

                            [audioArray addObject:model];
                    
                        }
                    
                    }
                
                }

                [self performSelectorOnMainThread:@selector(refreshData) withObject:data waitUntilDone:YES];
            }
        }];
    }
    
}

-(void)responseOfKeyAlarm
{
    
    [SVProgressHUD showSuccessWithStatus:@"发送成功！" maskType:SVProgressHUDMaskTypeBlack];
    [helpMessage reloadData];
    //[keyInfoArray removeAllObjects];
    //[photoAlarmArray removeAllObjects];
    //[self getHelpMessage];
    
}


-(void)refreshData
{
    [SVProgressHUD showSuccessWithStatus:@"加载完成！" maskType:SVProgressHUDMaskTypeBlack];
    [helpMessage reloadData];
    
}

////刷新录音列表
//-(void)flushRecoder
//{
//    
//        VoiceAlarmModel *model;
//        NSDate *sendDate;
//        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
//        [dateformatter setDateFormat:@"YYYY-MM-dd hh:mm:ss"];
//    
//        sendDate = [NSDate date];
//        NSString *recordTime = [dateformatter stringFromDate:sendDate];
//        model = [[VoiceAlarmModel alloc]init];
//        model.time = recordTime;
//        model.url = urlStr;
//        [_voiceAlarmData addObject:model];
//    
//        [helpMessage reloadData];
//    
//    //判断是否以创建文件
//    if ([[NSFileManager defaultManager] fileExistsAtPath:voicePlistPath])
//    {
//        //此处可以自己写显示plist文件内容
//        NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
//        [dict setObject:urlStr forKey:@"url"];
//        [dict setObject:recordTime forKey:@"time"];
//        //[dict setObject:location forKey:@"state"];
//        [saveVoiceInfoArray addObject:dict];
//        [saveVoiceInfoArray writeToFile:voicePlistPath atomically:YES];
//        NSLog(@"文件已存在");
//    }
//    else
//    {
//        
//        [voiceInfoArrayPlist writeToFile:voicePlistPath atomically:YES];
//        
//    }
//
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
