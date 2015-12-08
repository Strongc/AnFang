//
//  CampusVideoListViewController.m
//  AnFang
//
//  Created by MyOS on 15/12/8.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "CampusVideoListViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "RecommendVideoCell.h"
#import "PublicHeaderView.h"

@interface CampusVideoListViewController ()

@end

@implementation CampusVideoListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"园内视频";
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
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];

    self.campusVideoView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64-49) collectionViewLayout:flowLayout];
    self.campusVideoView.delegate = self;
    self.campusVideoView.dataSource = self;
    self.campusVideoView.backgroundColor = [UIColor clearColor];
    self.campusVideoView.scrollEnabled = YES;
    [self.campusVideoView registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.campusVideoView];
    self.campusVideoView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
#pragma mark -- 头尾部大小设置
    //设置头部并给定大小
    [flowLayout setHeaderReferenceSize:CGSizeMake(self.campusVideoView.frame.size.width, 40)];
#pragma mark -- 注册头部视图
    [self.campusVideoView registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"efefef"]];

    // Do any additional setup after loading the view.
}

-(void)backAction
{
    //NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    
    return 3;
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //NSInteger countOfItem;
//    NSMutableArray *tempArray = [videoArray objectAtIndex:section];
//    if(tempArray.count >=3){
//        
//        countOfItem = 3;
//    }else{
//        
//        countOfItem = tempArray.count;
//    }
    return 3;
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
       // NSString *title = [streetArray[indexPath.section] name];
        headerView.titleLab.text = @"杭州某某某幼儿园";
        reusableview = headerView;
       // headerView.delegate = self;
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
//    NSMutableArray *tempArray = videoArray[indexPath.section];
//    cell.className.text = [tempArray[indexPath.row] name];
//    if(indexPath.section == 0){
//        
//        cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:videoBackImageArray1[indexPath.row]];
//    }else{
//        
//        cell.publicVideoImage.image = [UIImage imageWithContentsOfFile:videoBackImageArray2[indexPath.row]];
//    }
    
    //[cell setTag:indexPath.row];
    //[cell.backViewBtn addTarget:self action:@selector(doJumpTo:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((self.campusVideoView.frame.size.width-40)/3, 120);
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10, 10, 10, 10);//上,左，下，右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
//    NSMutableArray *tempArray = videoArray[indexPath.section];
//    if ([tempArray[indexPath.row] isMemberOfClass:[CCameraInfo class]]) {
//        PlayViewController *playVC = [[PlayViewController alloc] init];
//        //把预览回放和云台控制所需的参数传过去
//        playVC.serverAddress = _serverAddress;
//        playVC.mspInfo = _mspInfo;
//        playVC.cameraInfo = tempArray[indexPath.row];
//        [self.navigationController pushViewController:playVC animated:YES];
//        return;
//    }
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}

//-(void)jumpToSheQuVideo:(PublicHeaderView *)publicHeaderView
//{
//    
//    int index = (int)publicHeaderView.tag;
//    NSMutableArray *tempArray = [videoArray objectAtIndex:index];
//    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    CommunityViewController *communityView = [mainView instantiateViewControllerWithIdentifier:@"communityId"];
//    communityView.communityName = [streetArray[index] name];
//    communityView.videoArray = tempArray;
//    communityView.mspInfo = _mspInfo;
//    communityView.serverAddress = _serverAddress;
//    //    PublicVideoClassModel *region = [self.classData objectAtIndex:index];
//    //    publicItem.itemStr = region.className;
//    //    publicItem.regionId = region.regionId;
//    //    publicItem.countStr = region.regionCount.intValue;
//    [self.navigationController pushViewController:communityView animated:YES];
//    
//    
//}

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
