//
//  MenuTabBarViewController.m
//  AnBao
//
//  Created by mac   on 15/8/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuTabBarViewController.h"

@interface MenuTabBarViewController ()

@end

@implementation MenuTabBarViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UITabBarItem *itemMessage = [self.tabBar.items objectAtIndex:3];
    UIImage *imageUnSelect = [UIImage imageNamed:@"message.png"];
    UIImage *imageSelected = [UIImage imageNamed:@"messagePress.png"];
    
    itemMessage.image = [imageUnSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemMessage.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *itemAnFang = [self.tabBar.items objectAtIndex:2];
    itemAnFang.image = [[UIImage imageNamed:@"tab"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemAnFang.selectedImage = [[UIImage imageNamed:@"tab_press"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *itemPublic = [self.tabBar.items objectAtIndex:0];
    itemPublic.image = [[UIImage imageNamed:@"tab_me_nor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemPublic.selectedImage = [[UIImage imageNamed:@"tab_me_press"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
   
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
