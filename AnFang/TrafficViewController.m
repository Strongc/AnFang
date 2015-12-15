//
//  TrafficViewController.m
//  AnFang
//
//  Created by MyOS on 15/12/8.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "TrafficViewController.h"
#import "UIColor+Extensions.h"
#import "LMContainsLMComboxScrollView.h"
#import "Common.h"
#import "SchoolClassCell.h"
#import "RecommendVideoCell.h"
#import "PlayViewController.h"
#import "CommunityViewController.h"
#import "WGAPI.h"
#import "CMTool.h"

#define kDropDownListTag 1000
#define account 5

@interface TrafficViewController (){
    NSMutableArray *_lineList;
    int _selectedLineID;
    LMContainsLMComboxScrollView *videoScrollView;
    NSMutableArray *streetNameArray;//存放街道名称
    NSMutableArray *videoBackImageArray1;//存放视频截图的数组
    NSMutableArray *videoBackImageArray2;//存放视频截图的数组
    NSMutableArray *villageArray;//存放村
    NSMutableArray *villageNameArray;//存放村名
    NSMutableArray *streetArray;//存放街道
    NSMutableArray *videoArrays;//存放村下面的摄像头
    NSMutableArray *LMComBoxArray;//下拉框存放街道名称
    NSString *villageName;
    NSMutableArray *allVideoArray;//存放所有视频
    
}

@property (nonatomic, strong) NSArray *classData;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (nonatomic,strong)NSMutableArray *imageArray;
@end

@implementation TrafficViewController

/**
 *  从plist文件中懒加载数据
 *
 *  @return _classData
 */
-(NSArray *)classData
{
    if(_classData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path;
        if(self.type == 2){
            
            path = [[NSBundle mainBundle] pathForResource:@"trafficEvent.plist" ofType:nil];
        }else if (self.type == 3){
        
            path = [[NSBundle mainBundle] pathForResource:@"tourList.plist" ofType:nil];
        }
        
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            SchoolClassModel *model = [SchoolClassModel schoolClassModelWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _classData = arrayModels;
        
    }
    
    return _classData;
}

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHUD" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.imageArray = [[NSMutableArray alloc]initWithObjects:@"0.png",@"1.png",@"2.png",@"3.png", nil];
    _serverAddress = @"http://112.12.17.3";
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    streetNameArray = [[NSMutableArray alloc]init];
    villageNameArray = [[NSMutableArray alloc]init];
    LMComBoxArray = [[NSMutableArray alloc]init];
    videoBackImageArray1 = [[NSMutableArray alloc] init];
    videoBackImageArray2 = [[NSMutableArray alloc] init];
    villageArray = [NSMutableArray array];
    allVideoArray = [NSMutableArray array];
    videoArrays = [NSMutableArray array];
    streetArray = [NSMutableArray array];
    _lineList = [NSMutableArray array];
    _mspInfo = [[CMSPInfo alloc]init];
    _selectedLineID = 2;
    BOOL result1 = [vmsNetSDK login:_serverAddress toUserName:@"dbwl" toPassword:@"12345" toLineID:_selectedLineID toServInfo:_mspInfo];
    if (NO == result1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"登录失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
       // return;
    }

    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
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

    [self classData];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"efefef"]];
    [self getNextAreaById];
    NSMutableArray *streetRegionInfo = [self getRegionInfo:self.regionId];
    for(NSDictionary *dict in streetRegionInfo){
        
        NSString *areaId = [dict objectForKey:@"areaId"];
        NSString *name = [dict objectForKey:@"name"];
        NSMutableArray *villageRegionInfo = [self getRegionInfo:areaId];
        for(NSDictionary *dict in villageRegionInfo){
            
            [videoArrays addObject:dict];
        }
        [allVideoArray addObject:villageRegionInfo];
        [villageNameArray addObject:name];
    }

    CGFloat collectionViewHeight;
    if(self.type == 2){
        
        collectionViewHeight = 80*HEIGHT/667;
    }else if (self.type == 3){
        
        collectionViewHeight = 170*HEIGHT/667;
    }
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.trafficEvent = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64+50, WIDTH, collectionViewHeight) collectionViewLayout:flowLayout];
    self.trafficEvent.delegate = self;
    self.trafficEvent.dataSource = self;
    self.trafficEvent.backgroundColor = [UIColor clearColor];
    self.trafficEvent.scrollEnabled = YES;
    [self.trafficEvent registerClass:[SchoolClassCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.trafficEvent];
    self.trafficEvent.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    
    [self prepareScollView];
    videoScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 140)];
    videoScrollView.backgroundColor = [UIColor clearColor];
    videoScrollView.showsVerticalScrollIndicator = NO;
    videoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:videoScrollView];
    [self setUpVideoScrollView];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame)+10*HEIGHT/667, 200, 20)];
    [self.view addSubview:titleLab];
    if(self.type == 2){
        titleLab.text = @"热门街道交通路况";
    }else if (self.type == 3){
    
        titleLab.text = @"热门景点视频";
    }
    
    titleLab.textAlignment = NSTextAlignmentLeft;
    titleLab.textColor = [UIColor colorWithHexString:@"ce7031"];
    titleLab.font = [UIFont boldSystemFontOfSize:18];
    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH -20-70, CGRectGetMaxY(self.scrollView.frame)+10*HEIGHT/667, 70, 22)];
    [self.view addSubview:moreBtn];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"more.png" ofType:nil];
    [moreBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 70, 22)];
    title3.text = @"更多";
    [moreBtn addSubview:title3];
    title3.textAlignment = NSTextAlignmentCenter;
    title3.font = [UIFont fontWithName:@"MicrosoftYaHei" size:20];
    title3.textColor = [UIColor whiteColor];
    [moreBtn addTarget:self action:@selector(jumpToMoreTrafficVideoView) forControlEvents:UIControlEventTouchUpInside];
    
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc] init];
    self.roadVideoList = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(titleLab.frame)+10*HEIGHT/667, WIDTH, 320) collectionViewLayout:flowLayout1];
    self.roadVideoList.delegate = self;
    self.roadVideoList.dataSource = self;
    self.roadVideoList.backgroundColor = [UIColor clearColor];
    self.roadVideoList.scrollEnabled = YES;
    [self.roadVideoList registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.view addSubview:self.roadVideoList];
    self.roadVideoList.backgroundColor = [UIColor colorWithHexString:@"efefef"];

    // Do any additional setup after loading the view.
}

