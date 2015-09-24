//
//  MessageViewController.m
//  AnBao
//
//  Created by mac   on 15/9/10.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()
{
    UISearchBar *searchBar;
    UITableView *messageTable;
    NSMutableArray *arData;
    // UISearchDisplayController *searchDisplay;
    UIView *maskView;
    NSArray *arMenu;
    UIView *menuView;
    BOOL touch;
    UIView *coverView;
    // RectViewForMessage *rectMenu;
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    AlarmMessageViewController *alarmMessageView = [[AlarmMessageViewController alloc] init];
    SystemMessageViewController *systemMessageView = [[SystemMessageViewController alloc] init];
    UserMessageViewController *userMessageView = [[UserMessageViewController alloc]init];
    BusinessMessageViewController *businessView = [[BusinessMessageViewController alloc]init];
    
    alarmMessageView.title = @"安防消息";
    systemMessageView.title = @"温馨提醒";
    userMessageView.title = @"资讯内容";
    businessView.title = @"商业活动";
    
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    
    navTabBarController.subViewControllers = @[alarmMessageView, systemMessageView,userMessageView,businessView];
    [navTabBarController addParentController:self];
    
    // [self ConfigControl];
    //[self initData];
    
    arMenu = @[@[@"建讨论组",@"menu_icon_createDiscuss.png"],
               @[@"多人通话",@"menu_icon_groupaudio.png"],
               @[@"共享照片",@"menu_icon_camera.png"],
               @[@"扫一扫",@"menu_icon_QR.png"]];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = item;
   
    
    // Do any additional setup after loading the view.
}

