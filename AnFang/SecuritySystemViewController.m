//
//  SecuritySystemViewController.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "SecuritySystemViewController.h"
#import "Common.h"
#import "AnFangTabBarViewController.h"
#import "MonitorViewController.h"
#import "UIColor+Extensions.h"
//#import "HostListViewController.h"

//@interface SecuritySystemViewController ()<MHTabBarControllerDelegate>

//@end

@implementation SecuritySystemViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
//    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64*HEIGHT/667)];
//    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
//    [self.view addSubview:headView];
   
    NeedHelpViewController *needHelpView = [[NeedHelpViewController alloc]init];
    //CheBuFangViewController *cheBufangView = [[CheBuFangViewController alloc]init];
    MonitorViewController *monitorView = [[MonitorViewController alloc]init];
   // HostListViewController *hostListView = [[HostListViewController alloc]init];
    
   // cheBufangView.title = @"撤部防";
    needHelpView.title = @"人";
    monitorView.title = @"屋";
    
    AnFangTabBarViewController *navTabBarController = [[AnFangTabBarViewController alloc] init];
   // navTabBarController.navTabBarColor = [UIColor colorWithHexString:@"ce7031"];
   
    navTabBarController.subViewControllers = @[needHelpView,monitorView];
    [navTabBarController addParentController:self];
    
   // UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
   // item.title = @"返回";
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
   // self.navigationItem.backBarButtonItem = item;
    [navTabBarController.view endEditing:YES];
    
    self.view.backgroundColor = [UIColor clearColor];
    // Do any additional setup after loading the view.
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
