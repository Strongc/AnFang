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
