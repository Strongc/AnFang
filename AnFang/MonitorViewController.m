//
//  MonitorViewController.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MonitorViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "MonitorInfoTableViewCell.h"
#import "WGAPI.h"
#import "JSONKit.h"
#import "CMTool.h"
#import "CameraModel.h"
#import "SDRefresh.h"
#import "CoreArchive.h"
#import "SVProgressHUD.h"
#import "VideoListViewController.h"
#import "UUAVAudioPlayer.h"

@interface MonitorViewController ()
{
    
    UITableView *monitorTable;
    NSMutableArray *defenceAreaName;
    NSMutableArray *defenceAreaInfo;
    NSMutableArray *defenceAreaImage;
    NSMutableArray *tempArray;
    NSMutableArray *tempHostArray;
   // NSString *areaId;
    NSString *tempId;
   // NSString *hostId;
    NSString *hostStatus;
    NSString *onLineStatus;
    NSString *bufangInfo;
    NSMutableArray *cameraArray;
    int pageSize;
    UIButton *chefangBtn;
    UIButton *bufangBtn;
    UILabel *stateLab;
    UILabel *onlineLab;
    UIImageView *stateImageView;
    UIButton *stateBtn;
    NSTimer *timer;
    
}
@property (nonatomic,strong) NSArray *sourceData;
@property (nonatomic,weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic,weak) SDRefreshFooterView *refreshFooter;

@end

@implementation MonitorViewController

-(NSArray *)sourceData
{
    
    if(_sourceData == nil){
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MonitorArea.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            CameraModel *model = [CameraModel CameraWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _sourceData = arrayModels;
        
    }
    
    return _sourceData;
    
}

-(void)viewWillAppear:(BOOL)animated
{
   
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self.view endEditing:YES];
    self.view.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    self.view.backgroundColor = [UIColor whiteColor];
   
    
    NSString *userId = [CoreArchive strForKey:@"userId"];
    NSLog(@"%@",userId);
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    CGFloat navBarHeight = 44*HEIGHT/667;
    CGRect rect = CGRectMake(0, 0, WIDTH, navBarHeight);
    [bar setFrame:rect];
    
    defenceAreaName = [[NSMutableArray alloc]initWithObjects:@"防区001: 华业大厦广场北区", @"防区002: 华业大厦广场南区",@"防区003: 华业大厦广场东区",@"防区004: 华业大厦广场西区",nil];
    
    defenceAreaInfo = [[NSMutableArray alloc]initWithObjects:@"   车位监控3个，大楼摄像机1个，北墙西墙红外探头2对...",@"   车位监控2个，大楼摄像机1个，北墙西墙红外探头3对...",@"   车位监控1个，大楼摄像机1个，北墙西墙红外探头4对...",@"   车位监控3个，大楼摄像机3个，北墙西墙红外探头2对...", nil];

    tempArray = [[NSMutableArray alloc]init];
    cameraArray = [[NSMutableArray alloc]init];
    tempHostArray = [[NSMutableArray alloc]init];
    pageSize = 1;
    [self getUserHostInfo];
    [self setButtonStatus];
    [self ConfigControl];
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(getUserHostInfo) userInfo:nil repeats:YES];
    // Do any additional setup after loading the view.
}

-(void)ConfigControl
{
    
    UIImageView *background = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:background];
    background.image = [UIImage imageNamed:@"anfangBack"];
    
