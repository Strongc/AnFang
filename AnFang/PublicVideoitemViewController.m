//
//  PublicVideoitemViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/27.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicVideoitemViewController.h"
#import "LMContainsLMComboxScrollView.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "PublicItemVideoCell.h"
#import "PlayViewController.h"
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
    NSMutableArray *streetNameArray;//存放街道名称
    LMComBoxView *cityBoxView;

}

@end

@implementation PublicVideoitemViewController

-(NSMutableArray *)_getAllStreetArray
{
    int regionId = self.regionId.intValue;
    VMSNetSDK *vmNetSDK = [VMSNetSDK shareInstance];
    streetArray = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    
    //获取区域下的区域
    [vmNetSDK getRegionListFromRegion:_serverAddress toSessionID:_mspInfo.sessionID toRegionID:regionId toNumPerOnce:60 toCurPage:1 toRegionList:tempArray];
    [streetArray addObjectsFromArray:tempArray];
    
    [tempArray removeAllObjects];
    
    //获取区域下的设备
    [vmNetSDK getCameraListFromRegion:_serverAddress toSessionID:_mspInfo.sessionID toRegionID:regionId toNumPerOnce:60 toCurPage:1 toCameraList:tempArray];
    
   
    [streetArray addObjectsFromArray:tempArray];
   
    [tempArray removeAllObjects];
    return streetArray;
}

-(NSMutableArray *)_getAllVideoInSection:(int)regionId
{
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    villageArray = [NSMutableArray array];
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
    [villageArray addObjectsFromArray:tempArray];
    [tempArray removeAllObjects];
    
    //获取区域下的设备
    [vmsNetSDK getCameraListFromRegion:_serverAddress
                           toSessionID:_mspInfo.sessionID
                            toRegionID:regionId
                          toNumPerOnce:50
                             toCurPage:1
                          toCameraList:tempArray];
    [villageArray addObjectsFromArray:tempArray];
    [tempArray removeAllObjects];
    
    return villageArray;
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _serverAddress = @"http://112.12.17.3";
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    streetNameArray = [[NSMutableArray alloc]init];
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
    
    for(int i=0;i<streetArray.count;i++){
    
        CRegionInfo *regionInfo = streetArray[i];
        [streetNameArray addObject:regionInfo];
    
    }
    
    for(int i=0;i<villageArray.count;i++){
        
        if([villageArray[i] isMemberOfClass:[CRegionInfo class]]){
        
            self.countStr = 3;
        }else{
        
            self.countStr = 2;
        }
        
    }
    
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

    self.publicItemTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+60, WIDTH, HEIGHT-64-49-60) style:UITableViewStyleGrouped];
    [self.view addSubview:self.publicItemTable];
    self.publicItemTable.delegate = self;
    self.publicItemTable.dataSource = self;
    self.publicItemTable.backgroundColor = [UIColor colorWithHexString:@"040818"];
    self.publicItemTable.separatorStyle = UITableViewCellSeparatorStyleNone;

    videoScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 70, WIDTH, 120)];
    videoScrollView.backgroundColor = [UIColor clearColor];
    videoScrollView.showsVerticalScrollIndicator = NO;
    videoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:videoScrollView];
    
    [self setUpVideoScrollView];
    
     selectedVillageName = [villageArray[0] name];
    
    
    // Do any additional setup after loading the view.
}



-(void)setUpVideoScrollView
{
    
    for(NSInteger i=0;i<2;i++)
    {
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(10+(90+6)*i, 15, 90, 35)];
        comBox.backgroundColor = [UIColor whiteColor];
        comBox.arrowImgName = @"down_dark0";
        comBox.titlesList = [NSMutableArray arrayWithArray:streetNameArray];
        comBox.delegate = self;
        comBox.supView = videoScrollView;
        [comBox defaultSettings];
        comBox.tag = kDropDownListTag + i;
        [videoScrollView addSubview:comBox];
        //[self selectAtIndex:0 inCombox:comBox];
        
    }
    

}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    NSInteger tag = _combox.tag - kDropDownListTag;
    switch (tag) {
        case 0:
            {
                int regionId = [streetArray[index] regionID];
                [self _getAllVideoInSection:regionId];
                //if(self.countStr == 3){
                    
                    LMComBoxView *cityCombox = (LMComBoxView *)[videoScrollView viewWithTag:tag + 1 + kDropDownListTag];
                    cityCombox.titlesList = [NSMutableArray arrayWithArray:villageArray];
                    [cityCombox reloadData];
               // }
                //else{
                
                    //[self.publicItemTable reloadData];
                
                //}
               
            }
            break;
            
         case 1:
            {
        
                int regionId = [villageArray[index] regionID];
                [self _getAllVideoInSection:regionId];
                
//                if(self.countStr == 3){
//                    
//                    LMComBoxView *cityCombox = (LMComBoxView *)[videoScrollView viewWithTag:tag + 1 + kDropDownListTag];
//                    cityCombox.titlesList = [NSMutableArray arrayWithArray:villageArray];
//                    [cityCombox reloadData];
//                }
//                else{
                
                    [self.publicItemTable reloadData];
                    
               // }

        
            }
            break;
            
        default:
            break;
            
    }
   

}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    
    return villageArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentify = @"cell";
    PublicItemVideoCell *cell = (PublicItemVideoCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if(cell == nil){
        
        cell = [[PublicItemVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.videoNameLab.text = [villageArray[indexPath.row] name];
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.0;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSMutableArray *array = villageArray[indexPath.section];
    
    if ([villageArray[indexPath.row] isMemberOfClass:[CCameraInfo class]]) {
        PlayViewController *playVC = [[PlayViewController alloc] init];
        
        //把预览回放和云台控制所需的参数传过去
        playVC.serverAddress = _serverAddress;
        playVC.mspInfo = _mspInfo;
        playVC.cameraInfo = villageArray[indexPath.row];
        [self.navigationController pushViewController:playVC animated:YES];
        return;
    }
    
    
    
}


-(void)backAction
{
    //NSLog(@"%@",@"ddddd");
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