/**
 *  根据区域Id获取下一级区域列表
 *
 *  @param regionId 上一级区域Id
 *
 *  @return 下一级区域列表
 */
-(NSMutableArray *)getRegionInfo:(NSString *)regionId
{
    NSString *str = @"regionId=";
    NSString *paramStr = [str stringByAppendingString:regionId];
    NSDictionary *dict = [WGAPI httpAsynchronousRequestUrl:API_GETREGION postStr:paramStr];
    if(dict == nil){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                message:@"获取数据失败，网络异常！"
                                delegate:nil cancelButtonTitle:@"好"
                                otherButtonTitles:nil, nil];
        [alertView show];
        
    }
    NSMutableArray *regionInfoArray = [dict objectForKey:@"data"];
    return regionInfoArray;
}

-(void)getNextAreaById
{
    NSString *str = @"regionId=";
    NSString *paramStr = [str stringByAppendingString:self.regionId];
    //NSMutableArray *array = [NSMutableArray array];
    [WGAPI post:API_GETREGION RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
            NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
            if(infojson != nil){
                NSMutableArray *array = [infojson objectForKey:@"data"];
                for(NSDictionary *dict in array){
                    
                    [streetArray addObject:dict];
                }
            }
            
            [self performSelectorOnMainThread:@selector(refreshData) withObject:data waitUntilDone:YES];
        }
    }];
    
}

-(void)refreshData
{
  
    if(streetArray.count > 0){
        LMComBoxView* comBox1 = [videoScrollView viewWithTag:kDropDownListTag];
        comBox1.titlesList = [NSMutableArray arrayWithArray:streetArray];
        [comBox1 defaultSettings];
        
    }else{
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"获取数据失败，网络异常！"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];

    }
  
}


-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)prepareScollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width - 30;
    CGFloat scrollH = 110*HEIGHT/667;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.trafficEvent.frame), scrollW , scrollH)];
    scrollView.delegate = self;
    
    for (int i = 0; i < 5; i++) {
        UIButton *imageViewBtn = [[UIButton alloc] init];
        NSString *name = [NSString stringWithFormat:@"img_%02d",i + 1];
        [imageViewBtn setBackgroundImage:[UIImage imageNamed:name] forState:UIControlStateNormal] ;
        CGFloat imageX = scrollW * (i + 1);
        imageViewBtn.tag = i;
        imageViewBtn.frame = CGRectMake(imageX, 0, scrollW, scrollH);
        //[imageViewBtn addTarget:self action:@selector(jumpToNextView:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:imageViewBtn];
        
    }
    
    UIButton *firstImageBtn = [[UIButton alloc] init];
    [firstImageBtn setBackgroundImage:[UIImage imageNamed:@"img_01"] forState:UIControlStateNormal] ;
    firstImageBtn.frame = CGRectMake(0, 0, scrollW, scrollH);
    [scrollView addSubview:firstImageBtn];
    scrollView.contentOffset = CGPointMake(scrollW, 0);
    
    UIButton *lastImageBtn = [[UIButton alloc] init];
    [lastImageBtn setBackgroundImage:[UIImage imageNamed:@"img_05"] forState:UIControlStateNormal] ;
    lastImageBtn.frame = CGRectMake((account + 1) * scrollW, 0, scrollW, scrollH);
    [scrollView addSubview:lastImageBtn];
    scrollView.contentSize = CGSizeMake(account  * scrollW, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    [self.view addSubview:scrollView];
    self.scrollView = scrollView;
    //[self addTimer];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == account) {
        index = 1;
    } else if(index == 0) {
        index = account;
    }
    //self.pageView.currentPage = index - 1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //[self.timer invalidate];
    // self.timer = nil;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //[self addTimer];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == account + 1) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(account * width, 0) animated:NO];
    }
}

