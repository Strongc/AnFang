//
//  PublicSourceClassViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/21.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "PublicSourceClassViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "PublicVideoClassCell.h"
#import "PublicSourceItemViewController.h"
#import "SVProgressHUD.h"
#import "CommunityVideoViewController.h"
#import "ClassVideoCell.h"
#import "SchoolVideoViewController.h"
#import "TrafficViewController.h"
#import "WGAPI.h"
#import "CMTool.h"

@interface PublicSourceClassViewController ()<VideoCollectionCellDelagate,RecommendCellDelegate>
{

    UICollectionView *videoClass;
    NSMutableArray *_allSectionList;
    NSMutableArray *_lineList;
    int _selectedLineID;

}
@property (nonatomic,strong) NSArray *mainRegionData;
@property (nonatomic,strong) NSArray *recommendVideoData;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property (nonatomic,strong) NSMutableArray *streetArray;
@property (nonatomic,strong) NSMutableArray *villageArray;
@property (nonatomic,strong) NSMutableArray *dataArray;
@property (nonatomic,strong) NSMutableArray *recommendCellSource;

@end

@implementation PublicSourceClassViewController

/**
 *  从网络中懒加载数据
 *
 *  @return _classData
 */
-(NSArray *)mainRegionData
{
    if(_mainRegionData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PublicClass.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            PublicVideoClassModel *model = [PublicVideoClassModel publicVideoClassModel:dict];
            
            [arrayModels addObject:model];
        }
        
        _mainRegionData = arrayModels;
        
    }
    
    return _mainRegionData;
}

/**
 *  从plist文件中懒加载数据
 *
 *  @return _recommendVideoData
 */
