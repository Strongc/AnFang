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
#import "VideoTableViewCell.h"
#import "VideoModel.h"
#import "JSONKit.h"
#import "WGAPI.h"
#import "CMTool.h"

@interface DeviceManagerViewController ()
{

    UITableView *videoList;
    NSMutableArray *tempArray;
    NSMutableArray *videoArray;
    UILabel *alertLab;
}

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
    videoArray = [[NSMutableArray alloc]init];
    tempArray = [[NSMutableArray alloc]init];
    [self getVideoInfoById];
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
    //NSString *text1 = [text stringByAppendingString:self.deviceName];
    devArea.text = text;
    devArea.textColor = [UIColor blackColor];
    devArea.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devArea];
    
    UIImageView *devImage = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH/375, 120*HEIGHT/667, 125*WIDTH/375, 125*HEIGHT/667)];
    devImage.image = [UIImage imageNamed:@"dev.png"];
    [self.view addSubview:devImage];

    UILabel *devVendor = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 130*HEIGHT/667, 150*WIDTH/375, 15*HEIGHT/667)];
    NSString *ventorTitle = @"厂商:    ";
    devVendor.text = [ventorTitle stringByAppendingString:self.devVendor];
    devVendor.textColor = [UIColor blackColor];
    devVendor.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devVendor];
    
    UILabel *devModel = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 160*HEIGHT/667, 200*WIDTH/375, 15*HEIGHT/667)];
    NSString *modelHead = @"型号:    ";
    devModel.text = [modelHead stringByAppendingString:self.devModel];
    devModel.textColor = [UIColor blackColor];
    devModel.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devModel];
    
    UILabel *devParam = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 190*HEIGHT/667, 240*WIDTH/375, 15*HEIGHT/667)];
    NSString *paramHead = @"设备参数:    ";
    devParam.text = [paramHead stringByAppendingString:self.devParam];
    devParam.textColor = [UIColor blackColor];
    devParam.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devParam];
    
//    UILabel *dataStore = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 190*HEIGHT/667, 100*WIDTH/375, 15*HEIGHT/667)];
//    dataStore.text = @"数据存储：32G";
//    dataStore.textColor = [UIColor blackColor];
//    dataStore.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
//    [self.view addSubview:dataStore];
    
//    UILabel *connectStyle = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 215*HEIGHT/667, 130*WIDTH/375, 15*HEIGHT/667)];
//    connectStyle.text = @"接入方式：云接入";
//    connectStyle.textColor = [UIColor blackColor];
//    connectStyle.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
//    [self.view addSubview:connectStyle];
    
    UILabel *devState = [[UILabel alloc]initWithFrame:CGRectMake(140*WIDTH/375, 220*HEIGHT/667, 120*WIDTH/375, 15*HEIGHT/667)];
    NSString *stateHead = @"设备状态:   ";
    devState.text = [stateHead stringByAppendingString:self.deviceState];
    devState.textColor = [UIColor blackColor];
    devState.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
