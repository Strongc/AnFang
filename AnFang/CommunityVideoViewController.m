//
//  PublicVideoitemViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/27.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "CommunityVideoViewController.h"
#import "LMContainsLMComboxScrollView.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "PublicItemVideoCell.h"
#import "PlayViewController.h"
#import "SVProgressHUD.h"
#import "RecommendVideoCell.h"
#import "PublicHeaderView.h"
#import "CommunityViewController.h"
#import "WGAPI.h"
#import "CMTool.h"
#import "PublicVideoClassModel.h"

#define kDropDownListTag 1000
#define account 5

@interface CommunityVideoViewController ()<UIScrollViewDelegate>
{
    LMContainsLMComboxScrollView *videoScrollView;
    NSMutableArray *streetArray;//存放街道
    NSMutableArray *villageArray;//存放村
    NSMutableArray *videoArray;//存放村下面的摄像头
    NSMutableArray *tempVideoArrays;//
    NSMutableArray *tempVillageArrays;//
    NSMutableArray *videoArrays;//
    NSString *selectedStreetName;//选中的街道名
    NSString *selectedVillageName;//选中的村名
    NSString *selectedVideoName;//选中的摄像头
    NSMutableArray *_lineList;
    int _selectedLineID;
    NSMutableArray *streetNameArray;//存放街道名称
    NSMutableArray *streetNameList;//存放街道名称
    NSMutableArray *LMComBoxArray;//下拉框存放街道名称
    NSMutableArray *LMComBoxVillageArray;//下拉框存放街道名称
    LMComBoxView *cityBoxView;
    int selectIndex;
    NSMutableArray  *publicVideoSection;//存放组名的数组
    NSMutableArray  *videoBackImageArray1;//存放视频截图的数组
    NSMutableArray  *videoBackImageArray2;//存放视频截图的数组
    NSMutableArray  *listVideoSource;
    __block NSMutableArray *tempArray;
    NSMutableArray *videoArrayInSection;
    NSMutableArray *villageNameArray;//存放所有的村名
    //int scaleOfList;
    
}

@property (weak,nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic)UIPageControl *pageView;
@end

@implementation CommunityVideoViewController

-(void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideHUD" object:nil];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _serverAddress = @"http://112.12.17.3";
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    streetArray = [[NSMutableArray alloc]init];
    videoArrays = [[NSMutableArray alloc]init];
    tempVideoArrays = [[NSMutableArray alloc] init];
    tempVillageArrays = [[NSMutableArray alloc] init];
    streetNameArray = [[NSMutableArray alloc]init];
    LMComBoxArray = [[NSMutableArray alloc]init];
    LMComBoxVillageArray = [[NSMutableArray alloc] init];
    videoBackImageArray1 = [[NSMutableArray alloc] init];
    videoBackImageArray2 = [[NSMutableArray alloc] init];
    villageArray = [NSMutableArray array];
    videoArray = [NSMutableArray array];
    _lineList = [NSMutableArray array];
    _mspInfo = [[CMSPInfo alloc]init];
    villageNameArray = [NSMutableArray array];
    streetNameList = [NSMutableArray array];
    _selectedLineID = 2;
    BOOL result1 = [vmsNetSDK login:_serverAddress toUserName:@"dbwl" toPassword:@"12345" toLineID:_selectedLineID toServInfo:_mspInfo];
    if (NO == result1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"登录失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        //return;
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
    
    for(int i=0; i<3; i++){
    
        NSString *name = [NSString stringWithFormat:@"%d.png",i];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        [videoBackImageArray1 addObject:imagePath];
    }
    
    for(int i=3; i<6; i++){
    
        NSString *name = [NSString stringWithFormat:@"%d.png",i];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        [videoBackImageArray2 addObject:imagePath];
    
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProgressHUD) name:@"showProHUD" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideProgressHUD) name:@"hideProHUD" object:nil];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"efefef"]];
    
    [self getNextAreaById];
    NSMutableArray *streetRegionInfo = [self getRegionInfo:self.regionId];
    for(NSDictionary *dict in streetRegionInfo){
        
        NSString *areaId = [dict objectForKey:@"areaId"];
        NSString *streetName = [dict objectForKey:@"name"];
        [streetNameList addObject:streetName];
        NSMutableArray *villageRegionInfo = [self getRegionInfo:areaId];
        NSMutableArray *videoList = [NSMutableArray array];
        NSMutableArray *tempVillageNameArray = [NSMutableArray array];
        for(NSDictionary *dict in villageRegionInfo){
            
            NSString *areaId = [dict objectForKey:@"areaId"];
            NSString *name = [dict objectForKey:@"name"];
            [tempVillageNameArray addObject:name];
            NSMutableArray *itemVideoArray = [self getRegionInfo:areaId];
            [videoList addObject:itemVideoArray];
            
        }
        [villageNameArray addObject:tempVillageNameArray];
        [videoArrays addObject:videoList];
    }
    
    [self initCollectionView];
    [self prepareScollView];
    [self preparePageView];
    videoScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH-95*HEIGHT/667, 200)];
    videoScrollView.backgroundColor = [UIColor clearColor];
    videoScrollView.showsVerticalScrollIndicator = NO;
    videoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:videoScrollView];
    [self setUpVideoScrollView];
    
    // Do any additional setup after loading the view.
}

