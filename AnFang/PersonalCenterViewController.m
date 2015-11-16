//
//  PersonalCenterViewController.m
//  AnBao
//
//  Created by mac   on 15/8/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PersonalCenterViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "PersonCenterTableViewCell.h"
#import "AccountCenterViewController.h"
#import "WGAPI.h"
#import "JSONKit.h"
#import "CMTool.h"
#import "CoreArchive.h"

@interface PersonalCenterViewController ()<UITableViewDelegate,UITableViewDataSource,NSURLConnectionDataDelegate>
{
    
    UITableView *personTable;
    NSMutableArray *_arData;
    NSMutableArray *optionImage1;
    NSMutableArray *optionTitle1;
    NSMutableArray *optionImage2;
    NSMutableArray *optionTitle2;
   
    NSString *result;
    NSMutableData *infoData;
    NSMutableArray *userInfoArray;
    NSDictionary *json;
    NSString *nickName;
    
    
}

@end

@implementation PersonalCenterViewController
//@synthesize personTable;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    infoData= [[NSMutableData alloc] init];
    userInfoArray = [[NSMutableArray alloc]init];
    json = [[NSDictionary alloc]init];
    
    optionTitle1 = [[NSMutableArray alloc]initWithObjects:@"我的行业", @"收藏夹",@"账户中心",nil];
    optionTitle2 = [[NSMutableArray alloc]initWithObjects:@"系统设置",@"意见反馈",nil];
    
    optionImage1 = [[NSMutableArray alloc]initWithObjects:@"我的行业.png",@"收藏夹.png",@"账户中心.png",nil];
    optionImage2 = [[NSMutableArray alloc]initWithObjects:@"系统设置.png",@"意见反馈.png",nil];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = item;
    [self ConfigControl];
    
   // [self getUserInfo];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getUserInfo) name:@"getUserInfo" object:nil];
   // NSString *Id = [CoreArchive strForKey:@"userId"];
   // NSLog(@"%@",Id);
    //[self getUserInfo];
   
}

-(void)getUserInfo
{
    
    NSString *name = [CoreArchive strForKey:@"name"];
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"2"};
    NSDictionary *pageInfo = @{@"page":page,@"usr_name":name};
    NSString *pageStr = [pageInfo JSONString];
    NSString *userInfoData = [@"user=" stringByAppendingString:pageStr];
   // NSString *urlStr=[NSString stringWithFormat:@"http://192.168.0.42:8080/platform/user/page"];
    //userInfo = [WGAPI httpAsynchronousRequestUrl:urlStr postStr:userInfoData];
    [WGAPI post:API_GET_USERINFO RequestParams:userInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
       
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonStr);
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
           // NSDictionary *userInfo = [infojson objectForKey:@"data"];
            userInfoArray = [infojson objectForKey:@"datas"];
            
            if(userInfoArray.count > 0){
                
                NSDictionary *userMessage = userInfoArray[0];
                nickName = [userMessage objectForKey:@"usr_name"];
               // userId = [userMessage objectForKey:@"usr_id"];
                
                [self performSelectorOnMainThread:@selector(refreshUIControl) withObject:data waitUntilDone:YES];//刷新UI线程
            }
           
            
        }
        
        
    }];
    
}

-(void)refreshUIControl
{
    
    //[CoreArchive setStr:userId key:@"userId"];
}