//    UIView *blueLine = [[UIView alloc]initWithFrame:CGRectMake(0, 430*HEIGHT/667, WIDTH, 3.0)];
//    [self.view addSubview:blueLine];
//    blueLine.backgroundColor = [UIColor colorWithHexString:@"6495ed"];

    //UIView *backGroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,blueLine.frame.origin.y)];
    //[self.view addSubview:backGroundView];
   // backGroundView.backgroundColor = [UIColor colorWithHexString:@"ffffe0"];
    
    //NSString *path = [[NSBundle mainBundle] pathForResource:@"yh.png" ofType:nil];
   // NSString *pathSelected = [[NSBundle mainBundle] pathForResource:@"yh_select.png" ofType:nil];
    stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(40, 30, WIDTH-80, 300*HEIGHT/667)];
    stateBtn = [[UIButton alloc] initWithFrame:CGRectMake(40, 30, WIDTH - 80, 300*HEIGHT/667)];
    //[backGroundView addSubview:stateBtn];
    //stateImageView.image = [UIImage imageNamed:@"state"];
    [stateBtn setBackgroundImage:[UIImage imageNamed:@"state"] forState:UIControlStateNormal];
    //[stateBtn setBackgroundImage:[UIImage imageWithContentsOfFile:pathSelected] forState:UIControlStateHighlighted];
    [self.view addSubview:stateBtn];
    //[stateBtn addTarget:self action:@selector(getUserHostInfo) forControlEvents:UIControlEventTouchUpInside];
    
    stateLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 130*HEIGHT/667,WIDTH-80, 20)];
    stateLab.text = @"已布防";
    stateLab.textColor = [UIColor whiteColor];
    stateLab.textAlignment = NSTextAlignmentCenter;
    stateLab.font = [UIFont systemFontOfSize:30*WIDTH/375];
    [stateBtn addSubview:stateLab];
    
    onlineLab = [[UILabel alloc]initWithFrame:CGRectMake(120*WIDTH/375, 170*HEIGHT/667, 60*WIDTH/375, 20*HEIGHT/667)];
    onlineLab.text = @"在线";
    onlineLab.textColor = [UIColor whiteColor];
    onlineLab.textAlignment = NSTextAlignmentCenter;
    onlineLab.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    [stateBtn addSubview:onlineLab];
    
   // NSString *path1 = [[NSBundle mainBundle] pathForResource:@"bufang_nor.png" ofType:nil];
    //NSString *path2 = [[NSBundle mainBundle] pathForResource:@"bufang_select.png" ofType:nil];
    bufangBtn = [[UIButton alloc]initWithFrame:CGRectMake(60*WIDTH/375, 420*HEIGHT/667, 60*WIDTH/375, 60*HEIGHT/667)];
    [bufangBtn setBackgroundImage:[UIImage imageNamed:@"bufang"] forState:UIControlStateNormal];
    [bufangBtn setBackgroundImage:[UIImage imageNamed:@"bufangSelect"] forState:UIControlStateHighlighted];
    [bufangBtn addTarget:self action:@selector(BuFangRequestAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:bufangBtn];
    
    chefangBtn = [[UIButton alloc]initWithFrame:CGRectMake(160*WIDTH/375, 420*HEIGHT/667, 60*WIDTH/375, 60*HEIGHT/667)];
    [self.view addSubview:chefangBtn];
    //NSString *path5 = [[NSBundle mainBundle] pathForResource:@"chefang.png" ofType:nil];
    //NSString *path6 = [[NSBundle mainBundle] pathForResource:@"chefang_select.png" ofType:nil];
    [chefangBtn setBackgroundImage:[UIImage imageNamed:@"chefang"] forState:UIControlStateNormal];
    [chefangBtn setBackgroundImage:[UIImage imageNamed:@"chefangSelect"] forState:UIControlStateHighlighted];
    [chefangBtn addTarget:self action:@selector(CheFangAction) forControlEvents:UIControlEventTouchUpInside];

    UIButton *cameraBtn = [[UIButton alloc] initWithFrame:CGRectMake(260*WIDTH/375, 425*HEIGHT/667, 60*WIDTH/375, 55*HEIGHT/667)];
    [self.view addSubview:cameraBtn];

    //NSString *path3 = [[NSBundle mainBundle] pathForResource:@"video" ofType:nil];
    //NSString *path4 = [[NSBundle mainBundle] pathForResource:@"videoSelect" ofType:nil];
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"video"] forState:UIControlStateNormal];
    [cameraBtn setBackgroundImage:[UIImage imageNamed:@"videoSelect"] forState:UIControlStateHighlighted];
    [cameraBtn addTarget:self action:@selector(gotoVideoListView) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)gotoVideoListView
{

    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VideoListViewController *videoListView = [mainView instantiateViewControllerWithIdentifier:@"videoListId"];
    [self.navigationController pushViewController:videoListView animated:YES];
}

//获取当前用户的主机信息
-(void)getUserHostInfo
{
    
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"2"};
    NSDictionary *pageInfo = @{@"page":page};
    NSString *pageStr = [pageInfo JSONString];
    NSString *hostInfoData = [@"host=" stringByAppendingString:pageStr];
    
    [WGAPI post:API_GET_HOSTINFO RequestParams:hostInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",jsonStr);
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
                NSDictionary *messageInfo = [infojson objectForKey:@"data"];
                 NSString *messageInfoStr = [CMTool dictionaryToJson:messageInfo];
                 NSLog(@"主机信息：%@",messageInfoStr);
                tempHostArray = [messageInfo objectForKey:@"datas"];
                if(tempHostArray.count > 0){
                    NSDictionary *dict = tempHostArray[0];
                    _hostId = [dict objectForKey:@"host_id"];
                    onLineStatus = [dict objectForKey:@"host_status"];
                    hostStatus = [dict objectForKey:@"rCStatus"];
                    //[self BuFangRequestAction:@"201510231107140078"];

                }
                [self performSelectorOnMainThread:@selector(setButtonStatus) withObject:data waitUntilDone:YES];//刷新UI线程

            }
            
        }
        
    }];

}

