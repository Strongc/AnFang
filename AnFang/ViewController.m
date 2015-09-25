//
//  ViewController.m
//  AnFang
//
//  Created by mac   on 15/9/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Extensions.h"
#import "UIView+KGViewExtend.h"
#import "Common.h"
#import "GradientButton.h"
#import "MenuTabBarViewController.h"


@interface ViewController ()
{
    GradientButton *loginBtn;

}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"1e90ff"]];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, WIDTH, 35)];
    //self.navigationController.navigationBar.b
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 50)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"登录";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    //[self.view addSubview:headView];
    
    UIButton *regBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 15, 40, 40)];
    [self.view addSubview:regBtn];
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    regBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    regBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[regBtn addTarget:self action:@selector(gotoRegisterView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"ededed"]];
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, (headView.bottom+20)*WIDTH/375, self.view.width, 100*WIDTH/375)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputView];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [inputView addSubview:line1];
    
    UIView *line2  = [[UIView alloc] initWithFrame:CGRectMake(10*WIDTH/375, 50*WIDTH/375, self.view.width-20*WIDTH/375, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [inputView addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0,100*WIDTH/375, self.view.width, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [inputView addSubview:line3];
    
    loginBtn = [[GradientButton alloc] initWithFrame:CGRectMake(15*WIDTH/375, 220*WIDTH/375, self.view.width-30*WIDTH/375, 40*WIDTH/375)];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(150*WIDTH/375, 0, 40*WIDTH/375, 40*WIDTH/375)];
    title2.text = @"登录";
    title2.textColor = [UIColor whiteColor];
    [loginBtn addSubview:title2];
    [loginBtn useGreenConfirmStyle];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(initViewController) forControlEvents:UIControlEventTouchUpInside];
    
    UITextField *name = [[UITextField alloc] initWithFrame:CGRectMake(10*WIDTH/375, 5*WIDTH/375, self.view.width-20*WIDTH/375, 40*WIDTH/375)];
    [inputView addSubview:name];
    name.placeholder = @"手机号／邮箱／用户名";
    
    UITextField *passWordField = [[UITextField alloc]initWithFrame:CGRectMake(10*WIDTH/375, 50*WIDTH/375, self.view.width-20*WIDTH/375, 40*WIDTH/375)];
    [inputView addSubview:passWordField];
    passWordField.placeholder = @"密码";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = item;

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initViewController
{
    
    self.navigationController.navigationBarHidden = YES;
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuTabBarViewController *menuTab = [mainView instantiateViewControllerWithIdentifier:@"menuTabBar"];

    [self.navigationController pushViewController:menuTab animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
