//
//  CommunityViewController.m
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "CommunityViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "RecommendCell.h"
#import "PlayViewController.h"

@interface CommunityViewController ()
{

    UICollectionView *communityVideo;
}
@end

@implementation CommunityViewController

-(void)viewWillAppear:(BOOL)animated
{

    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideProHUD" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//     VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
//    _serverAddress = @"http://112.12.17.3";
//    _mspInfo = [[CMSPInfo alloc]init];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"社区视频";
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
    
    UILabel *communityName = [[UILabel alloc]initWithFrame:CGRectMake(20, 64, 120, 40)];
    [self.view addSubview:communityName];
    communityName.textAlignment = NSTextAlignmentLeft;
    communityName.font = [UIFont boldSystemFontOfSize:20];
    communityName.textColor = [UIColor colorWithHexString:@"ce7031"];
    communityName.text = self.communityName;
    [self initConfig];
    // Do any additional setup after loading the view.
}

-(void)initConfig
{
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"040818"]];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    communityVideo = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 110, WIDTH-10, HEIGHT-110-49) collectionViewLayout:flowLayout];
    communityVideo.delegate = self;
    communityVideo.dataSource = self;
//#pragma mark -- 头尾部大小设置
//    //设置头部并给定大小
//    [flowLayout setHeaderReferenceSize:CGSizeMake(self.videoCollectionView.frame.size.width, 40)];
//#pragma mark -- 注册头部视图
//    [self.videoCollectionView registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    //[self.view addSubview:videoClass];
    communityVideo.backgroundColor = [UIColor clearColor];
    communityVideo.scrollEnabled = YES;
    [communityVideo registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:communityVideo];
    communityVideo.backgroundColor = [UIColor colorWithHexString:@"040818"];


}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
       return self.videoArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    RecommendVideoCell *cell = (RecommendVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    //RecommendVideoModel *model = [villageArray objectAtIndex:indexPath.item];
    //cell.recommendVideoModel = model;
    // CRegionInfo *regionInfo = streetArray[indexPath.section];
    //villageArray = [self _getAllVideoInSection:regionInfo.regionID];
   // NSMutableArray *tempArray = self.videoArray[indexPath.section];
    cell.className.text = [self.videoArray[indexPath.row] name];
    NSString *imagePath;
    
    if(indexPath.section == 0){
        imagePath = [[NSBundle mainBundle] pathForResource:@"0.png" ofType:nil];
        cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:imagePath];
        
    }else{
        imagePath = [[NSBundle mainBundle] pathForResource:@"2.png" ofType:nil];
        cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    //[cell setTag:indexPath.row];
    //[cell.backViewBtn addTarget:self action:@selector(doJumpTo:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((communityVideo.frame.size.width - 30)/2 , 120);
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);//上,左，下，右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   // NSMutableArray *tempArray = videoArray[indexPath.section];
    if ([self.videoArray[indexPath.row] isMemberOfClass:[CCameraInfo class]]) {
        PlayViewController *playVC = [[PlayViewController alloc] init];
        //把预览回放和云台控制所需的参数传过去
        playVC.serverAddress = _serverAddress;
        playVC.mspInfo = _mspInfo;
        playVC.cameraInfo = self.videoArray[indexPath.row];
        [self.navigationController pushViewController:playVC animated:YES];
        return;
    }
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
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
