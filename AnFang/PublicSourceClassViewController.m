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
#import "PublicVideoClassModel.h"
#import "PublicSourceItemViewController.h"
#import "SVProgressHUD.h"
#import "PublicVideoitemViewController.h"
#import "HeadImageCell.h"
#import "ClassVideoCell.h"
#import "TitleCell.h"

@interface PublicSourceClassViewController ()
{

    UICollectionView *videoClass;
    NSMutableArray *_allSectionList;
    NSMutableArray *_lineList;
    int _selectedLineID;
   
    //PublicVideoitemViewController *publicItem;

}
@property (nonatomic,strong) NSArray *classData;
@property (weak, nonatomic) IBOutlet UITableView *mainTableView;

@end

@implementation PublicSourceClassViewController


//-(NSMutableArray *)_getAllVideoInSection
//{
//    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
//    _allSectionList = [NSMutableArray array];
//    NSMutableArray *tempArray = [NSMutableArray array];
//    if (nil == _regionInfo) {
//        if (nil == _controlUnitInfo) {
//            
//            //获取根控制中心
//            [vmsNetSDK getControlUnitList:_serverAddress
//                              toSessionID:_mspInfo.sessionID
//                          toControlUnitID:0
//                             toNumPerOnce:50
//                                toCurPage:1
//                        toControlUnitList:tempArray];
//            [_allSectionList addObjectsFromArray:tempArray];
//            [tempArray removeAllObjects];
//        } else {
//            
//            //获取控制中心下的控制中心
//            [vmsNetSDK getControlUnitList:_serverAddress
//                              toSessionID:_mspInfo.sessionID
//                          toControlUnitID:_controlUnitInfo.controlUnitID
//                             toNumPerOnce:50
//                                toCurPage:1
//                        toControlUnitList:tempArray];
//            [_allSectionList addObjectsFromArray:tempArray];
//            [tempArray removeAllObjects];
//            
//            //获取控制中心下的区域
//            [vmsNetSDK getRegionListFromCtrlUnit:_serverAddress
//                                     toSessionID:_mspInfo.sessionID
//                                 toControlUnitID:_controlUnitInfo.controlUnitID
//                                    toNumPerOnce:50
//                                       toCurPage:1
//                                    toRegionList:tempArray];
//            [_allSectionList addObjectsFromArray:tempArray];
//            [tempArray removeAllObjects];
//            
//        }
//    } else {
//        
//        
//    }
//    return _allSectionList;
//    
//}

