//
//  ShangMengViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/10.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "ShangMengViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "PublicVideoClassCell.h"
#import "ShangMengItemViewController.h"

@interface ShangMengViewController ()
{
    UICollectionView *shangMengClass;
    

}

@property (nonatomic,strong) NSArray *classDataSource;
@end

@implementation ShangMengViewController

-(NSArray *)classDataSource
{
    if(_classDataSource == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"ShangmengItem.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            ShangMengClassModel *model = [ShangMengClassModel shangMengClassModel:dict];
            
            [arrayModels addObject:model];
        }
        
        _classDataSource = arrayModels;
        
    }
    
    return _classDataSource;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"商盟";
    title.font = [UIFont boldSystemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [headView addSubview:title];
    [self.view addSubview:headView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"040818"];
    [self initConfigControl];

       // Do any additional setup after loading the view.
}

-(void)initConfigControl
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"guanggao.jpg" ofType:nil];
    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 74, WIDTH-30, 150)];
    [self.view addSubview:headImage];
    headImage.image = [UIImage imageWithContentsOfFile:path];
    
//    UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, headImage.frame.size.height-40, headImage.frame.size.width, 40)];
//    [headImage addSubview:backView];
//    backView.backgroundColor = [UIColor blackColor];
//    backView.alpha = 0.65;
//    UILabel *title1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, backView.frame.size.width, backView.frame.size.height)];
//    [backView addSubview:title1];
//    title1.textAlignment = NSTextAlignmentCenter;
//    title1.text = @"最热门点击视频";
//    title1.font = [UIFont boldSystemFontOfSize:14];
//    title1.textColor = [UIColor whiteColor];
    
//    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 76, backView.frame.size.height)];
//    [backView addSubview:title2];
//    title2.textAlignment = NSTextAlignmentCenter;
//    title2.text = @"热门视频";
//    title2.font = [UIFont boldSystemFontOfSize:18];
//    title2.textColor = [UIColor colorWithHexString:@"db0303"];
    
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    shangMengClass = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 234, WIDTH-10, WIDTH-10) collectionViewLayout:flowLayout];
    shangMengClass.delegate = self;
    shangMengClass.dataSource = self;
#pragma mark -- 头尾部大小设置
    //设置头部并给定大小
    //[flowLayout setHeaderReferenceSize:CGSizeMake(videoClass.frame.size.width, 40)];
#pragma mark -- 注册头部视图
    //    [videoCollection registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    
    [self.view addSubview:shangMengClass];
    shangMengClass.backgroundColor = [UIColor colorWithHexString:@"040818"];
    shangMengClass.scrollEnabled = YES;
    [shangMengClass registerClass:[PublicVideoClassCell class] forCellWithReuseIdentifier:@"cell"];
    
    
}

#pragma mark UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.classDataSource.count;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    PublicVideoClassCell *cell = (PublicVideoClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
    
    ShangMengClassModel *model = [self.classDataSource objectAtIndex:indexPath.item];
    
    cell.shangmengClassModel = model;
    [cell setTag:indexPath.row];
    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((shangMengClass.frame.size.width-40)/2 +5, (shangMengClass.frame.size.height-40)/2);
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    
    return UIEdgeInsetsMake(0, 10, 10, 10);//上,左，下，右
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    ShangMengItemViewController *shangmengItem = [mainView instantiateViewControllerWithIdentifier:@"shangquanId"];
    ShangMengClassModel *shangmeng = [self.classDataSource objectAtIndex:indexPath.row];
    shangmengItem.titleStr = shangmeng.className;
    [self.navigationController pushViewController:shangmengItem animated:YES];


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
