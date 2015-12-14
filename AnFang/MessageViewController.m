//
//  MessageViewController.m
//  AnBao
//
//  Created by mac   on 15/9/10.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MessageViewController.h"
#import "Common.h"

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
    
}

@end

@implementation MessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    AlarmMessageViewController *alarmMessageView = [[AlarmMessageViewController alloc] init];
    SystemMessageViewController *systemMessageView = [[SystemMessageViewController alloc] init];
    UserMessageViewController *userMessageView = [[UserMessageViewController alloc]init];
    
    alarmMessageView.title = @"资讯";
    systemMessageView.title = @"安防消息";
    userMessageView.title = @"资费提醒";
    SCNavTabBarController *navTabBarController = [[SCNavTabBarController alloc] init];
    navTabBarController.subViewControllers = @[alarmMessageView, systemMessageView,userMessageView];
    [navTabBarController addParentController:self];
    
    UIButton *item = [navTabBarController.navTabBar.items objectAtIndex:1];
    [item.badgeView setPosition:MGBadgePositionTopRight];
    [item.badgeView setBadgeColor:[UIColor redColor]];
    
    NSInteger n = systemMessageView.amount;
    NSLog(@"数量：%ld",(long)n);
    
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
