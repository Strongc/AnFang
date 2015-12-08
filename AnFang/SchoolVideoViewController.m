//
//  SchoolVideoViewController.m
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "SchoolVideoViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "SchoolClassCell.h"
#import "RecommendVideoCell.h"
#import "CampusVideoListViewController.h"
#define account 5

@interface SchoolVideoViewController ()

@property (nonatomic, strong) NSArray *classData;
@property (weak, nonatomic) UIScrollView *scrollView;
@property (weak, nonatomic) UIScrollView *activityScrollView;
@property (weak, nonatomic) UIPageControl *pageView;
@property (nonatomic,strong)NSMutableArray *imageArray;

@end

@implementation SchoolVideoViewController

/**
 *  从plist文件中懒加载数据
 *
 *  @return _classData
 */
-(NSArray *)classData
{
    if(_classData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"shcoolName.plist" ofType:nil];
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
    self.imageArray = [[NSMutableArray alloc]initWithObjects:@"school01",@"school02",@"school03", nil];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"智慧校园";
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
    [self initViewControl];
    [self classData];
    [self prepareScollView];
    [self prepareActivityScollView];
    [self preparePageView];
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(15, CGRectGetMaxY(self.activityScrollView.frame)+5*HEIGHT/667, 200, 20)];
    title2.text = @"校园风采";
    title2.textAlignment = NSTextAlignmentLeft;
    title2.textColor = [UIColor colorWithHexString:@"ce7031"];
    title2.font = [UIFont boldSystemFontOfSize:15];
    [self.view addSubview:title2];

    UIButton *moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH -20-70, CGRectGetMaxY(self.activityScrollView.frame)+5*HEIGHT/667, 70, 22)];
    [self.view addSubview:moreBtn];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"more.png" ofType:nil];
    [moreBtn setBackgroundImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
    UILabel *title3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 2, 70, 22)];
    title3.text = @"更多";
    [moreBtn addSubview:title3];
    title3.textAlignment = NSTextAlignmentCenter;
    title3.font = [UIFont fontWithName:@"MicrosoftYaHei" size:20];
    title3.textColor = [UIColor whiteColor];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.schoolVideoView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(title2.frame)+5*HEIGHT/667, WIDTH, 150*HEIGHT/667) collectionViewLayout:flowLayout];
    self.schoolVideoView.delegate = self;
    self.schoolVideoView.dataSource = self;
    self.schoolVideoView.backgroundColor = [UIColor clearColor];
    self.schoolVideoView.scrollEnabled = NO;
    [self.schoolVideoView registerClass:[RecommendVideoCell class] forCellWithReuseIdentifier:@"cell1"];
    [self.view addSubview:self.schoolVideoView];
    self.schoolVideoView.backgroundColor = [UIColor colorWithHexString:@"040818"];

    [self.view setBackgroundColor:[UIColor colorWithHexString:@"040818"]];
    // Do any additional setup after loading the view.
}

- (void)prepareScollView {
    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width - 30;
    CGFloat scrollH = 110*HEIGHT/667;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.schoolClassView.frame), scrollW , scrollH)];
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

-(void)prepareActivityScollView{

    CGFloat scrollW = [UIScreen mainScreen].bounds.size.width - 30;
    CGFloat scrollH = 110*HEIGHT/667;
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(15, CGRectGetMaxY(self.scrollView.frame)+5*HEIGHT/667, scrollW , scrollH)];
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
    self.activityScrollView = scrollView;
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
    int index;
    
    if(scrollView == self.scrollView){
        index = (self.scrollView.contentOffset.x + width * 0.5) / width;

    }else if (scrollView == self.activityScrollView){
        index = (self.activityScrollView.contentOffset.x + width * 0.5) / width;
    }
    
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
    int index;
    if(scrollView == self.scrollView){
        index = (self.scrollView.contentOffset.x + width * 0.5) / width;
        
    }else if (scrollView == self.activityScrollView){
        index = (self.activityScrollView.contentOffset.x + width * 0.5) / width;
    }

    if (index == account + 1) {
        [self.scrollView setContentOffset:CGPointMake(width, 0) animated:NO];
        [self.activityScrollView setContentOffset:CGPointMake(width, 0) animated:NO];
    } else if (index == 0) {
        [self.scrollView setContentOffset:CGPointMake(account * width, 0) animated:NO];
        [self.activityScrollView setContentOffset:CGPointMake(account * width, 0) animated:NO];
    }
}


/**
 *  初始化控件
 */
-(void)initViewControl
{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.schoolClassView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 150*HEIGHT/667) collectionViewLayout:flowLayout];
    self.schoolClassView.delegate = self;
    self.schoolClassView.dataSource = self;
    self.schoolClassView.backgroundColor = [UIColor clearColor];
    self.schoolClassView.scrollEnabled = NO;
    [self.schoolClassView registerClass:[SchoolClassCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.schoolClassView];
    self.schoolClassView.backgroundColor = [UIColor colorWithHexString:@"040818"];
    
}

/**
 *  返回按钮执行的方法
 */
-(void)backAction
{

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger count;
    if(collectionView == self.schoolClassView){
    
        count = _classData.count;
    }else if (collectionView == self.schoolVideoView){

        count = 3;
    }
    return count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell;
    static NSString *identifyId = @"cell";
    static NSString *identifyId1 = @"cell1";
    if(collectionView == self.schoolClassView){
    
        SchoolClassCell *classCell = (SchoolClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
        SchoolClassModel *model = [_classData objectAtIndex:indexPath.item];
        classCell.schoolClassModel = model;
        cell = classCell;
    
    }else if (collectionView == self.schoolVideoView){
        RecommendVideoCell *videoCell = (RecommendVideoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId1 forIndexPath:indexPath];
        cell = videoCell;
        videoCell.publicVideoImage.image = [UIImage imageNamed:[self.imageArray objectAtIndex:indexPath.item]];
    
    }
 
    // CRegionInfo *regionInfo = streetArray[indexPath.section];
    //villageArray = [self _getAllVideoInSection:regionInfo.regionID];
   
    //cell.className.text = [tempArray[indexPath.row] name];
    
    //[cell setTag:indexPath.row];
    //[cell.backViewBtn addTarget:self action:@selector(doJumpTo:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if(collectionView == self.schoolClassView){
    
        size = CGSizeMake((self.schoolClassView.frame.size.width-50)/4, 60*HEIGHT/667);
    }else if (collectionView == self.schoolVideoView){
    
        size = CGSizeMake((self.schoolVideoView.frame.size.width-40)/3, 110*HEIGHT/667);
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
    if(collectionView == self.schoolClassView){
    
        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CampusVideoListViewController *campusVideoView = [mainView instantiateViewControllerWithIdentifier:@"campusId"];
        [self.navigationController pushViewController:campusVideoView animated:YES];
    
    }
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