-(void)setUpVideoScrollView
{
    
    for(NSInteger i=0;i<1;i++)
    {
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(15+(100+10)*i, 10, 100, 30)];
        comBox.backgroundColor = [UIColor whiteColor];
        comBox.arrowImgName = @"down_dark0";
        comBox.layer.cornerRadius = 15;
        comBox.layer.borderWidth = 1;
        comBox.clipsToBounds = YES;
        comBox.layer.masksToBounds = YES;
        //comBox.titlesList = [NSMutableArray arrayWithArray:streetNameArray];
        comBox.delegate = self;
        comBox.supView = videoScrollView;
        //[comBox defaultSettings];
        comBox.tag = kDropDownListTag + i;
        [videoScrollView addSubview:comBox];
        
        
    }
    
    
}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    //NSMutableArray *communityArray = [NSMutableArray array];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"showProHUD" object:nil];
    NSInteger tag = _combox.tag - kDropDownListTag;
    switch (tag) {
        case 0:
        {
            LMComBoxView *areaCombox = (LMComBoxView *)[videoScrollView viewWithTag:kDropDownListTag];
            areaCombox.layer.cornerRadius = 15;
            areaCombox.layer.borderWidth = 1;
            areaCombox.clipsToBounds = YES;
            areaCombox.layer.masksToBounds = YES;
            areaCombox.titlesList = [NSMutableArray arrayWithArray:streetArray];
            NSIndexPath *indexPath = [areaCombox.listTable indexPathForSelectedRow];
            int index = (int)indexPath.row;
            villageName = villageNameArray[index];
            //selectIndex = index;
            //NSLog(@"下标 %d",selectIndex);
            [villageArray removeAllObjects];
            NSString *regionId = [streetArray[index] objectForKey:@"areaId"];
            //[self _getAllVideoInSection:regionId];
            NSString *str = @"regionId=";
            NSString *paramStr = [str stringByAppendingString:regionId];
            [WGAPI post:API_GETREGION RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                if(data){
                    NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                    NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
                    if(infojson != nil){
                        NSMutableArray *tempArray1 = [infojson objectForKey:@"data"];
                        for(NSDictionary *dict in tempArray1){
                            
                            [villageArray addObject:dict];
                        }
                    }
                    
                    [self performSelectorOnMainThread:@selector(refreshComBoxData) withObject:data waitUntilDone:YES];
                }
            }];
            
        }
            break;
            
        default:
            break;
            
    }
    
}

-(void)refreshComBoxData
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommunityViewController *communityView = [mainView instantiateViewControllerWithIdentifier:@"communityId"];;
    communityView.videoSourceArray = villageArray;
    communityView.mspInfo = _mspInfo;
    communityView.serverAddress = _serverAddress;
    communityView.gradeOfList = 2;
    communityView.communityName = villageName;
    [self.navigationController pushViewController:communityView animated:YES];
    
}


#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    if(collectionView == self.trafficEvent){
         count = _classData.count;
    }else if (collectionView == self.roadVideoList){
       
       count = videoArrays.count;
    }
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    static NSString *identifyId = @"cell";
    static NSString *identifyId1 = @"cell1";
    if(collectionView == self.trafficEvent){
        
        SchoolClassCell *classCell = (SchoolClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
        SchoolClassModel *model = [_classData objectAtIndex:indexPath.item];
        classCell.schoolClassModel = model;
        cell = classCell;
        
    }else if (collectionView == self.roadVideoList){
        RecommendVideoCell *roadCell = (RecommendVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId1 forIndexPath:indexPath];
        roadCell.className.text = [[videoArrays objectAtIndex:indexPath.item] objectForKey:@"camera_name"];
        roadCell.publicVideoImage.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.item]];
        cell = roadCell;
    }
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if(collectionView == self.trafficEvent){
        
        size = CGSizeMake((self.trafficEvent.frame.size.width-50)/4, 60*HEIGHT/667);
    }else if (collectionView == self.roadVideoList){
        
       size = CGSizeMake((self.roadVideoList.frame.size.width-40)/3, 110*HEIGHT/667);
    }
    return size;
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10*HEIGHT/667, 10, 10*HEIGHT/667, 10);//上,左，下，右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if(collectionView == self.roadVideoList){
        PlayViewController *playVC = [[PlayViewController alloc] init];
        //把预览回放和云台控制所需的参数传过去
        playVC.serverAddress = _serverAddress;
        playVC.mspInfo = _mspInfo;
        playVC.cameraId = [[videoArrays objectAtIndex:indexPath.item] objectForKey:@"indexCode"];
        [self.navigationController pushViewController:playVC animated:YES];
        return;
    }
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

/**
 *  跳转到搜索界面
 */
-(void)jumpToMoreTrafficVideoView
{
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommunityViewController *communityView = [mainView instantiateViewControllerWithIdentifier:@"communityId"];
    communityView.videoSourceArray = allVideoArray;
    communityView.villageNameArray = villageNameArray;
    communityView.mspInfo = _mspInfo;
    communityView.serverAddress = _serverAddress;
    communityView.gradeOfList = 3;
    [self.navigationController pushViewController:communityView animated:YES];

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
