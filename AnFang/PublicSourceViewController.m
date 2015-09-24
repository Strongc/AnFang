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

@interface PublicSourceViewController ()
{
    UICollectionView *videoCollection;
    NSMutableArray *publicVideoTime;
    NSMutableArray *publicVideoTitle;
    NSMutableArray *publicVideoImage;
    NSMutableArray *heightArr;

}

@property (nonatomic,strong) NSArray *sourceData;

@end

@implementation PublicSourceViewController

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

    return self.sourceData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *identifyId = @"cell";
    PublicVideoCollectionViewCell *cell = (PublicVideoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
   
    PublicVideoSource *model = [self.sourceData objectAtIndex:indexPath.item];
    NSString *name = model.videoImage;
    
    cell.publicVideoImage.image = [UIImage imageNamed:name];
    cell.videoTimeLab.text = model.videoTime;
    cell.videoTitle.text = model.videoName;
   
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

    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    JRPlayerViewController *videoPlayer = [[mainView instantiateViewControllerWithIdentifier:@"videoPlayer"] initWithHTTPLiveStreamingMediaURL:[NSURL URLWithString:@"http://static.tripbe.com/videofiles/20121214/9533522808.f4v.mp4"]];
    
    videoPlayer.hidesBottomBarWhenPushed = YES;
    videoPlayer.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:videoPlayer animated:YES];

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
