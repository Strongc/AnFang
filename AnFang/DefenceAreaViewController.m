//
//  DefenceAreaViewController.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "DefenceAreaViewController.h"
#import "UIView+KGViewExtend.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "DefenceAreaDevListViewController.h"
#import "VideoListViewController.h"

@interface DefenceAreaViewController ()

@end

@implementation DefenceAreaViewController


-(void)viewWillAppear:(BOOL)animated
{

    self.navigationController.navigationBarHidden = YES;

}

-(void)viewWillDisappear:(BOOL)animated
{

    self.navigationController.navigationBarHidden = NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfigControl];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = item;

    // Do any additional setup after loading the view.
}

-(void)ConfigControl
{
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64*HEIGHT/667)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"防区";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH/375, 7*HEIGHT/667, 32, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont systemFontOfSize:16];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5*HEIGHT/667, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];

    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *areaName = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH/375, 80*HEIGHT/667, 240*WIDTH/375, 15*HEIGHT/667)];
    
    areaName.textColor = [UIColor blackColor];
    areaName.font = [UIFont systemFontOfSize:15*WIDTH/375];
    //areaName.text = @"防区001：华业大厦广场北区";
    areaName.text = self.defenceAreaName;
    [self.view addSubview:areaName];
    self.areaName = areaName;
    
    UIImageView *areaImage = [[UIImageView alloc]initWithFrame:CGRectMake(10*WIDTH/375, 107*HEIGHT/667, (375-20)*WIDTH/375, 160*HEIGHT/667)];
    areaImage.image = [UIImage imageNamed:@"bg.png"];
    [self.view addSubview:areaImage];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH/375, 277*HEIGHT/667, 65*WIDTH/375, 15*HEIGHT/667)];
    title1.text = @"防区描述:";
    title1.textColor = [UIColor blackColor];
    title1.font = [UIFont systemFontOfSize:15*WIDTH/375];
    [self.view addSubview:title1];
    
    UILabel *areaInfo = [[UILabel alloc]initWithFrame:CGRectMake(40*WIDTH/375, 302*HEIGHT/667, 330*WIDTH/375, 45*HEIGHT/667)];
    areaInfo.text = @"防区位于华业大厦北侧，总面积1200平方米，含车位50个，车闸入口2个，墙体3面...";
    areaInfo.textColor = [UIColor grayColor];
    areaInfo.numberOfLines = 0;
    areaInfo.font = [UIFont systemFontOfSize:15*WIDTH/375];
    [self.view addSubview:areaInfo];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH/375, 352*HEIGHT/667, 65*WIDTH/375, 15*HEIGHT/667)];
    title2.text = @"防区异常:";
    title2.textColor = [UIColor blackColor];
    //areaInfo.numberOfLines = 0;
    title2.font = [UIFont systemFontOfSize:15*WIDTH/375];
    [self.view addSubview:title2];
    
    UILabel *exceptionLab = [[UILabel alloc]initWithFrame:CGRectMake(40*WIDTH/375, 380*HEIGHT/667, 225*WIDTH/375, 14*HEIGHT/667)];
    [self.view addSubview:exceptionLab];
    exceptionLab.font = [UIFont systemFontOfSize:13*WIDTH/375];
    exceptionLab.textColor = [UIColor grayColor];
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"最近6小时37分内无任何报警"];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1e90ff"] range:NSMakeRange(2, 6)];
    exceptionLab.attributedText = str;
    
    UILabel *checkResultLab = [[UILabel alloc]initWithFrame:CGRectMake(80*WIDTH/375, 460*HEIGHT/667, 260*WIDTH/375, 14*HEIGHT/667)];
    [self.view addSubview:checkResultLab];
    checkResultLab.font = [UIFont systemFontOfSize:13*WIDTH/375];
    checkResultLab.textColor = [UIColor grayColor];
    NSMutableAttributedString *str1 = [[NSMutableAttributedString alloc] initWithString:@"核查结果：保安9527-经视频复核为小猫一只"];
    [str1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"1e90ff"] range:NSMakeRange(0, 4)];
    checkResultLab.attributedText = str1;
    
    UIButton *checkMoreInfo = [[UIButton alloc]initWithFrame:CGRectMake(40*WIDTH/375, 485*HEIGHT/667, 60*WIDTH/375, 14*HEIGHT/667)];
    [self.view addSubview:checkMoreInfo];
    [checkMoreInfo setTitle:@"更早..." forState:UIControlStateNormal];
    [checkMoreInfo setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    checkMoreInfo.titleLabel.font = [UIFont systemFontOfSize :15*WIDTH/375] ;
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH/375, 502*HEIGHT/667, 45*WIDTH/375, 15*HEIGHT/667)];
    title3.text = @"设备:";
    title3.textColor = [UIColor blackColor];
    //areaInfo.numberOfLines = 0;
    title3.font = [UIFont systemFontOfSize:15*WIDTH/375];
    [self.view addSubview:title3];
    
    UILabel *video = [[UILabel alloc]initWithFrame:CGRectMake(20*WIDTH/375, 522*HEIGHT/667, 110*WIDTH/375, 15*WIDTH/375)];
    
    video.text = @"监控摄像：5台";
    video.textColor = [UIColor grayColor];
    //areaInfo.numberOfLines = 0;
    video.font = [UIFont systemFontOfSize:15*WIDTH/375];
    [self.view addSubview:video];
    
    UILabel *chuanGanQi = [[UILabel alloc]initWithFrame:CGRectMake(20*WIDTH/375, 547*HEIGHT/667, 160*WIDTH/375, 15*HEIGHT/667)];
    
    chuanGanQi.text = @"红外传感器：3对";
    chuanGanQi.textColor = [UIColor grayColor];
    //areaInfo.numberOfLines = 0;
    chuanGanQi.font = [UIFont systemFontOfSize:15*WIDTH/375];
    [self.view addSubview:chuanGanQi];
    
    UIButton *dev = [[UIButton alloc]initWithFrame:CGRectMake(150*WIDTH/375, 522*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
    [dev setTitle:@"查看设备" forState:UIControlStateNormal];
    [dev setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [dev setTitleColor:[UIColor colorWithHexString:@"ededed"] forState:UIControlStateSelected];
    dev.userInteractionEnabled = YES;
    [dev addTarget:self action:@selector(jumpToDevList) forControlEvents:UIControlEventTouchUpInside];
    dev.titleLabel.font = [UIFont systemFontOfSize :15*WIDTH/375] ;
        //dev.backgroundColor = [UIColor blueColor];
    [self.view addSubview:dev];
    
    UIButton *videoBtn = [[UIButton alloc]initWithFrame:CGRectMake(220*WIDTH/375, 522*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
    [videoBtn setTitle:@"查看录像" forState:UIControlStateNormal];
    [videoBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [videoBtn setTitleColor:[UIColor colorWithHexString:@"ededed"] forState:UIControlStateSelected];
    [videoBtn addTarget:self action:@selector(goToVideoList) forControlEvents:UIControlEventTouchUpInside];
    videoBtn.userInteractionEnabled = YES;
    videoBtn.titleLabel.font = [UIFont systemFontOfSize :15*WIDTH/375] ;
    //dev.backgroundColor = [UIColor blueColor];
    [self.view addSubview:videoBtn];
    
   
}

-(void)backAction
{
    //NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)jumpToDevList
{

    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DefenceAreaDevListViewController *devList = [mainView instantiateViewControllerWithIdentifier:@"defenceAreaDevNav"];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:devList animated:YES];

}

-(void)goToVideoList
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    VideoListViewController *videoList = [mainView instantiateViewControllerWithIdentifier:@"videoList"];
   // videoList.hidesBottomBarWhenPushed = YES;
     //self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:videoList animated:YES];
    
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
