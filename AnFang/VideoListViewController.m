//
//  VideoListViewController.m
//  AnBao
//
//  Created by mac   on 15/9/8.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "VideoListViewController.h"
#import "UIView+KGViewExtend.h"
#import "SingleVideoViewController.h"
#import "VideoListTabBarViewController.h"
#import "Common.h"
#import "SCNavTabBarController.h"
#import "AnFangTabBarViewController.h"
#import "UIColor+Extensions.h"

@implementation VideoListViewController

//-(void)viewWillAppear:(BOOL)animated
//{
//    
//    self.navigationController.navigationBarHidden = YES;
//    
//}
//
//-(void)viewWillDisappear:(BOOL)animated
//{
//    
//    //self.navigationController.navigationBarHidden = NO;
//    
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 70*HEIGHT/667)];
//    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
//    
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.text = @"视频列表";
//    title.textColor = [UIColor whiteColor];
//    [headView addSubview:title];
//    [self.view addSubview:headView];
//    
//    UIButton *backBtn1 = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
//    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(22*WIDTH/375, 7*HEIGHT/667, 32, 16)];
//    backTitle.textAlignment = NSTextAlignmentCenter;
//    backTitle.text = @"返回";
//    backTitle.font = [UIFont systemFontOfSize:16];
//    backTitle.textColor = [UIColor whiteColor];
//    [backBtn1 addSubview:backTitle];
//    
//    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5*HEIGHT/667, 20, 20)];
//    backImage.image = [UIImage imageNamed:@"back.png"];
//    [backBtn1 addSubview:backImage];
//    [backBtn1 addTarget:self action:@selector(backToPreView) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtn1];

    
    SingleVideoViewController *timeVideoList = [[SingleVideoViewController alloc] init];
    timeVideoList.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    SingleVideoViewController *historyVideoList = [[SingleVideoViewController alloc] init];
    SingleVideoViewController *cutVideoList = [[SingleVideoViewController alloc] init];
    SingleVideoViewController *localVideoList = [[SingleVideoViewController alloc] init];
    timeVideoList.title = @"实时";
    historyVideoList.title = @"历史记录";
    cutVideoList.title = @"剪辑";
    localVideoList.title = @"本地保存";
    
    
    VideoListTabBarViewController *navTabBarController = [[VideoListTabBarViewController alloc]init];
    navTabBarController.subViewControllers = @[timeVideoList, historyVideoList,cutVideoList,localVideoList];
    [navTabBarController addParentController:self];
    
   // [self backToPreView];



    // Do any additional setup after loading the view.
}

-(void)backToPreView
{
    NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
    
     NSLog(@"%@",@"dddddffff");
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
