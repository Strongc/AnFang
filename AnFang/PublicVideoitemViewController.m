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
#import "SVProgressHUD.h"
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
    int selectIndex;
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

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHUD" object:nil];
    
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

    videoScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH-150, 140)];
    videoScrollView.backgroundColor = [UIColor clearColor];
    videoScrollView.showsVerticalScrollIndicator = NO;
    videoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:videoScrollView];
    [self setUpVideoScrollView];
     selectedVillageName = [villageArray[0] name];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProgressHUD) name:@"showProHUD" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideProgressHUD) name:@"hideProHUD" object:nil];

    // Do any additional setup after loading the view.
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

-(void)showProgressHUD
{

    [SVProgressHUD showWithStatus:@"加载中..."];
    
}

-(void)hideProgressHUD
{
    
    [SVProgressHUD dismiss];
}

//刷新视图
-(void)reloadData
{
    [self.publicItemTable reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideProHUD" object:nil];
}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showProHUD" object:nil];
    NSInteger tag = _combox.tag - kDropDownListTag;
    switch (tag) {
        case 0:
            {
                LMComBoxView *areaCombox = (LMComBoxView *)[videoScrollView viewWithTag:kDropDownListTag];
                NSIndexPath *indexPath = [areaCombox.listTable indexPathForSelectedRow];
                int index = (int)indexPath.row;
                selectIndex = index;
                NSLog(@"下标 %d",selectIndex);
                int regionId = [streetArray[index] regionID];
               [self _getAllVideoInSection:regionId];
                
                
                if(self.countOfRegion == 2){
                    LMComBoxView* comBox = (LMComBoxView *)[videoScrollView viewWithTag:kDropDownListTag+1];//通过tag移除指定的子视图
                    comBox.hidden = YES;
                    [comBox removeFromSuperview];
                    [self reloadData];
                
                }else if (self.countOfRegion == 3){
                
                    LMComBoxView *villageCombox = [[LMComBoxView alloc]initWithFrame:CGRectMake(20+(90+5)*1, 5, 90, 30)];
                    villageCombox.backgroundColor = [UIColor whiteColor];
                    villageCombox.arrowImgName = @"down_dark0";
                    villageCombox.delegate = self;
                    villageCombox.supView = videoScrollView;
                    [villageCombox defaultSettings];
                    villageCombox.tag = kDropDownListTag + 1;
                    [videoScrollView addSubview:villageCombox];
                    villageCombox.titlesList = [NSMutableArray arrayWithArray:villageArray];
                    [villageCombox reloadData];
                   
                    
                }
                    
               
            }
            break;
            
         case 1:
            {
                
                LMComBoxView *village1Combox = (LMComBoxView *)[videoScrollView viewWithTag:kDropDownListTag +1];
                int index2 = (int)village1Combox.listTable.indexPathForSelectedRow.row;
                NSLog(@"下标ddddd %d",index2);
                int regionId = [streetArray[selectIndex] regionID];
                [self _getAllVideoInSection:regionId];
                int videoId = [villageArray[index2] regionID];
                [self _getAllVideoInSection:videoId];
               [self reloadData];
                
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
     [[NSNotificationCenter defaultCenter] postNotificationName:@"hideProHuD" object:nil];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.0;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // NSMutableArray *array = villageArray[indexPath.section];
    //int index = (int)indexPath.row;
    //NSLog(@"被选中 %d",index);
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
