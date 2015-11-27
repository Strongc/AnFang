//
//  PublicVideoitemViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/27.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicVideoitemViewController.h"
#import "LMContainsLMComboxScrollView.h"
#define kDropDownListTag 1000

@interface PublicVideoitemViewController ()
{
    LMContainsLMComboxScrollView *videoScrollView;
    NSMutableArray *streetArray;//存放街道
    NSMutableArray *villageArray;//存放村
    NSMutableArray *videoArray;//存放村下面的摄像头
    
    NSString *selectedStreetName;//选中的街道名
    NSString *selectedVillageName;//选中的村名
    NSString *selectedVideoName;//选中的摄像头
    NSMutableArray *_lineList;
    int _selectedLineID;

}

@end

@implementation PublicVideoitemViewController

-(NSMutableArray *)_getAllStreetArray
{
    int regionId = self.regionId.intValue;
    VMSNetSDK *vmNetSDK = [VMSNetSDK shareInstance];
    streetArray = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    [vmNetSDK getRegionListFromRegion:_serverAddress toSessionID:_mspInfo.sessionID toRegionID:regionId toNumPerOnce:60 toCurPage:1 toRegionList:tempArray];
    [streetArray addObject:tempArray];
    //[tempArray removeAllObjects];
    
    return streetArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];
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

    [self _getAllStreetArray];
    videoScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 70, 320, 400)];
    videoScrollView.backgroundColor = [UIColor clearColor];
    videoScrollView.showsVerticalScrollIndicator = NO;
    videoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:videoScrollView];
    
    [self setUpVideoScrollView];

    
    // Do any additional setup after loading the view.
}

-(void)setUpVideoScrollView
{
    UILabel *titleLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, 320, 21)];
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textAlignment = NSTextAlignmentCenter;
    titleLable.text = @"选择省市区";
    [videoScrollView addSubview:titleLable];

    //for(NSInteger i=0;i<3;i++)
    //{
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(50+(63+3), 55, 63, 24)];
        comBox.backgroundColor = [UIColor whiteColor];
        comBox.arrowImgName = @"down_dark0.png";
       // NSMutableArray *itemsArray = [NSMutableArray arrayWithArray:streetArray];
        //comBox.titlesList = itemsArray;
        comBox.delegate = self;
        comBox.supView = videoScrollView;
        [comBox defaultSettings];
        //comBox.tag = kDropDownListTag + i;
        [videoScrollView addSubview:comBox];
        
    //}

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
