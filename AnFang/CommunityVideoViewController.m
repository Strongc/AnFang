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

#define kDropDownListTag 1000
#define account 5

@interface CommunityVideoViewController ()<UIScrollViewDelegate>
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
    NSMutableArray  *publicVideoSection;//存放组名的数组
    NSMutableArray  *videoBackImageArray1;//存放视频截图的数组
    NSMutableArray  *videoBackImageArray2;//存放视频截图的数组
}

@property (weak,nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic)UIPageControl *pageView;
@end

@implementation CommunityVideoViewController

-(NSMutableArray *)_getAllStreetArray
{
    int regionId = self.regionId.intValue;
    VMSNetSDK *vmNetSDK = [VMSNetSDK shareInstance];
    streetArray = [NSMutableArray array];
    NSMutableArray *tempArray = [NSMutableArray array];
    videoArray = [NSMutableArray array];
    //获取区域下的区域
    [vmNetSDK getRegionListFromRegion:_serverAddress toSessionID:_mspInfo.sessionID toRegionID:regionId toNumPerOnce:60 toCurPage:1 toRegionList:tempArray];
    [streetArray addObjectsFromArray:tempArray];
//    for(int i=0;i<streetArray.count;i++){
//    
//        CRegionInfo *regionInfo = streetArray[i];
//            //[_allCameraRegionId addObject:regionInfo];
//        NSMutableArray *tempVillageArray = [self _getAllVideoInSection:regionInfo.regionID];
//        [villageArray addObject:tempVillageArray];
//            
//    }
//    for(int i=0;i<villageArray.count;i++){
//        CRegionInfo *regionInfo = villageArray[i];
//        //[_allCameraRegionId addObject:regionInfo];
//        NSMutableArray *tempVideoArray = [self _getAllVideoInSection:regionInfo.regionID];
//        [videoArray addObject:tempVideoArray];
//    
//    }
    
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
    videoBackImageArray1 = [[NSMutableArray alloc] init];
    videoBackImageArray2 = [[NSMutableArray alloc] init];
    villageArray = [NSMutableArray array];
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

//    self.publicItemTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64+60+120, WIDTH, HEIGHT-64-49-60-120) style:UITableViewStyleGrouped];
//   [self.view addSubview:self.publicItemTable];
//    self.publicItemTable.delegate = self;
//    self.publicItemTable.dataSource = self;
//    self.publicItemTable.backgroundColor = [UIColor colorWithHexString:@"040818"];
//    self.publicItemTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
        //selectedVillageName = [villageArray[0] name];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProgressHUD) name:@"showProHUD" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideProgressHUD) name:@"hideProHUD" object:nil];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"efefef"]];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.videoCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 260, WIDTH-10, HEIGHT-260-49) collectionViewLayout:flowLayout];
    self.videoCollectionView.delegate = self;
    self.videoCollectionView.dataSource = self;
#pragma mark -- 头尾部大小设置
    //设置头部并给定大小
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.videoCollectionView.frame.size.width, 40)];
#pragma mark -- 注册头部视图
    [self.videoCollectionView registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    //[self.view addSubview:videoClass];
    self.videoCollectionView.backgroundColor = [UIColor clearColor];
    self.videoCollectionView.scrollEnabled = YES;
    [self.videoCollectionView registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.videoCollectionView];

    [self _getAllStreetArray];
    for(int i=0;i<streetArray.count;i++){
        //NSString *streetName = [streetArray[i] name];
        CRegionInfo *regionInfo = streetArray[i];
        NSMutableArray *tempArray = [self _getAllVideoInSection:regionInfo.regionID];
        for(int i=0;i<tempArray.count;i++){
            
            CRegionInfo *regionInfo = tempArray[i];
            NSMutableArray *tempvideoArray = [self _getAllVideoInSection:regionInfo.regionID];
            [videoArray addObject:tempvideoArray];
        }
        [streetNameArray addObject:regionInfo];
        
    }
    
    [self prepareScollView];
    [self preparePageView];
    videoScrollView = [[LMContainsLMComboxScrollView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 140)];
    videoScrollView.backgroundColor = [UIColor clearColor];
    videoScrollView.showsVerticalScrollIndicator = NO;
    videoScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:videoScrollView];
    [self setUpVideoScrollView];

    [self.videoCollectionView reloadData];
    // Do any additional setup after loading the view.
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
    self.pageView.currentPage = index - 1;
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
    
    for(NSInteger i=0;i<2;i++)
    {
        LMComBoxView *comBox = [[LMComBoxView alloc]initWithFrame:CGRectMake(15+(100+10)*i, 10, 100, 30)];
        comBox.backgroundColor = [UIColor whiteColor];
        comBox.arrowImgName = @"down_dark0";
        comBox.layer.cornerRadius = 15;
        comBox.layer.borderWidth = 1;
        comBox.clipsToBounds = YES;
        comBox.layer.masksToBounds = YES;
        comBox.titlesList = [NSMutableArray arrayWithArray:streetNameArray];
        comBox.delegate = self;
        comBox.supView = videoScrollView;
        [comBox defaultSettings];
        comBox.tag = kDropDownListTag + i;
        [videoScrollView addSubview:comBox];
       
        
    }
    LMComBoxView* comBox1 = [videoScrollView viewWithTag:kDropDownListTag];
    //LMComBoxView* comBox2 = [videoScrollView viewWithTag:kDropDownListTag+1];
    [self selectAtIndex:0 inCombox:comBox1];
    
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
    //[self.publicItemTable reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideProHUD" object:nil];
}