/**
 *  通过区域Id 获取区域列表
 */
-(void)getNextAreaById
{
    NSString *str = @"regionId=";
    NSString *paramStr = [str stringByAppendingString:self.regionId];
    NSDictionary *dict = [WGAPI httpAsynchronousRequestUrl:API_GETREGION postStr:paramStr];
    NSLog(@"json %@",dict);
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

-(void)refreshData
{
    NSMutableArray *tempNameArray = [NSMutableArray array];
    if(streetArray.count > 0){
        for(NSDictionary *dict in streetArray){
            [LMComBoxArray addObject:dict];
            NSString *areaId = [dict objectForKey:@"areaId"];
            [tempNameArray addObject:areaId];
        }
        streetNameArray = [NSMutableArray arrayWithArray:tempNameArray];
        LMComBoxView* comBox1 = [self.view viewWithTag:kDropDownListTag];
        comBox1.titlesList = [NSMutableArray arrayWithArray:LMComBoxArray];
        [comBox1 defaultSettings];
        [self selectAtIndex:0 inCombox:comBox1];

    }else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"获取数据失败，网络异常！"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
    
    }
}

-(void)initCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    UICollectionView *videoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 260, WIDTH-10, HEIGHT-260-49) collectionViewLayout:flowLayout];
    videoCollectionView.delegate = self;
    videoCollectionView.dataSource = self;
#pragma mark -- 头尾部大小设置
    //设置头部并给定大小
    [flowLayout setHeaderReferenceSize:CGSizeMake(videoCollectionView.frame.size.width, 40)];
#pragma mark -- 注册头部视图
    [videoCollectionView registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    videoCollectionView.backgroundColor = [UIColor clearColor];
    videoCollectionView.scrollEnabled = YES;
    [videoCollectionView registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:videoCollectionView];
    self.videoCollectionView = videoCollectionView;

}

