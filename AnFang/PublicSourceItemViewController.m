//
//  PublicSourceItemViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/23.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicSourceItemViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "PublicItemVideoCell.h"
#import "PlayViewController.h"
#import "LMContainsLMComboxScrollView.h"
#define kDropDownListTag 1000

@interface PublicSourceItemViewController ()
{
    NSMutableArray *_lineList;
    int _selectedLineID;
    NSMutableArray *_allSectionList;
    NSMutableArray *_allCameraList;
    NSMutableArray *_allCameraRegionId;
    NSMutableArray *_allVideoList;
    LMContainsLMComboxScrollView *videoScrollView;
    LMComBoxView *cityBoxView;
    NSMutableArray *streetNameArray;//存放街道名称
    NSMutableArray *villageArray;//存放村
    
}

@end

@implementation PublicSourceItemViewController

//获取当前层级的所有资源
- (NSMutableArray *)_getAllResources {
    
    int regionId = self.regionId.intValue;
    
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _allSectionList = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    _allCameraRegionId = [NSMutableArray array];
    //获取区域下的区域
    [vmsNetSDK getRegionListFromRegion:_serverAddress
                           toSessionID:_mspInfo.sessionID
                            toRegionID:regionId
                          toNumPerOnce:60
                             toCurPage:1
                          toRegionList:tempArray];
    [_allSectionList addObjectsFromArray:tempArray];
    
   
    for(int i=0;i<tempArray.count;i++){
        
         CRegionInfo *regionInfo = tempArray[i];
         //[_allCameraRegionId addObject:regionInfo];
      NSMutableArray *tempVideoArray = [self _getAllVideoInSection:regionInfo.regionID];
      [_allVideoList addObject:tempVideoArray];
        
    }

    [tempArray removeAllObjects];

    //获取区域下的设备
    [vmsNetSDK getCameraListFromRegion:_serverAddress
                           toSessionID:_mspInfo.sessionID
                            toRegionID:regionId
                          toNumPerOnce:60
                             toCurPage:1
                          toCameraList:tempArray];
    [_allSectionList addObjectsFromArray:tempArray];

    [tempArray removeAllObjects];
    
    
    return _allSectionList;
}

-(NSMutableArray *)_getAllVideoInSection:(int)regionId
{
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _allCameraList = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    self.serverAddress = _serverAddress;
    self.mspInfo = _mspInfo;
    //获取区域下的区域
    [vmsNetSDK getRegionListFromRegion:_serverAddress
                           toSessionID:_mspInfo.sessionID
                            toRegionID:regionId
                          toNumPerOnce:50
                             toCurPage:1
                          toRegionList:tempArray];
    [_allCameraList addObjectsFromArray:tempArray];
    [tempArray removeAllObjects];
    
    //获取区域下的设备
    [vmsNetSDK getCameraListFromRegion:_serverAddress
                           toSessionID:_mspInfo.sessionID
                            toRegionID:regionId
                          toNumPerOnce:50
                             toCurPage:1
                          toCameraList:tempArray];
    [_allCameraList addObjectsFromArray:tempArray];
    [tempArray removeAllObjects];
    
    return _allCameraList;
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    streetNameArray = [[NSMutableArray alloc]init];
    villageArray = [[NSMutableArray alloc]init];
    _allSectionList = [[NSMutableArray alloc] init];
    _allVideoList = [[NSMutableArray alloc] init];
    [self initViewControlData];
    _serverAddress = @"http://112.12.17.3";
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _lineList = [NSMutableArray array];
    _mspInfo = [[CMSPInfo alloc]init];
    BOOL result = [vmsNetSDK getLineList:_serverAddress toLineInfoList:_lineList];
    _selectedLineID = 2;
    
    if (NO == result) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"获取线路失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    BOOL result1 = [vmsNetSDK login:_serverAddress toUserName:@"dbwl" toPassword:@"12345" toLineID:_selectedLineID toServInfo:_mspInfo];
    if (NO == result1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"登录失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [self _getAllResources];
   
    // Do any additional setup after loading the view.
}

-(void)initViewControlData
{

    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    self.view.alpha = 0.5;
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = self.itemStr;
    title.font = [UIFont boldSystemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [headView addSubview:title];
    [self.view addSubview:headView];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [headView addSubview:navView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 50)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 60, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont fontWithName:@"MicrosoftYaHei" size:28];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];

}

-(void)setUpVideoScrollView
{
    
    for(NSInteger i=0;i<2;i++)
    {
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(20+(90+5)*i, 5, 90, 30)];
        comBox.backgroundColor = [UIColor whiteColor];
        comBox.arrowImgName = @"down_dark0";
        comBox.titlesList = [NSMutableArray arrayWithArray:streetNameArray];
        comBox.delegate = self;
        comBox.supView = videoScrollView;
        [comBox defaultSettings];
        comBox.tag = kDropDownListTag + i;
        [videoScrollView addSubview:comBox];
        
        
    }
    LMComBoxView* comBox1 = [videoScrollView viewWithTag:kDropDownListTag];
    LMComBoxView* comBox2 = [videoScrollView viewWithTag:kDropDownListTag +1];
    [self selectAtIndex:0 inCombox:comBox1];
    if(self.countOfRegion == 3){
        
        [self selectAtIndex:0 inCombox:comBox2];
    }
    
    
}

/**
 
 */
-(int)countOfRegion
{
    int countStr = 0;
    for(int i=0;i<villageArray.count;i++){
        
        if([villageArray[i] isMemberOfClass:[CRegionInfo class]]){
            
            countStr = 3;
        }else{
            
            countStr = 2;
        }
        
    }
    
    return countStr;
    
}


-(void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
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