#pragma mark -LMComBoxViewDelegate
-(void)selectAtIndex:(int)index inCombox:(LMComBoxView *)_combox
{
    NSMutableArray *communityArray = [NSMutableArray array];
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
                areaCombox.titlesList = [NSMutableArray arrayWithArray:streetNameArray];
                NSIndexPath *indexPath = [areaCombox.listTable indexPathForSelectedRow];
                int index = (int)indexPath.row;
                selectIndex = index;
                NSLog(@"下标 %d",selectIndex);
                int regionId = [streetArray[index] regionID];
               [self _getAllVideoInSection:regionId];
                
                
//                if(self.countOfRegion == 2){
//                    LMComBoxView* comBox = (LMComBoxView *)[videoScrollView viewWithTag:kDropDownListTag+1];//通过tag移除指定的子视图
//                    comBox.hidden = YES;
//                    [comBox removeFromSuperview];
//                    [self reloadData];
                
                //}
                //else if (self.countOfRegion == 3){
                
                LMComBoxView *villageCombox = (LMComBoxView *)[videoScrollView viewWithTag:kDropDownListTag+1];
                villageCombox.titlesList = [NSMutableArray arrayWithArray:villageArray];
                [villageCombox reloadData];
                   
                    
               // }
                
            }
            break;
            
         case 1:
            {
                
                LMComBoxView *village1Combox = (LMComBoxView *)[videoScrollView viewWithTag:kDropDownListTag +1];
                int index2 = (int)village1Combox.listTable.indexPathForSelectedRow.row;
                NSLog(@"下标ddddd %d",index2);
                int regionId = [streetArray[selectIndex] regionID];
                communityArray =[self _getAllVideoInSection:regionId];
                int videoId = [villageArray[index2] regionID];
                [self _getAllVideoInSection:videoId];
                
                UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                CommunityViewController *communityView = [mainView instantiateViewControllerWithIdentifier:@"communityId"];
                communityView.communityName = [communityArray[index] name];
                communityView.videoArray = villageArray;
                communityView.mspInfo = _mspInfo;
                communityView.serverAddress = _serverAddress;
                //    PublicVideoClassModel *region = [self.classData objectAtIndex:index];
                //    publicItem.itemStr = region.className;
                //    publicItem.regionId = region.regionId;
                //    publicItem.countStr = region.regionCount.intValue;
                [self.navigationController pushViewController:communityView animated:YES];
               //[self reloadData];
                
            }
            break;
            
        default:
            break;
            
    }
   
    
}

#pragma mark UITableViewDataSource

//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    
//    
//    return villageArray.count;
//    
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    static NSString *reuseIdentify = @"cell";
//    PublicItemVideoCell *cell = (PublicItemVideoCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
//    
//    if(cell == nil){
//        
//        cell = [[PublicItemVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//    }
//    
//    cell.videoNameLab.text = [villageArray[indexPath.row] name];
//     [[NSNotificationCenter defaultCenter] postNotificationName:@"hideProHuD" object:nil];
//    return cell;
//    
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return 70.0;
//    
//}
//
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   // NSMutableArray *array = villageArray[indexPath.section];
//    //int index = (int)indexPath.row;
//    //NSLog(@"被选中 %d",index);
//    if ([villageArray[indexPath.row] isMemberOfClass:[CCameraInfo class]]) {
//        PlayViewController *playVC = [[PlayViewController alloc] init];
//        
//        //把预览回放和云台控制所需的参数传过去
//        playVC.serverAddress = _serverAddress;
//        playVC.mspInfo = _mspInfo;
//        playVC.cameraInfo = villageArray[indexPath.row];
//        [self.navigationController pushViewController:playVC animated:YES];
//        return;
//    }
//    
//
//}

-(void)backAction
{
    //NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return 2;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger countOfItem;
    NSMutableArray *tempArray = [videoArray objectAtIndex:section];
    if(tempArray.count >=3){
    
        countOfItem = 3;
    }else{
    
        countOfItem = tempArray.count;
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
        NSString *title = [streetArray[indexPath.section] name];
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
    //villageArray = [self _getAllVideoInSection:regionInfo.regionID];
    NSMutableArray *tempArray = videoArray[indexPath.section];
    cell.className.text = [tempArray[indexPath.row] name];
    if(indexPath.section == 0){
    
        cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:videoBackImageArray1[indexPath.row]];
    }else{
    
        cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:videoBackImageArray2[indexPath.row]];
    }
    
    //[cell setTag:indexPath.row];
    //[cell.backViewBtn addTarget:self action:@selector(doJumpTo:) forControlEvents:UIControlEventTouchUpInside];
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
       NSMutableArray *tempArray = videoArray[indexPath.section];
      if ([tempArray[indexPath.row] isMemberOfClass:[CCameraInfo class]]) {
            PlayViewController *playVC = [[PlayViewController alloc] init];
            //把预览回放和云台控制所需的参数传过去
            playVC.serverAddress = _serverAddress;
            playVC.mspInfo = _mspInfo;
            playVC.cameraInfo = tempArray[indexPath.row];
            [self.navigationController pushViewController:playVC animated:YES];
            return;
        }

}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

-(void)jumpToSheQuVideo:(PublicHeaderView *)publicHeaderView
{

    int index = (int)publicHeaderView.tag;
    NSMutableArray *tempArray = [videoArray objectAtIndex:index];
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommunityViewController *communityView = [mainView instantiateViewControllerWithIdentifier:@"communityId"];
    communityView.communityName = [streetArray[index] name];
    communityView.videoArray = tempArray;
    communityView.mspInfo = _mspInfo;
    communityView.serverAddress = _serverAddress;
//    PublicVideoClassModel *region = [self.classData objectAtIndex:index];
//    publicItem.itemStr = region.className;
//    publicItem.regionId = region.regionId;
//    publicItem.countStr = region.regionCount.intValue;
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