-(NSArray *)classData
{
    if(_classData == nil){
        
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
        
        _classData = arrayModels;
        
    }
    
    return _classData;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"公共信息";
    title.font = [UIFont boldSystemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [headView addSubview:title];
    [self.view addSubview:headView];
    self.view.backgroundColor = [UIColor colorWithHexString:@"040818"];
    [self initConfigControl];
    
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

    
   // [self _getAllVideoInSection];
    
    // Do any additional setup after loading the view.
}

-(void)showProgressHUD
{

    SVProgressHUD *svP = [[SVProgressHUD alloc] init];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [self.view addSubview:svP];
}

-(void)hideProgressHUD
{
    
    [SVProgressHUD dismiss];
}


-(void)initConfigControl
{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"head.png" ofType:nil];
//    UIImageView *headImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 74, WIDTH-30, 150)];
//    [self.view addSubview:headImage];
//    headImage.image = [UIImage imageWithContentsOfFile:path];
    
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
//    
//    UILabel *title2 = [[UILabel alloc] initWithFrame:CGRectMake(5, 0, 76, backView.frame.size.height)];
//    [backView addSubview:title2];
//    title2.textAlignment = NSTextAlignmentCenter;
//    title2.text = @"热门视频";
//    title2.font = [UIFont boldSystemFontOfSize:18];
//    title2.textColor = [UIColor colorWithHexString:@"db0303"];

    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    self.mainTableView.backgroundColor = [UIColor colorWithHexString:@"040818"];
//    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
//    videoClass = [[UICollectionView alloc]initWithFrame:CGRectMake(5, 234, WIDTH-10, WIDTH-10) collectionViewLayout:flowLayout];
//    videoClass.delegate = self;
//    videoClass.dataSource = self;
//#pragma mark -- 头尾部大小设置
//    //设置头部并给定大小
//    //[flowLayout setHeaderReferenceSize:CGSizeMake(videoClass.frame.size.width, 40)];
//#pragma mark -- 注册头部视图
////    [videoCollection registerClass:[PublicHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
//    
//    //[self.view addSubview:videoClass];
//    videoClass.backgroundColor = [UIColor colorWithHexString:@"040818"];
//    videoClass.scrollEnabled = YES;
//    [videoClass registerClass:[PublicVideoClassCell class] forCellWithReuseIdentifier:@"cell"];


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

        cell = classCell;
        classCell.classDataArray = self.classData;
    }else if (indexPath.section == 2){
    
        static NSString *reuseIdentify2 = @"cell2";
        TitleCell *titleCell = (TitleCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify2];
        
        if(titleCell == nil){
            
            titleCell = [[TitleCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify2];
            titleCell.accessoryType = UITableViewCellAccessoryNone;
            titleCell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        
        cell = titleCell;

    
    }
    
//    AlarmMessageTableViewCell *cell = (AlarmMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
//    
//    if(cell == nil){
//        
//        cell = [[AlarmMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
//        
//        cell.accessoryType = UITableViewCellAccessoryNone;
//        cell.selectionStyle = UITableViewCellSelectionStyleNone;
//        
//    }
//    
//    AlarmMessageModel *model = [messageArray objectAtIndex:indexPath.row];
//    cell.alarmMessage = model;
    //[cell.checkBtn setTag:indexPath.row];
    //[cell.checkBtn addTarget:self action:@selector(jumpToDetailView:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if(indexPath.section == 0){
    
        height = 150;
    }else if (indexPath.section == 1){
    
        height = WIDTH - 20;
    }else if (indexPath.section == 2){
    
        height = 40;
    }
//    }else{
//    
//        height = 80;
//    }
    
    return height;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    AlarmMessageDetailViewController *detailView = [mainView instantiateViewControllerWithIdentifier:@"alarmMessageDetailId"];
//    AlarmMessageModel *model = [messageArray objectAtIndex:indexPath.row];
//    detailView.messageId = model.messageId;
//    [self.navigationController pushViewController:detailView animated:YES];
    
}


//#pragma mark UICollectionViewDataSource
//-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    
//    return self.classData.count;
//}
//
//
//-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    static NSString *identifyId = @"cell";
//    PublicVideoClassCell *cell = (PublicVideoClassCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
//    
//    PublicVideoClassModel *model = [self.classData objectAtIndex:indexPath.item];
//    
//    cell.publicClass = model;
//    [cell setTag:indexPath.row];
//    //[cell.backViewBtn addTarget:self action:@selector(doJumpTo:) forControlEvents:UIControlEventTouchUpInside];
//    return cell;
//}
//
//#pragma mark UICollectionViewDelegateFlowLayout
//
////定义每个cell的大小
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return CGSizeMake((videoClass.frame.size.width-40)/2 +5, (videoClass.frame.size.height-40)/2);
//}
//
////设置每组cell的边界
//-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
//{
//    
//    return UIEdgeInsetsMake(0, 10, 10, 10);//上,左，下，右
//}
//
////-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
////{
////    
////    return 0;
////}
////
////-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
////{
////    
////    return 10;
////}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//   // int index = (int)indexPath.row;
//    [[NSNotificationCenter defaultCenter] postNotificationName:@"showHUD" object:nil];
//    [self performSelector:@selector(doJumpTo:) withObject:indexPath afterDelay:2.0f];
//}
//
//-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//    return YES;
//}
//
//
//-(void)doJumpTo:(NSIndexPath *)index
//{
//    //int index = (int)[sender tag];
//    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    PublicVideoitemViewController *publicItem = [mainView instantiateViewControllerWithIdentifier:@"publicitemId"];
//    PublicVideoClassModel *region = [self.classData objectAtIndex:index.row];
//    publicItem.itemStr = region.className;
//    publicItem.regionId = region.regionId;
//    publicItem.countStr = region.regionCount.intValue;
//    [self.navigationController pushViewController:publicItem animated:YES];
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
