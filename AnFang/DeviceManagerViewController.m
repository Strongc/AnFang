//
//  DeviceManagerViewController.m
//  AnBao
//
//  Created by mac   on 15/9/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "DeviceManagerViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "JRPlayerViewController.h"

@interface DeviceManagerViewController ()

@end

@implementation DeviceManagerViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self ConfigControl];
    
    // Do any additional setup after loading the view.
}

-(void)ConfigControl
{

    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64*HEIGHT/667)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"设备管理";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH/375, 7*HEIGHT/667, 32, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont systemFontOfSize:16];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5*HEIGHT/667, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];

    UILabel *devArea = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH/375, 80*HEIGHT/667, 280*WIDTH/375, 15*HEIGHT/667)];
    NSString *text = @"华业大厦广场北区－";
    NSString *text1 = [text stringByAppendingString:self.deviceName];
    devArea.text = text1;
    devArea.textColor = [UIColor blackColor];
    devArea.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devArea];
    
    UIImageView *devImage = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH/375, 120*HEIGHT/667, 125*WIDTH/375, 125*HEIGHT/667)];
    devImage.image = [UIImage imageNamed:@"dev.png"];
    [self.view addSubview:devImage];

    UILabel *devStyle = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 115*HEIGHT/667, 150*WIDTH/375, 15*HEIGHT/667)];
    devStyle.text = @"型号:         T-PCX760";
    devStyle.textColor = [UIColor blackColor];
    devStyle.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devStyle];
    
    UILabel *controlStyle = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 140*HEIGHT/667, 200*WIDTH/375, 15*HEIGHT/667)];
    controlStyle.text = @"控制方式：4轴可控，焦距可控";
    controlStyle.textColor = [UIColor blackColor];
    controlStyle.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:controlStyle];
    
    UILabel *runStyle = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 165*HEIGHT/667, 240*WIDTH/375, 15*HEIGHT/667)];
    runStyle.text = @"运行方式：1分钟视角循环,实时上传";
    runStyle.textColor = [UIColor blackColor];
    runStyle.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:runStyle];
    
    UILabel *dataStore = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 190*HEIGHT/667, 100*WIDTH/375, 15*HEIGHT/667)];
    dataStore.text = @"数据存储：32G";
    dataStore.textColor = [UIColor blackColor];
    dataStore.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:dataStore];
    
    UILabel *connectStyle = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 215*HEIGHT/667, 130*WIDTH/375, 15*HEIGHT/667)];
    connectStyle.text = @"接入方式：云接入";
    connectStyle.textColor = [UIColor blackColor];
    connectStyle.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:connectStyle];
    
    UILabel *devState = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 240*HEIGHT/667, 90*WIDTH/375, 15*HEIGHT/667)];
    devState.text = @"设备状态：";
    devState.textColor = [UIColor blackColor];
    devState.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devState];
    UILabel *devState1 = [[UILabel alloc]initWithFrame:CGRectMake(210*WIDTH/375, 240*HEIGHT/667, 90*WIDTH/375, 15*HEIGHT/667)];
    devState1.text = self.deviceState;
    if([devState1.text isEqualToString:@"已关机"]){
        
        devState1.textColor = [UIColor grayColor];
    }else if ([devState1.text isEqualToString:@"工作正常"]){
        
        devState1.textColor = [UIColor greenColor];
    }else if([devState1.text isEqualToString:@"无法连接"]){
        
        devState1.textColor = [UIColor redColor];
    }
    
    devState1.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devState1];
    
    UIButton *timeMonitor = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
    [self.view addSubview:timeMonitor];
    timeMonitor.backgroundColor = [UIColor orangeColor];
    timeMonitor.titleLabel.textColor= [UIColor whiteColor];
    timeMonitor.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [timeMonitor setTitle:@"实时监控" forState:UIControlStateNormal];
    
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(100*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
    [self.view addSubview:setBtn];
    setBtn.backgroundColor = [UIColor grayColor];
    setBtn.titleLabel.textColor= [UIColor whiteColor];
    setBtn.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    
    UIButton *videoManager = [[UIButton alloc]initWithFrame:CGRectMake(190*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
    [self.view addSubview:videoManager];
    videoManager.backgroundColor = [UIColor blueColor];
    videoManager.titleLabel.textColor= [UIColor whiteColor];
    videoManager.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [videoManager setTitle:@"管理视频" forState:UIControlStateNormal];
    [videoManager addTarget:self action:@selector(jumpToVideoManagerView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeDev = [[UIButton alloc]initWithFrame:CGRectMake(280*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
    [self.view addSubview:closeDev];
    closeDev.backgroundColor = [UIColor redColor];
    closeDev.titleLabel.textColor= [UIColor whiteColor];
    closeDev.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [closeDev setTitle:@"关闭设备" forState:UIControlStateNormal];

}

-(void)backAction
{
    //NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)jumpToVideoManagerView
{
    
   UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   JRPlayerViewController *videoPlayer = [[mainView instantiateViewControllerWithIdentifier:@"videoPlayer"] initWithHTTPLiveStreamingMediaURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
    
    videoPlayer.navigationController.navigationBarHidden = NO;
    videoPlayer.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:videoPlayer animated:YES];

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
