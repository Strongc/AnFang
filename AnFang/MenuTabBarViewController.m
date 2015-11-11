//
//  MenuTabBarViewController.m
//  AnBao
//
//  Created by mac   on 15/8/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuTabBarViewController.h"
#import "UIColor+Extensions.h"

@interface MenuTabBarViewController ()

@end

@implementation MenuTabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UITabBarItem *itemMessage = [self.tabBar.items objectAtIndex:3];
    UIImage *imageUnSelect = [UIImage imageNamed:@"4"];
    UIImage *imageSelected = [UIImage imageNamed:@"44"];
    
    itemMessage.image = [imageUnSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemMessage.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *itemAnFang = [self.tabBar.items objectAtIndex:2];
    itemAnFang.image = [[UIImage imageNamed:@"1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemAnFang.selectedImage = [[UIImage imageNamed:@"11"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *itemPublic = [self.tabBar.items objectAtIndex:0];
    itemPublic.image = [[UIImage imageNamed:@"3"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemPublic.selectedImage = [[UIImage imageNamed:@"33"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *itemShangMeng = [self.tabBar.items objectAtIndex:1];
    itemShangMeng.image = [[UIImage imageNamed:@"2"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemShangMeng.selectedImage = [[UIImage imageNamed:@"22"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UITabBarItem *itemSet = [self.tabBar.items objectAtIndex:4];
    itemSet.image = [[UIImage imageNamed:@"5"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemSet.selectedImage = [[UIImage imageNamed:@"55"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"ffb90f"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];

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
