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
@implementation SecuritySystemViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    NeedHelpViewController *needHelpView = [[NeedHelpViewController alloc]init];
    MonitorViewController *monitorView = [[MonitorViewController alloc]init];
    needHelpView.title = @"人";
    monitorView.title = @"屋";
    AnFangTabBarViewController *navTabBarController = [[AnFangTabBarViewController alloc] init];
    navTabBarController.subViewControllers = @[needHelpView,monitorView];
    [navTabBarController addParentController:self];
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