- (void)prepareScollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width - 30;
    CGFloat scrollH = 140;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, 120, scrollW , scrollH)];
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
-(void)preparePageView {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat pageW = 100;
    UIPageControl *pageView = [[UIPageControl alloc] initWithFrame:CGRectMake((width - pageW) * 0.5, 190, pageW, 4)];
    pageView.numberOfPages = account;
    pageView.currentPageIndicatorTintColor = [UIColor redColor];
    pageView.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageView.currentPage = 0;
    //[self.view addSubview:pageView];
    self.pageView = pageView;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat width = self.scrollView.frame.size.width;
    int index = (self.scrollView.contentOffset.x + width * 0.5) / width;
    if (index == account) {
        index = 1;
    } else if(index == 0) {
        index = account;
    }
    
    CGRect frame = videoScrollView.frame;
    CGFloat h = frame.size.height;
    h = 30;
    [videoScrollView setFrame:frame];
    
    self.pageView.currentPage = index - 1;
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    //[self.timer invalidate];
    // self.timer = nil;
    CGRect frame = videoScrollView.frame;
    CGFloat h = frame.size.height;
    h = 30;
    [videoScrollView setFrame:frame];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    //[self addTimer];
    CGRect frame = videoScrollView.frame;
    CGFloat h = frame.size.height;
    h = 200;
    [videoScrollView setFrame:frame];
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    [self scrollViewDidEndDecelerating:scrollView];
    CGRect frame = videoScrollView.frame;
    CGFloat h = frame.size.height;
    h = 200;
    [videoScrollView setFrame:frame];
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
    for(NSInteger i=0;i<2;i++)
    {
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(15+(100+10)*i,10, 100, 30)];
        comBox.backgroundColor = [UIColor whiteColor];
        comBox.arrowImgName = @"down_dark0";
        comBox.layer.cornerRadius = 15;
        comBox.layer.borderWidth = 1;
        comBox.clipsToBounds = YES;
        comBox.layer.masksToBounds = YES;
        //comBox.titlesList = [NSMutableArray arrayWithArray:LMComBoxArray];
        comBox.delegate = self;
        comBox.supView = videoScrollView;
        //[comBox defaultSettings];
        comBox.tag = kDropDownListTag + i;
        [videoScrollView addSubview:comBox];
    
    }
    
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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideProHUD" object:nil];
}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    NSInteger tag = _combox.tag - kDropDownListTag;
    switch (tag) {
        case 0:
            {
                LMComBoxView *areaCombox = (LMComBoxView *)[self.view viewWithTag:kDropDownListTag];
                areaCombox.layer.cornerRadius = 15;
                areaCombox.layer.borderWidth = 1;
                areaCombox.clipsToBounds = YES;
                areaCombox.layer.masksToBounds = YES;
                areaCombox.titlesList = [NSMutableArray arrayWithArray:LMComBoxArray];
                NSIndexPath *indexPath = [areaCombox.listTable indexPathForSelectedRow];
               int index = (int)indexPath.row;
                selectIndex = index;
                NSLog(@"下标 %d",selectIndex);
                NSString *str = @"regionId=";
                NSString *paramStr = [str stringByAppendingString:[LMComBoxArray[index] objectForKey:@"areaId"]];
                //NSMutableArray *array = [NSMutableArray array];
                [villageArray removeAllObjects];
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
            
         case 1:
            {
                
                LMComBoxView *village1Combox = (LMComBoxView *)[self.view viewWithTag:kDropDownListTag +1];
                int index2 = (int)village1Combox.listTable.indexPathForSelectedRow.row;
                NSLog(@"下标ddddd %d",index2);
                selectedVillageName = [village1Combox.titlesList[index] objectForKey:@"name"];
                NSString *str = @"regionId=";
                NSString *paramStr = [str stringByAppendingString:[village1Combox.titlesList[index] objectForKey:@"areaId"]];
                [videoArray removeAllObjects];
                [WGAPI post:API_GETREGION RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    if(data){
                        NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                        NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
                        if(infojson != nil){
                            
                            NSMutableArray *array = [infojson objectForKey:@"data"];
                            for(NSDictionary *dict in array){
                                
                                [videoArray addObject:dict];
                                
                            }
                        }
                        
                        [self performSelectorOnMainThread:@selector(jumpToVideoListView) withObject:data waitUntilDone:YES];
                    }
                }];

            }
            break;
            
        default:
            break;
            
    }
    
}