-(NSArray *)recommendVideoData
{

    if(_recommendVideoData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"recommendVideo.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            RecommendVideoModel *model = [RecommendVideoModel recommendVideoClassModel:dict];
            
            [arrayModels addObject:model];
        }
        
        _recommendVideoData = arrayModels;
        
    }
    
    return _recommendVideoData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [[NSMutableArray alloc]init];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"公共信息";
    title.font = [UIFont boldSystemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [headView addSubview:title];
    [self.view addSubview:headView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    [self initConfigControl];
    [self mainRegionData];
    [self recommendVideoData];
    _serverAddress = @"http://112.12.17.3";
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _lineList = [NSMutableArray array];
    _mspInfo = [[CMSPInfo alloc]init];
    //BOOL result = [vmsNetSDK getLineList:_serverAddress toLineInfoList:_lineList];
    _selectedLineID = 2;
    
//    if (NO == result) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
//                                                            message:@"获取线路失败"
//                                                           delegate:nil cancelButtonTitle:@"好"
//                                                  otherButtonTitles:nil, nil];
//        [alertView show];
//        return;
//    }
    
    BOOL result1 = [vmsNetSDK login:_serverAddress toUserName:@"dbwl" toPassword:@"12345" toLineID:_selectedLineID toServInfo:_mspInfo];
    if (NO == result1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"登录失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showProgressHUD) name:@"showHUD" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideProgressHUD) name:@"hideHUD" object:nil];

    self.recommendCellSource = [[NSMutableArray alloc] initWithObjects:@{@"icon":@"003.png",@"indexCode":@"33078304001310016224"},@{@"icon":@"005.png",@"indexCode":@"33078304001310015764"},@{@"icon":@"007.png",@"indexCode":@"33078304001310015618"}, nil];

    
    // Do any additional setup after loading the view.
}

-(void)refreshData
{
    [videoClass reloadData];
}

-(void)showProgressHUD
{
    [SVProgressHUD showWithStatus:@"加载中..."];
}

-(void)hideProgressHUD
{
    
    [SVProgressHUD dismiss];
}

/**
 *  在控制器设置控件
 */
-(void)initConfigControl
{
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.backgroundColor = [UIColor colorWithHexString:@"efefef"];
    self.mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  1;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if(indexPath.section == 0){
    
        static NSString *reuseIdentify = @"cell";
        HeadImageCell *headCell = (HeadImageCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
        
        if(headCell == nil){
            
            headCell = [[HeadImageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
            headCell.accessoryType = UITableViewCellAccessoryNone;
            headCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }

        cell = headCell;
    
    }else if (indexPath.section == 1){
    
        static NSString *reuseIdentify1 = @"cell1";
        ClassVideoCell *classCell = (ClassVideoCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify1];
        
        if(classCell == nil){
            
            classCell = [[ClassVideoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify1];
            classCell.accessoryType = UITableViewCellAccessoryNone;
            classCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        NSMutableArray *itemImage = [NSMutableArray arrayWithObjects:@"sequ.png",@"xiaoyuan.png",@"jiaotong.png",@"lvyou.png", nil];
        cell = classCell;
        classCell.classDataArray = self.mainRegionData;
        classCell.imageArray = itemImage;
        // NSLog(@"%lu",(unsigned long)self.dataArray.count);
        //设置ClassVideoCell的代理为当前的控制器
        classCell.delegate = self;
        
        
    }else if (indexPath.section == 2){
    
        static NSString *reuseIdentify2 = @"cell2";
        TitleCell *titleCell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify2];
        
        if(titleCell == nil){
            
            titleCell = [[TitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify2];
            titleCell.accessoryType = UITableViewCellAccessoryNone;
            titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell = titleCell;
    }else if (indexPath.section == 3){
    
        static NSString *reuseIdentify3 = @"cell3";
        RecommendCell *recommendCell = (RecommendCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify3];
        if(recommendCell == nil){
            
            recommendCell = [[RecommendCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify3];
            recommendCell.accessoryType = UITableViewCellAccessoryNone;
            recommendCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        cell = recommendCell;
        recommendCell.delegate = self;
        recommendCell.recondVideoArray = self.recommendVideoData;
        recommendCell.videoSourceArray = self.recommendCellSource;
    }
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if(indexPath.section == 0){
    
        height = 155;
    }else if (indexPath.section == 1){
    
        height = WIDTH - 60;
    }else if (indexPath.section == 2){
    
        height = 40;
    }else{
    
        height = 200;
    }
    
    return height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

/**
 *  实现ClassVideoCell的代理方法
 *
 *  @param classVideoCell <#classVideoCell description#>
 */
-(void)jumpToItemVideo:(ClassVideoCell *)classVideoCell
{
    int index = classVideoCell.cellIndex;
    
    if(index == 0){
    
        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        CommunityVideoViewController *publicItem = [mainView instantiateViewControllerWithIdentifier:@"publicitemId"];
        PublicVideoClassModel *region = [self.mainRegionData objectAtIndex:index];
        publicItem.itemStr = region.name;
        publicItem.regionId = region.regionId;
        //publicItem.countStr = region.regionCount.intValue;
        [self.navigationController pushViewController:publicItem animated:YES];
    
    }else if (index == 1){
    
        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SchoolVideoViewController *schoolView = [mainView instantiateViewControllerWithIdentifier:@"schoolId"];
       // PublicVideoClassModel *region = [self.mainRegionData objectAtIndex:index];
        //schoolView.itemStr = region.name;
        //schoolView.regionId = region.regionId;
        //schoolView.countStr = region.regionCount.intValue;
       [self.navigationController pushViewController:schoolView animated:YES];
    }else if (index == 2){
    
        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TrafficViewController *trafficView = [mainView instantiateViewControllerWithIdentifier:@"trafficId"];
        PublicVideoClassModel *region = [self.mainRegionData objectAtIndex:index];
        trafficView.itemStr = region.name;
        trafficView.regionId = region.regionId;
        trafficView.type = 2;
        [self.navigationController pushViewController:trafficView animated:YES];
    }else if (index == 3){
    
        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        TrafficViewController *trafficView = [mainView instantiateViewControllerWithIdentifier:@"trafficId"];
        PublicVideoClassModel *region = [self.mainRegionData objectAtIndex:index];
        trafficView.itemStr = region.name;
        trafficView.regionId = region.regionId;
        trafficView.type = 3;
        [self.navigationController pushViewController:trafficView animated:YES];
    
    }
   
}

/**
 *  实现RecommendCell代理方法
 *
 *  @param RecommendCell RecommendCell对象
 */
-(void)jumpToPlayView:(RecommendCell *)recommendCell
{
        int index = recommendCell.selectedIndex;
        NSString *playerCode = [[recommendCell.videoSourceArray objectAtIndex:index] objectForKey:@"indexCode"];
        PlayViewController *playVC = [[PlayViewController alloc] init];
        //把预览回放和云台控制所需的参数传过去
        playVC.serverAddress = _serverAddress;
        playVC.mspInfo = _mspInfo;
        playVC.cameraId =playerCode;
        [self.navigationController pushViewController:playVC animated:YES];
        return;
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