//    [self.view addSubview:devState];
//    UILabel *devState1 = [[UILabel alloc]initWithFrame:CGRectMake(210*WIDTH/375, 240*HEIGHT/667, 90*WIDTH/375, 15*HEIGHT/667)];
    //devState.text = self.deviceState;
    if([devState.text isEqualToString:@"已关机"]){
        
        devState.textColor = [UIColor grayColor];
    }else if ([devState.text isEqualToString:@"工作正常"]){
        
        devState.textColor = [UIColor greenColor];
    }else if([devState.text isEqualToString:@"无法连接"]){
        
        devState.textColor = [UIColor redColor];
    }
    
    devState.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:devState];
    
    UIButton *timeMonitor = [[UIButton alloc]initWithFrame:CGRectMake(10*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
    //[self.view addSubview:timeMonitor];
    timeMonitor.backgroundColor = [UIColor orangeColor];
    timeMonitor.titleLabel.textColor= [UIColor whiteColor];
    timeMonitor.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [timeMonitor setTitle:@"实时监控" forState:UIControlStateNormal];
    
    UIButton *setBtn = [[UIButton alloc]initWithFrame:CGRectMake(100*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
   // [self.view addSubview:setBtn];
    setBtn.backgroundColor = [UIColor grayColor];
    setBtn.titleLabel.textColor= [UIColor whiteColor];
    setBtn.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [setBtn setTitle:@"设置" forState:UIControlStateNormal];
    
    UIButton *videoManager = [[UIButton alloc]initWithFrame:CGRectMake(190*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
   // [self.view addSubview:videoManager];
    videoManager.backgroundColor = [UIColor blueColor];
    videoManager.titleLabel.textColor= [UIColor whiteColor];
    videoManager.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [videoManager setTitle:@"管理视频" forState:UIControlStateNormal];
    [videoManager addTarget:self action:@selector(jumpToVideoManagerView) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *closeDev = [[UIButton alloc]initWithFrame:CGRectMake(280*WIDTH/375, 280*HEIGHT/667, 80*WIDTH/375, 30*HEIGHT/667)];
    //[self.view addSubview:closeDev];
    closeDev.backgroundColor = [UIColor redColor];
    closeDev.titleLabel.textColor= [UIColor whiteColor];
    closeDev.titleLabel.font= [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [closeDev setTitle:@"关闭设备" forState:UIControlStateNormal];
    
    UIView *blueLine = [[UIView alloc]initWithFrame:CGRectMake(0, 290*HEIGHT/667, WIDTH, 3.0)];
    [self.view addSubview:blueLine];
    blueLine.backgroundColor = [UIColor colorWithHexString:@"6495ED"];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 293*HEIGHT/667, WIDTH, 40*HEIGHT/667)];
    [self.view addSubview:titleView];
    titleView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    UIView *grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, 333*HEIGHT/667, WIDTH, 3.0)];
    [self.view addSubview:grayLine];
    grayLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15*WIDTH/375, 10*HEIGHT/667, 80*WIDTH/375, 20*HEIGHT/667)];
    [titleView addSubview:title5];
    title5.text = @"视频列表";
    title5.textColor = [UIColor blackColor];
    title5.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    
    videoList = [[UITableView alloc] initWithFrame:CGRectMake(0, 336*HEIGHT/667, WIDTH, HEIGHT) style:UITableViewStylePlain];
    videoList.delegate = self;
    videoList.dataSource = self;
    videoList.separatorStyle = UITableViewCellSeparatorStyleNone;
    videoList.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.view addSubview:videoList];
    
    alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 350, WIDTH, 15*HEIGHT/667)];
    [self.view addSubview:alertLab];
    alertLab.text = @"暂无内容！";
    alertLab.textAlignment = NSTextAlignmentCenter;
//    if(videoArray.count != 0){
//    
//        alertLab.hidden = YES;
//    }else{
//    
//        alertLab.hidden = NO;
//    }


}

-(void)getVideoInfoById
{

    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"5"};
    NSDictionary *pageInfo = @{@"cam_id":self.devId,@"page":page};
    NSString *pageStr = [pageInfo JSONString];
    NSString *videoInfoData = [@"video=" stringByAppendingString:pageStr];

    [WGAPI post:API_GET_VIDEOINFO RequestParams:videoInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {

        if(data){

             NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@",jsonStr);
             NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
            
                NSDictionary *videoInfo = [infojson objectForKey:@"data"];
                tempArray = [videoInfo objectForKey:@"datas"];
                for(NSDictionary *dict in tempArray){
                
                    VideoModel *model = [VideoModel VideoWithDict:dict];
                    [videoArray addObject:model];
                }
            
            }
            [self performSelectorOnMainThread:@selector(refreshData) withObject:data waitUntilDone:YES];

        }
    }];


}

-(void)backAction
{
    //NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)refreshData
{
    if(videoArray.count > 0){
        
        alertLab.hidden = YES;
    }else if (videoArray.count == 0){
    
        alertLab.hidden = NO;;
    }
    [videoList reloadData];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return videoArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentify = @"cell";
    VideoTableViewCell *cell = (VideoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if(cell == nil){
        
        cell = [[VideoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    VideoModel *model = [videoArray objectAtIndex:indexPath.row];
    cell.videoModel = model;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 60.0*WIDTH/375;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    VideoModel *model = [videoArray objectAtIndex:indexPath.row];
    
    NSString *url = model.videoUrl;
    [self jumpToVideoManagerView:url];

}


-(void)jumpToVideoManagerView:(NSString *)videoUrl
{
    
   UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   JRPlayerViewController *videoPlayer = [[mainView instantiateViewControllerWithIdentifier:@"videoPlayer"] initWithHTTPLiveStreamingMediaURL:[NSURL URLWithString:videoUrl]];
    
    videoPlayer.navigationController.navigationBarHidden = NO;
    videoPlayer.hidesBottomBarWhenPushed = NO;
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