-(void)ConfigControl
{

   // UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
   // [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"ffd700"];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"个人中心";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];
    
    UIImageView *backgroundImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 80*HEIGHT/667)];
    backgroundImage.image = [UIImage imageNamed:@"bg.png"];
    [self.view addSubview:backgroundImage];
    
    personTable = [[UITableView alloc] initWithFrame:CGRectMake(0,240*HEIGHT/667,WIDTH ,HEIGHT-200*HEIGHT/667) style:UITableViewStylePlain];
    
    personTable.delegate = self;
    personTable.dataSource = self;
    personTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:personTable];
    personTable.scrollEnabled = NO;
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 240*HEIGHT/667, WIDTH, 1.0)];
    lineView.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [self.view addSubview:lineView];
    
    UIView *headImageView = [[UIView alloc]initWithFrame:CGRectMake(30*WIDTH/375, 110*HEIGHT/667, 110*WIDTH/375, 110*HEIGHT/667)];
    headImageView.backgroundColor = [UIColor whiteColor];
    headImageView.layer.borderWidth = 1.5;
    headImageView.layer.borderColor = [[UIColor colorWithHexString:@"bababa"]CGColor];
    
    [self.view addSubview:headImageView];
    
    UIView *defaultImage = [[UIView alloc]initWithFrame:CGRectMake(6*WIDTH/375, 6*HEIGHT/667, 98*WIDTH/375, 98*HEIGHT/667)];
    [defaultImage setBackgroundColor:[UIColor colorWithHexString:@"bababa"]];
    [headImageView addSubview:defaultImage];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 98*WIDTH/375, 98*HEIGHT/667)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = @"暂无头像";
    titleLab.textColor = [UIColor whiteColor];
    titleLab.font = [UIFont boldSystemFontOfSize:16*WIDTH/375];
    [defaultImage addSubview:titleLab];
    
    UILabel *userName = [[UILabel alloc]initWithFrame:CGRectMake(155*WIDTH/375, 160*HEIGHT/667, 200*WIDTH/375, 16*HEIGHT/667)];
    userName.textAlignment = NSTextAlignmentCenter;
    userName.textColor = [UIColor blackColor];
    userName.font = [UIFont boldSystemFontOfSize:16*WIDTH/375];
    userName.text = [CoreArchive strForKey:@"name"];
    [self.view addSubview:userName];
    [self.view setBackgroundColor:[UIColor whiteColor]];

}

//- (void)initData
//{
//    __async_opt__, ^
//    {
//        _arData = [[NSMutableArray alloc] init];
//        
//        NSArray *ar1 = @[@"好友动态"];
//        NSArray *ar2 = @[@"游戏", @"福利", @"阅读"];
//        NSArray *ar3 = @[@"文件/照片 助手", @"吃喝玩乐", @"扫一扫", @"热门活动", @"腾讯新闻"];
//        NSArray *ar4 = @[@"附近的人", @"附近的群", @"兴趣部落"];
//        
//        [_arData addObject:ar1];
//        [_arData addObject:ar2];
//        [_arData addObject:ar3];
//        [_arData addObject:ar4];
//        
//        __async_main__, ^
//        {
//            [personTable reloadData];
//        });
//    });
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return 2;

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(section == 0){
      return optionImage1.count;
    }
    
    return optionImage2.count;
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentifier = @"cell";
    
    PersonCenterTableViewCell *cell =(PersonCenterTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    //cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    // cell.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    
    if (cell == nil) {
        
        cell = [[PersonCenterTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    if(indexPath.section == 0){
        cell.cellImage.image = [UIImage imageNamed:[optionImage1 objectAtIndex:indexPath.row]];
        cell.cellTitle.text = [optionTitle1 objectAtIndex:indexPath.row];
    
    }else {
        cell.cellImage.image = [UIImage imageNamed:[optionImage2 objectAtIndex:indexPath.row]];
        cell.cellTitle.text = [optionTitle2 objectAtIndex:indexPath.row];

    }
  
    
    return cell;
}



-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{

    //UIView *headView;
    if(section == 1){
    //CGFloat w = [UIScreen mainScreen].bounds.size.width;
   // CGFloat rate = w / CELL_CONTENT_WIDTH;
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 30*HEIGHT/667 )];
    headView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 30*HEIGHT/667, WIDTH, 1)];
    
    line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [headView addSubview:line];
     return headView;
    }
    
    return nil;
}

#pragma mark - UITableViewDelegate

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{

    return 1.0;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 0;
    }
    return 30.0*HEIGHT/667;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 60.0*HEIGHT/667;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //NSLog(@"fsdfsfsfsdfsf");
    if(indexPath.section == 0 && indexPath.row == 2){
    
        [self jumpToAccountView];
    }else if (indexPath.section == 1){
    
        //[self goToVideoList];
    }
    

}

-(void)jumpToAccountView
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AccountCenterViewController *accountView = [mainView instantiateViewControllerWithIdentifier:@"accountCenterId"];
    [self.navigationController pushViewController:accountView animated:YES];



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
