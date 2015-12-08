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
    UIImage *imageUnSelect = [UIImage imageNamed:@"messagenor"];
    UIImage *imageSelected = [UIImage imageNamed:@"messageSelect"];
    
    itemMessage.image = [imageUnSelect imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemMessage.selectedImage = [imageSelected imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemMessage.imageInsets = UIEdgeInsetsMake(-1, -1, 1, 1);
    
    UITabBarItem *itemAnFang = [self.tabBar.items objectAtIndex:2];
    itemAnFang.image = [[UIImage imageNamed:@"anfangnor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemAnFang.selectedImage = [[UIImage imageNamed:@"anfangSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemAnFang.imageInsets = UIEdgeInsetsMake(-1, -1, 1, 1);//解决item上的图片越点越小的bug
    
    UITabBarItem *itemPublic = [self.tabBar.items objectAtIndex:0];
    itemPublic.image = [[UIImage imageNamed:@"publicnor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemPublic.selectedImage = [[UIImage imageNamed:@"publicSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemPublic.imageInsets = UIEdgeInsetsMake(-1, -1, 1, 1);
    
    UITabBarItem *itemShangMeng = [self.tabBar.items objectAtIndex:1];
    itemShangMeng.image = [[UIImage imageNamed:@"businessnor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemShangMeng.selectedImage = [[UIImage imageNamed:@"businessSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemShangMeng.imageInsets = UIEdgeInsetsMake(-1, -1, 1, 1);

    UITabBarItem *itemSet = [self.tabBar.items objectAtIndex:4];
    itemSet.image = [[UIImage imageNamed:@"setnor"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemSet.selectedImage = [[UIImage imageNamed:@"setSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    itemSet.imageInsets = UIEdgeInsetsMake(-1, -1, 1, 1);
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"ffffff"],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    self.mainTabBar.tintColor = [UIColor colorWithHexString:@"dfdfdf"];
    self.selectedIndex = 2;
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