-(void)jumpToVideoListView
{
    NSMutableArray *array = [NSMutableArray array];
    for(NSDictionary *dict in videoArray){
        
        [array addObject:dict];
    }
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommunityViewController *communityView = [mainView instantiateViewControllerWithIdentifier:@"communityId"];
    communityView.videoSourceArray = [NSMutableArray arrayWithArray:array];
    communityView.communityName = selectedVillageName;
    communityView.serverAddress = _serverAddress;
    communityView.mspInfo = _mspInfo;
    communityView.gradeOfList = 2;
    [self.navigationController pushViewController:communityView animated:YES];

}

-(void)refreshComBoxData
{

    LMComBoxView *comBox = (LMComBoxView *)[self.view viewWithTag:kDropDownListTag+1];
    comBox.titleLabel.text = @"";
    comBox.arrow.image = nil;
    [comBox.titlesList removeAllObjects];
    for(NSDictionary *dict in villageArray){
        
        [LMComBoxVillageArray addObject:dict];
    }
    comBox.titlesList = [NSMutableArray arrayWithArray:LMComBoxVillageArray];
    [comBox defaultSettings];
    [comBox reloadData];
    [LMComBoxVillageArray removeAllObjects];
}


-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
   
    return videoArrays.count;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger countOfItem;
    NSMutableArray *videoList = [videoArrays objectAtIndex:section];
    NSMutableArray *cameraVideo = videoList[0];
    if(cameraVideo.count >=3){
    
        countOfItem = 3;
    }else{
    
        countOfItem = cameraVideo.count;
    }
    return countOfItem;
}

/**
 *  设置数组组标题
 *
 *  @param collectionView 当前的显示内容的集合视图
 *  @param kind           <#kind description#>
 *  @param indexPath      每组的下标
 *
 *  @return reusableview
 */
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    if (kind == UICollectionElementKindSectionHeader){
        
        PublicHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = streetNameList[indexPath.section];
        headerView.titleLab.text = title;
        reusableview = headerView;
        headerView.delegate = self;
        headerView.tag = indexPath.section;
    }
    
    return reusableview;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    RecommendVideoCell *cell = (RecommendVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    //RecommendVideoModel *model = [villageArray objectAtIndex:indexPath.item];
    //cell.recommendVideoModel = model;
   // CRegionInfo *regionInfo = streetArray[indexPath.section];
    NSMutableArray *cameraName = videoArrays[indexPath.section];
    NSMutableArray *cameraVideo = cameraName[0];
    cell.className.text = [cameraVideo[indexPath.row] objectForKey:@"camera_name"];
//    if(indexPath.section == 0){
    
    cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:videoBackImageArray1[indexPath.row]];
//    }else{
    
//        cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:videoBackImageArray2[indexPath.row]];
//    }
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.videoCollectionView.frame.size.width-40)/3, 120);
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);//上,左，下，右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *videoList = videoArrays[indexPath.section];
    NSMutableArray *cameraVideo = videoList[0];
    PlayViewController *playVC = [[PlayViewController alloc] init];
    //把预览回放和云台控制所需的参数传过去
    playVC.serverAddress = _serverAddress;
    playVC.mspInfo = _mspInfo;
    playVC.cameraId = [cameraVideo[indexPath.item] objectForKey:@"indexCode"];
    [self.navigationController pushViewController:playVC animated:YES];
    return;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

-(void)jumpToSheQuVideo:(PublicHeaderView *)publicHeaderView
{

    int index = (int)publicHeaderView.tag;
    NSMutableArray *array = [videoArrays objectAtIndex:index];
    NSMutableArray *nameArray = [villageNameArray objectAtIndex:index];
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommunityViewController *communityView = [mainView instantiateViewControllerWithIdentifier:@"communityId"];
    communityView.villageNameArray = nameArray;
    communityView.videoSourceArray = array;
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
