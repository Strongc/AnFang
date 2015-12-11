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
#import "MoreVideoHeaderView.h"

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
    headView.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
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
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"efefef"]];
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    communityVideo = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 70, WIDTH-10, HEIGHT-70-49) collectionViewLayout:flowLayout];
    communityVideo.delegate = self;
    communityVideo.dataSource = self;
#pragma mark -- 头尾部大小设置
    //设置头部并给定大小
    [flowLayout setHeaderReferenceSize:CGSizeMake(communityVideo.frame.size.width, 30)];
#pragma mark -- 注册头部视图
    [communityVideo registerClass:[MoreVideoHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreVideoHeaderView"];
    
    communityVideo.backgroundColor = [UIColor clearColor];
    communityVideo.scrollEnabled = YES;
    [communityVideo registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:communityVideo];
    communityVideo.backgroundColor = [UIColor colorWithHexString:@"efefef"];


}

#pragma mark UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    NSInteger countOfSection;
    if (self.gradeOfList == 2) {
        
        countOfSection = 1;
    }else if (self.gradeOfList == 3){
        
        countOfSection = self.videoSourceArray.count;
    }
    return countOfSection;
    
}


-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger countOfItem;
    if(self.gradeOfList == 2){
    
        countOfItem = self.videoSourceArray.count;
    }else if (self.gradeOfList == 3){
    
        NSMutableArray *tempArray = [self.videoSourceArray objectAtIndex:section];
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
        
        MoreVideoHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MoreVideoHeaderView" forIndexPath:indexPath];
        NSString *title;
        if(self.gradeOfList == 3){
        
           title = [self.villageNameArray objectAtIndex:indexPath.section];
        }else if (self.gradeOfList == 2){
            
            title = self.communityName;
        }
        headerView.titleLab.text = title;
        reusableview = headerView;
        //headerView.delegate = self;
        //headerView.tag = indexPath.section;
        
    }
    
    return reusableview;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifyId = @"cell";
    RecommendVideoCell *cell = (RecommendVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    NSString *cameraName;
    if(self.gradeOfList == 3){
        NSMutableArray *tempArray = [self.videoSourceArray objectAtIndex:indexPath.section];
        cameraName = [tempArray[indexPath.row] objectForKey:@"camera_name"];
    }else if (self.gradeOfList == 2){
        
        cameraName = [[self.videoSourceArray objectAtIndex:indexPath.item] objectForKey:@"camera_name"];
    }
    cell.className.text = cameraName;
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
    NSString *playerCode;
    if(self.gradeOfList == 2){
    
        playerCode = [self.videoSourceArray[indexPath.row] objectForKey:@"indexCode"];
    }else if (self.gradeOfList == 3){
        
        NSMutableArray *tempArray = [self.videoSourceArray objectAtIndex:indexPath.section];
        playerCode = [tempArray[indexPath.row] objectForKey:@"indexCode"];
    }
    PlayViewController *playVC = [[PlayViewController alloc] init];
    //把预览回放和云台控制所需的参数传过去
    playVC.serverAddress = _serverAddress;
    playVC.mspInfo = _mspInfo;
    playVC.cameraId = playerCode;
    [self.navigationController pushViewController:playVC animated:YES];
    return;
   
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
