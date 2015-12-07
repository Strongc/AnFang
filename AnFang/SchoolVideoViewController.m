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

@interface SchoolVideoViewController ()

@property (nonatomic,strong) NSArray *classData;
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
   

    // Do any additional setup after loading the view.
}

-(void)initViewControl
{

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.schoolClassView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 140) collectionViewLayout:flowLayout];
    self.schoolClassView.delegate = self;
    self.schoolClassView.dataSource = self;
    self.schoolClassView.backgroundColor = [UIColor clearColor];
    self.schoolClassView.scrollEnabled = NO;
    [self.schoolClassView registerClass:[SchoolClassCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:self.schoolClassView];

}

-(void)backAction
{

    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return _classData.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    SchoolClassCell *cell = (SchoolClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    SchoolClassModel *model = [_classData objectAtIndex:indexPath.item];
    cell.schoolClassModel = model;
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
    
    return CGSizeMake((self.schoolClassView.frame.size.width-50)/4, 60);
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
