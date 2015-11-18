//
//  PublicSourceViewController.m
//  AnBao
//
//  Created by mac   on 15/9/17.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PublicSourceViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "PublicVideoCollectionViewCell.h"
#import "JRPlayerViewController.h"
#import "PublicVideoSource.h"
#import "PlayViewController.h"
#import "SDRefresh.h"
#import "PublicHeaderView.h"

@interface PublicSourceViewController ()
{
    UICollectionView *videoCollection;
    NSMutableArray *publicVideoTime;
    NSMutableArray *publicVideoTitle;
    NSMutableArray *publicVideoImage;
    NSMutableArray *heightArr;
    NSMutableArray *_allResorceList;
    NSMutableArray *_lineList;
    int _selectedLineID;
    NSMutableArray  *volumImages ;
    NSMutableArray  *publicSourceSection;

}

@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;
@property (nonatomic,strong) NSArray *sourceData;

@end

@implementation PublicSourceViewController

//获取当前层级的所有资源
- (NSMutableArray *)_getAllResources {
    
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _allResorceList = [NSMutableArray array];
    
    //获取区域下的区域
    [vmsNetSDK getRegionListFromRegion:_serverAddress
                           toSessionID:_mspInfo.sessionID
                            toRegionID:9
                          toNumPerOnce:50
                             toCurPage:1
                          toRegionList:_allResorceList];
    
    //获取区域下的设备
    [vmsNetSDK getCameraListFromRegion:_serverAddress
                           toSessionID:_mspInfo.sessionID
                            toRegionID:9
                          toNumPerOnce:50
                             toCurPage:1
                          toCameraList:_allResorceList];
    
    return _allResorceList;
}


-(NSArray *)sourceData
{

    if(_sourceData == nil){
    
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PublicVideo.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            PublicVideoSource *model = [PublicVideoSource videoWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _sourceData = arrayModels;

    
    }

    return _sourceData;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfigControl];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideTabBar) name:@"hideTabBar" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showTabBar) name:@"showTabBar" object:nil];
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
    
    BOOL result1 = [vmsNetSDK login:_serverAddress toUserName:@"test" toPassword:@"12345" toLineID:_selectedLineID toServInfo:_mspInfo];
    if (NO == result1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"登录失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }

    
    [self _getAllResources];
    [videoCollection reloadData];
    
    volumImages = [[NSMutableArray alloc]initWithObjects:@"丽晶宾馆基站.jpg",@"新天地大厦基站.jpg",@"磐安移动_公司大门口.jpg",
                   @"新天地大厦基站.jpg", @"武义移动_环城北路营业厅大门.jpg",@"永康移动_公司楼顶基站.jpg",@"武义移动_环城北路营业厅大门.jpg",@"兰溪移动_公司大门进出口.jpg",@"武义移动_环城北路营业厅大门.jpg",@"浦江移动_蔬菜基地1.jpg",@"浦江移动_蔬菜基地2.jpg",@"丽晶宾馆基站.jpg",@"浙江大学附属第四医院.jpg",
                   @"武义移动_环城北路营业厅大门.jpg",@"东阳移动_主营业厅.jpg",nil];
    publicSourceSection = [[NSMutableArray alloc] initWithObjects:@"交通",@"气象",@"商场",nil];
    // Do any additional setup after loading the view.
}

-(void) hideTabBar
{

    self.tabBarController.tabBar.hidden = YES;
}

-(void) showTabBar
{
    
    self.tabBarController.tabBar.hidden = NO;
}


-(void)ConfigControl
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"ce7031"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"公共信息";
    title.textColor = [UIColor orangeColor];
    [headView addSubview:title];
    [self.view addSubview:headView];

    UIView *searchBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 64*HEIGHT/667, WIDTH, 40*HEIGHT/667)];
    //[self.view addSubview:searchBarView];
    searchBarView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(240*WIDTH/375, 5*HEIGHT/667, 120*WIDTH/375, 30*HEIGHT/667)];
    [searchBarView addSubview:searchBar];
    [[searchBar.subviews objectAtIndex:0] setBackgroundColor:[UIColor whiteColor]];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    videoCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 80*HEIGHT/667, WIDTH, HEIGHT-110-self.tabBarController.tabBar.bounds.size.height) collectionViewLayout:flowLayout];
    videoCollection.delegate = self;
    videoCollection.dataSource = self;
    #pragma mark -- 头尾部大小设置
    //设置头部并给定大小
    [flowLayout setHeaderReferenceSize:CGSizeMake(videoCollection.frame.size.width, 40*HEIGHT/667)];
    #pragma mark -- 注册头部视图
    [videoCollection registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.view addSubview:videoCollection];
    videoCollection.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    videoCollection.scrollEnabled = YES;
    [videoCollection registerClass:[PublicVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [videoCollection reloadData];
  //  [self setupHeader];
  //  [self setupFooter];
    
}

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:videoCollection];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    //__weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //weakSelf.totalRowCount += 3;
            [videoCollection reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:videoCollection];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //self.totalRowCount += 2;
        [videoCollection reloadData];
        [self.refreshFooter endRefreshing];
    });
}


#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{

    return publicSourceSection.count;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    //return self.sourceData.count;
    return _allResorceList.count/3;
}

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{

    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader){
        
        PublicHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
        NSString *title = publicSourceSection[indexPath.section];
        
        headerView.titleLab.text = title;
        
        reusableview = headerView;
        
    }
    
    return reusableview;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[VideoPlayUtility getCaptureInfo:self.cameraInfo.cameraID toCaptureInfo:captureInfo];

    static NSString *identifyId = @"cell";
    PublicVideoCollectionViewCell *cell = (PublicVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
   
    //PublicVideoSource *model = [self.sourceData objectAtIndex:indexPath.item];
    //NSString *name = model.videoImage;
    
//    cell.publicVideoImage.image = [UIImage imageNamed:name];
//    cell.videoTimeLab.text = model.videoTime;
//    cell.videoTitle.text = model.videoName;
    //cell.publicSource = model;
    cell.videoTitle.text = [_allResorceList[indexPath.row] name];
    //cell.publicVideoImage.image = [_allResorceList[indexPath.row] ];
    cell.publicVideoImage.image = [UIImage imageNamed:volumImages[indexPath.row]];
//    CGRect originFrame = cell.frame;
//    
//    if((indexPath.item)%3 == 0){
//        
//        originFrame.origin.y -= 30;
//    }else if ((indexPath.item)%3 == 2){
//        
//        originFrame.origin.y -= 0;
//    }else if((indexPath.item)%3==1){
//        
//        originFrame.origin.y -= 50;
//    }
//    originFrame.size.height -= 0;
//    originFrame.size.width -= 0;
//    cell.frame = originFrame;
//    [cell sizeToFit];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((WIDTH-30)/2, 150*HEIGHT/667);
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 7.5, 10, 7.5);//上,左，下，右
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{

    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{

    return 10;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([_allResorceList[indexPath.row] isMemberOfClass:[CCameraInfo class]]) {
        PlayViewController *playVC = [[PlayViewController alloc] init];
        
        //把预览回放和云台控制所需的参数传过去
        playVC.serverAddress = _serverAddress;
        playVC.mspInfo = _mspInfo;
        playVC.cameraInfo = _allResorceList[indexPath.row];
        [self.navigationController pushViewController:playVC animated:YES];
        return;
    }


}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    return YES;
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
