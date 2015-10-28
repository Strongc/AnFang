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


}

@property (nonatomic,strong) NSArray *sourceData;

@end

@implementation PublicSourceViewController

//获取当前层级的所有资源
- (NSMutableArray *)_getAllResources {
    
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _allResorceList = [NSMutableArray array];
    //NSMutableArray *tempArray = [NSMutableArray array];
    
    //判断当前对象应该获取控制中心还是区域下的资源
    //    if (nil == _regionInfo) {
    //
    //            //获取控制中心下的控制中心
    //            [vmsNetSDK getControlUnitList:_serverAddress
    //                              toSessionID:_mspInfo.sessionID
    //                          toControlUnitID:_controlUnitInfo.controlUnitID
    //                             toNumPerOnce:50
    //                                toCurPage:1
    //                        toControlUnitList:tempArray];
    //            [_allResorceList addObjectsFromArray:tempArray];
    //
    //            //获取控制中心下的区域
    //            [vmsNetSDK getRegionListFromCtrlUnit:_serverAddress
    //                                     toSessionID:_mspInfo.sessionID
    //                                 toControlUnitID:0
    //                                    toNumPerOnce:50
    //                                       toCurPage:1
    //                                    toRegionList:tempArray];
    //            [_allResorceList addObjectsFromArray:tempArray];
    //
    //            //获取控制中心下的设备
    //            [vmsNetSDK getCameraListFromCtrlUnit:_serverAddress
    //                                     toSessionID:_mspInfo.sessionID
    //                                 toControlUnitID:0
    //                                    toNumPerOnce:50
    //                                       toCurPage:1
    //                                    toCameraList:tempArray];
    //            [_allResorceList addObjectsFromArray:tempArray];
    //
    //    } else {
    
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
    //}
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
    
    
//    publicVideoTitle = [[NSMutableArray alloc]initWithObjects:@"江干区天成路工商银行", @"滨江区江南大道华润超市",@"滨江区江陵路国美电器",@"西湖区凤起路中国银行",@"滨江区彩虹城",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"江干区天成路工商银行",@"滨江区江南大道华润超市",@"滨江区江陵路国美电器",@"西湖区凤起路中国银行",nil];
//    
//    publicVideoTime = [[NSMutableArray alloc]initWithObjects:@"2015-4-3",@"2015-5-3",@"2015-2-3",@"2015-6-10",@"2015-6-24",@"2015-5-24",@"2015-8-3",@"2015-9-3",@"2015-8-16", @"2015-8-3",@"2015-9-3",@"2015-8-16",@"2015-8-3",@"2015-9-3",@"2015-8-16",@"2015-8-16",@"2015-8-3",@"2015-9-3",nil];
//    
//    publicVideoImage = [[NSMutableArray alloc]initWithObjects:@"dev.png",@"alarm.png",@"dev.png",@"cut.png",@"dev.png",@"slider.png",@"dev.png",@"dev.png",@"dev.png",@"dev.png",@"dev.png",@"dev.png",@"alarm.png",@"dev.png",@"dev.png",@"alarm.png",@"dev.png",@"dev.png",nil];
    // Do any additional setup after loading the view.
}

-(void)ConfigControl
{
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64*HEIGHT/667)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"公共信息";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];

    UIView *searchBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 64*HEIGHT/667, WIDTH, 40*HEIGHT/667)];
    [self.view addSubview:searchBarView];
    searchBarView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    
    UISearchBar *searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(240*WIDTH/375, 5*HEIGHT/667, 120*WIDTH/375, 30*HEIGHT/667)];
    [searchBarView addSubview:searchBar];
    [[searchBar.subviews objectAtIndex:0] setBackgroundColor:[UIColor whiteColor]];
    searchBar.backgroundColor = [UIColor whiteColor];
    searchBar.searchBarStyle = UISearchBarStyleMinimal;
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    videoCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 110*HEIGHT/667, WIDTH, HEIGHT-110-self.tabBarController.tabBar.bounds.size.height) collectionViewLayout:flowLayout];
    videoCollection.delegate = self;
    videoCollection.dataSource = self;
    [self.view addSubview:videoCollection];
    videoCollection.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    videoCollection.scrollEnabled = YES;
    [videoCollection registerClass:[PublicVideoCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [videoCollection reloadData];
    
    
}

#pragma mark UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{

    //return self.sourceData.count;
    return _allResorceList.count;
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
    
    CGRect originFrame = cell.frame;
    
    if((indexPath.item)%3 == 0){
        
        originFrame.origin.y -= 30;
    }else if ((indexPath.item)%3 == 2){
        
        originFrame.origin.y -= 0;
    }else if((indexPath.item)%3==1){
        
        originFrame.origin.y -= 50;
    }
    originFrame.size.height -= 0;
    originFrame.size.width -= 0;
    cell.frame = originFrame;
    [cell sizeToFit];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{

    return CGSizeMake((WIDTH-30)/3, 130*HEIGHT/667);
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