//设置撤部防按钮状态
-(void) setButtonStatus{

    [CoreArchive setStr:_hostId key:@"hostId"];
    if([hostStatus isEqualToString:@"FALSE"]){
    
        stateLab.text = @"已撤防";
        stateLab.textColor = [UIColor whiteColor];
        chefangBtn.userInteractionEnabled = NO;
        bufangBtn.userInteractionEnabled = YES;
        
    }else if ([hostStatus isEqualToString:@"TRUE"]){
    
        stateLab.text = @"已布防";
        stateLab.textColor = [UIColor whiteColor];
        chefangBtn.userInteractionEnabled = YES;
        bufangBtn.userInteractionEnabled = NO;
    }else if ([onLineStatus isEqualToString:@"TRUE"]){
    
        onlineLab.text = @"在线";
    }else if ([onLineStatus isEqualToString:@"FALSE"]){
    
        onlineLab.text = @"离线";
    }

}

//布防
-(void)BuFangRequestAction
{

    NSString *hostIds = [CoreArchive strForKey:@"hostId"];
    NSString *hostParam;
    if(hostIds != nil){
        
        hostParam = [@"hostIds=" stringByAppendingString:hostIds];
    }

    [WGAPI post:API_ADDLINE RequestParams:hostParam FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
        
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
            
                bufangInfo = [infojson objectForKey:@"data"];
                if([bufangInfo isEqualToString:@"sucess"]){
            
                    [self performSelectorOnMainThread:@selector(ResponseInfo) withObject:data waitUntilDone:YES];//刷新UI线程
                }
                
            }
        
        }
    }];


}

-(void)ResponseInfo
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"bufang.mp3" ofType:nil];
    bufangBtn.userInteractionEnabled = NO;
    [SVProgressHUD showSuccessWithStatus:@"布防成功！" maskType:SVProgressHUDMaskTypeBlack];
    //stateLab.text = @"已布防";
    //stateLab.textColor = [UIColor whiteColor];
    chefangBtn.userInteractionEnabled = YES;
    [self getUserHostInfo];
   // [self performSelector:@selector(playAudioWithFile:) withObject:audioFilePath afterDelay:3.0];

}

-(void)CheFangRequest
{
    [timer invalidate];
    //NSString *hostParam = [@"hostIds=" stringByAppendingString:@"201510231107140078"];
    NSString *hostIds = [CoreArchive strForKey:@"hostId"];
    NSString *hostParam;
    if(hostIds != nil){
        
        hostParam = [@"hostIds=" stringByAppendingString:hostIds];
    }

    [WGAPI post:API_REMOVELINE RequestParams:hostParam FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
                
                bufangInfo = [infojson objectForKey:@"data"];
                if([bufangInfo isEqualToString:@"sucess"]){
                    
                    [self performSelectorOnMainThread:@selector(ResponseInfo2) withObject:data waitUntilDone:YES];//刷新UI线程
                }
                
            }
            
        }
    }];

}

-(void)ResponseInfo2
{
    NSString *audioFilePath = [[NSBundle mainBundle] pathForResource:@"chefang.mp3" ofType:nil];
    chefangBtn.userInteractionEnabled = NO;
    [SVProgressHUD showSuccessWithStatus:@"撤防成功！" maskType:SVProgressHUDMaskTypeBlack];
    //stateLab.text = @"已撤防";
    //stateLab.textColor = [UIColor whiteColor];
     [self getUserHostInfo];
    bufangBtn.userInteractionEnabled = YES;
    //[self performSelector:@selector(playAudioWithFile:) withObject:audioFilePath afterDelay:3.0];
    //timer = [NSTimer scheduledTimerWithTimeInterval:6.0 target:self selector:@selector(getUserHostInfo) userInfo:nil repeats:YES];

}

-(void)playAudioWithFile:(NSString *)path
{
    UUAVAudioPlayer *player = [UUAVAudioPlayer sharedInstance];
    [player playSongWithUrl:path];

}

-(void)getOrgInfo
{

    [WGAPI post:API_GETORGINFO RequestParams:nil FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
                
                //bufangInfo = [infojson objectForKey:@"data"];
//                if([bufangInfo isEqualToString:@"sucess"]){
//                    
//                    
//                    [self performSelectorOnMainThread:@selector(ResponseInfo2) withObject:data waitUntilDone:YES];//刷新UI线程
//                }
                
            }
            
            
        }
    }];

}


-(void)CheFangAction
{
    
    UIAlertView* alert = [[UIAlertView alloc]initWithTitle:nil
                                                   message:@"确定要撤防？"
                                                  delegate:self
                                         cancelButtonTitle:@"确定"
                                         otherButtonTitles:@"取消",nil];
    
    [alert show];

}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
            [self CheFangRequest];
            break;
            
        case 1:
            NSLog(@"%ld",(long)buttonIndex);
            break;
        default:
            break;
    }
    
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