//-(void)ConfigControl
//{
//
//    touch = NO;
//    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
//    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
//
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 5, WIDTH, 50)];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.text = @"消息";
//    title.textColor = [UIColor whiteColor];
//    [headView addSubview:title];
//    //[self.view addSubview:headView];
//
//    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-40, 20, 25, 25)];
//    [self.view addSubview:btn];
//
//    [btn setBackgroundImage:[UIImage imageNamed:@"menu_icon_bulb"] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:@"menu_icon_bulb_pressed"] forState:UIControlStateSelected];
//    [btn setSelected:NO];
//
//    [btn addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
//
//    messageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 94, WIDTH, HEIGHT-50)];
//    messageTable.delegate = self;
//    messageTable.dataSource = self;
//    //[self.view addSubview:messageTable];
//
//    searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0, 60, WIDTH, 44)];
//    [searchBar setPlaceholder:@"搜索"];
//    [searchBar setSearchBarStyle:UISearchBarStyleDefault];
//
//    searchDisplay = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
//
//    searchDisplay.active = NO;
//    searchDisplay.delegate = self;
//    searchDisplay.searchResultsDataSource = self;
//    searchDisplay.searchResultsDelegate = self;
//   // [self.view addSubview:searchDisplay.searchBar];
//
//    maskView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.frame.size.height-10, WIDTH, self.tabBarController.tabBar.frame.size.height+25)];
//    maskView.backgroundColor = [UIColor whiteColor];
//    [maskView setClipsToBounds:YES];
//   // [self.view addSubview:maskView];
//    [maskView setHidden:YES];
//
//    UIView *bgMenu = [[UIView alloc] initWithFrame:maskView.bounds];
//    [bgMenu setBackgroundColor:[UIColor whiteColor]];
//    [bgMenu setAlpha:0.5];
//    [maskView addSubview:bgMenu];
//
//    menuView = [[UIView alloc] initWithFrame:CGRectMake(0, -65, WIDTH, 75)];
//    [maskView addSubview:menuView];
//
//    coverView = [[UIView alloc]initWithFrame:CGRectMake(0, headView.frame.size.height-10+maskView.frame.size.height, WIDTH, HEIGHT-headView.frame.size.height-maskView.frame.size.height)];
//    coverView.backgroundColor = [UIColor grayColor];
//    coverView.hidden = YES;
//    coverView.alpha = 0.5;
//    //[self.view addSubview:coverView];
//
//    UIButton *btnGroup = [[UIButton alloc] initWithFrame:CGRectMake(30, 10, 40, 40)];
//    [maskView addSubview:btnGroup];
//    [btnGroup setBackgroundImage:[UIImage imageNamed:@"menu_icon_createDiscuss.png"] forState:UIControlStateNormal];
//
//    UIButton *btnTelPhone = [[UIButton alloc] initWithFrame:CGRectMake(120, 10, 40, 40)];
//    [maskView addSubview:btnTelPhone];
//    [btnTelPhone setBackgroundImage:[UIImage imageNamed:@"menu_icon_groupaudio.png"] forState:UIControlStateNormal];
//
//    UIButton *btnSharePhoto = [[UIButton alloc] initWithFrame:CGRectMake(210, 10, 40, 40)];
//    [maskView addSubview:btnSharePhoto];
//    [btnSharePhoto setBackgroundImage:[UIImage imageNamed:@"menu_icon_camera.png"] forState:UIControlStateNormal];
//
//    UIButton *btnScan = [[UIButton alloc] initWithFrame:CGRectMake(300, 10, 40, 40)];
//    [maskView addSubview:btnScan];
//    [btnScan setBackgroundImage:[UIImage imageNamed:@"menu_icon_QR.png"] forState:UIControlStateNormal];
//
//    UILabel *group = [[UILabel alloc]initWithFrame:CGRectMake(20, 55, 60, 10)];
//    [maskView addSubview:group];
//    group.font = [UIFont systemFontOfSize:15];
//    group.textAlignment = NSTextAlignmentLeft;
//    group.text = @"建讨论组";
//
//    UILabel *tel = [[UILabel alloc]initWithFrame:CGRectMake(110, 55, 60, 10)];
//    [maskView addSubview:tel];
//    tel.font = [UIFont systemFontOfSize:15];
//    tel.textAlignment = NSTextAlignmentLeft;
//    tel.text = @"多人通话";
//
//    UILabel *share = [[UILabel alloc]initWithFrame:CGRectMake(200, 55, 60, 10)];
//    [maskView addSubview:share];
//    share.font = [UIFont systemFontOfSize:15];
//    share.textAlignment = NSTextAlignmentLeft;
//    share.text = @"共享照片";
//
//    UILabel *scan = [[UILabel alloc]initWithFrame:CGRectMake(296, 55, 45, 10)];
//    [maskView addSubview:scan];
//    scan.font = [UIFont systemFontOfSize:15];
//    scan.textAlignment = NSTextAlignmentLeft;
//    scan.text = @"扫一扫";
//
//
//
//  //  rectMenu = [[RectViewForMessage alloc] initWithFrame:CGRectMake(0, -75, self.view.frame.size.width, 75) ar:arMenu showSpera:NO bg:@"menu_bg_pressed.png"];
//   // [menuView addSubview:rectMenu];
//
//}
//
//-(void)showMenu:(UIButton *)btn
//{
//    [btn setUserInteractionEnabled:NO];
//    [btn setSelected:!btn.selected];
//
//    [self showMenuWithBool:btn.selected complete:^()
//     {
//         [btn setUserInteractionEnabled:YES];
//     }];
//
//}
//
//-(void)showMenuWithBool:(BOOL)bShow complete:(void(^)())complete
//{
//    if(bShow){
//        [maskView setHidden:NO];
//        [coverView setHidden:NO];
//       // messageTable = [UIColor colorWithHexString:@"f5f5f5"];
//        [UIView animateWithDuration:0.3 animations:^{
//
//            CGFloat y = menuView.frame.origin.y;
//            y = 0.0;
//
//        } completion:^(BOOL finished) {
//
//            complete();
//        }];
//
//    }else{
//        [UIView animateWithDuration:0.3 animations:^{
//            CGFloat y = menuView.frame.origin.y;
//            CGFloat h = menuView.frame.size.height;
//            y = h;
//
//        } completion:^(BOOL finished) {
//            //self.view.backgroundColor = [UIColor whiteColor];
//            [maskView setHidden:YES];
//            [coverView setHidden:YES];
//            complete();
//        }];
//
//    }
//
//}
//
//-(void)initData
//{
//    __async_opt__,^
//    {
//        arData = [[NSMutableArray alloc]init];
//        [arData addObject:@"好友A"];
//        [arData addObject:@"陌生人C"];
//        [arData addObject:@"我的电脑"];
//        [arData addObject:@"群B"];
//
//        __async_main__, ^
//        {
//            [messageTable reloadData];
//        });
//
//
//    });
//}
//
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//
//-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    if(tableView == searchDisplay.searchResultsTableView){
//
//        return 0;
//    }
//    return arData.count;
//}
//
//-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *reuseIdentifier = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
//    if(!cell){
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
//
//    }
//    cell.textLabel.text = [arData objectAtIndex:indexPath.row];
//
//    return cell;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//
//    return 65.0;
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
