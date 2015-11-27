//
//  MenuSelectViewController.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuSelectViewController.h"
#import "Common.h"
#import "MenuSelectCollectionViewCell.h"
#import "MenuSelect.h"
#import "MenuConfigViewController.h"
#import "UIColor+Extensions.h"

@interface MenuSelectViewController ()
{

    UICollectionView *menuCollectionView;
    NSIndexPath *currentSelectedIndex;
    NSIndexPath *previousSelectedIndex;
}

@property (nonatomic,strong) NSArray *menuData;

@end

@implementation MenuSelectViewController

-(NSArray *)menuData
{
    if(_menuData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"menu.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            MenuSelect *model = [MenuSelect appWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _menuData = arrayModels;
        
    }
    
    return _menuData;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initControl];
    // Do any additional setup after loading the view.
}

-(void)initControl
{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [headView addSubview:navView];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"套餐选购";
    title.font = [UIFont systemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [navView addSubview:title];
    [self.view addSubview:headView];
    
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


    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(20*WIDTH/375, 90*HEIGHT/667, 100*WIDTH/375, 20*HEIGHT/667)];
    title1.text = @"选择套餐类型";
    title1.textColor = [UIColor blackColor];
    title1.font = [UIFont boldSystemFontOfSize:16*WIDTH/375];
    [self.view addSubview:title1];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    menuCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 130*HEIGHT/667, WIDTH, 200*HEIGHT/667) collectionViewLayout:flowLayout];
    menuCollectionView.delegate = self;
    menuCollectionView.dataSource = self;
    menuCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuCollectionView];
    [menuCollectionView registerClass:[MenuSelectCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return 4;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    
    MenuSelectCollectionViewCell *cell = (MenuSelectCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    
    MenuSelect *model = [self.menuData objectAtIndex:indexPath.item];
    
    cell.menuSelect = model;
    
    

    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(172.5*WIDTH/375, 75*HEIGHT/667);
    
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(10*HEIGHT/667, 10*WIDTH/375, 10*HEIGHT/667, 10*WIDTH/375);//上,左，下，右;
    
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    
    return 30*WIDTH/375;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        previousSelectedIndex = currentSelectedIndex;
        
        if ([currentSelectedIndex isEqual:indexPath] ) {
            
            currentSelectedIndex = nil;
            
        } else {
            
            currentSelectedIndex = indexPath;
            
        }
        
        [menuCollectionView reloadData];
    MenuSelect *model = [self.menuData objectAtIndex:indexPath.item];
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuConfigViewController *menuConfigView = [mainView instantiateViewControllerWithIdentifier:@"menuConfigId"];
    
    menuConfigView.menuStyle = model.name;
    menuConfigView.menuImageName = model.icon;
    menuConfigView.menuDetail = model.details;
    
    [self.navigationController pushViewController:menuConfigView animated:YES];
    
   // [self jumpToConfigView];
    
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 
 跳转到充值界面
 */
-(void)jumpToConfigView
{
    
   
    
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
