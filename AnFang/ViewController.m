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
#import "RSA.h"
#import "JSONKit.h"
#import "Security.h"
#import "Base64.h"
#import "CMTool.h"
#import "CMTool.h"
#import "JKBigInteger.h"
#import "RsaFactory.h"
#import <AFNetworking/AFNetworking.h>
#import "CoreArchive.h"
#import "WGAPI.h"
#import "SVProgressHUD.h"


@interface ViewController ()
{
    GradientButton *loginBtn;
    NSString *token;
    NSString *message;
    NSMutableArray *userInfoArray;
    NSString *userId;
   // NSMutableData *infoData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //infoData= [[NSMutableData alloc] init];
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"1e90ff"]];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, WIDTH, 35)];
   
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60*HEIGHT/667)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 50*HEIGHT/667)];
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
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, (headView.bottom+20)*WIDTH/375, self.view.width, 100*HEIGHT/667)];
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
    
    loginBtn = [[GradientButton alloc] initWithFrame:CGRectMake(15*WIDTH/375, 220*WIDTH/375, self.view.width-30*WIDTH/375, 40*HEIGHT/667)];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(150*WIDTH/375, 0, 40*WIDTH/375, 40*HEIGHT/667)];
    title2.text = @"登录";
    title2.textColor = [UIColor whiteColor];
    [loginBtn addSubview:title2];
    [loginBtn useGreenConfirmStyle];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(initViewController) forControlEvents:UIControlEventTouchUpInside];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(10*WIDTH/375, 5*WIDTH/375, self.view.width-20*WIDTH/375, 40*HEIGHT/667)];
    [inputView addSubview:name];
    name.placeholder = @"手机号／邮箱／用户名";
    
    passWordField = [[UITextField alloc]initWithFrame:CGRectMake(10*WIDTH/375, 50*WIDTH/375, self.view.width-20*WIDTH/375, 40*HEIGHT/667)];
    [inputView addSubview:passWordField];
    passWordField.placeholder = @"密码";
    passWordField.secureTextEntry = YES;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    self.navigationItem.backBarButtonItem = item;
    userInfoArray = [[NSMutableArray alloc]init];
   

    // Do any additional setup after loading the view, typically from a nib.
}


-(void)initViewController
{
    
    //NSString *urlStr=[NSString stringWithFormat:@"http://192.168.0.42:8080/platform/user/login"];
    NSString *userName = name.text;
    NSString *pwd = passWordField.text;
    
    NSDictionary *params = @{@"usr_name":userName,
                                 @"usr_pwd":pwd
                                 };
    
    NSString *paramsStr = [CMTool dictionaryToJson:params];
    NSString *str = @"user=";
    NSString *paramStr = [str stringByAppendingString:paramsStr];
    
    //[self jumpToMainView];
//    if(![CMTool isConnectionAvailable]){
//        [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
//    
//    }else if([userName isEqualToString:@""]){
//        
//        [SVProgressHUD showInfoWithStatus:@"请输入用户名！"];
//    
//    }else if ([pwd isEqualToString:@""]){
//   
//        [SVProgressHUD showInfoWithStatus:@"请输入密码！"];
//        
//    }else{
// 
//        [SVProgressHUD showWithStatus:@"加载中..."];
//        [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"8f8f8f"]];
//        [WGAPI post:API_USER_LOGIN RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
//            
//            if(data){
//                
//                //[self performSelectorOnMainThread:@selector(hideProgressHUD) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
//                NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//                NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
//                NSLog(@"%@",json);
//                NSDictionary *messageJson = [infojson objectForKey:@"data"];
//                message = [messageJson objectForKey:@"message"];
//                NSLog(@"%@",message);
//                if([message isEqualToString:@"登陆成功"]){
//                
//                     [self performSelectorOnMainThread:@selector(jumpToMainView) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
//                    
//                    
//                    
//                }else {
//                
//                    [self performSelectorOnMainThread:@selector(errorMessage:) withObject:message waitUntilDone:YES];
//                }
//                
//            }else{
//               
//               [SVProgressHUD  showErrorWithStatus:@"网络异常!"];
//               [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"8f8f8f"]];
//            }
//            
//        }];
//        
//    }
    
}


//登录成功后界面跳转
-(void)jumpToMainView
{

    [SVProgressHUD showSuccessWithStatus:@"登录成功！" maskType:SVProgressHUDMaskTypeBlack];
     NSString *userName = name.text;
    [CoreArchive setStr:userName key:@"name"];
    self.navigationController.navigationBarHidden = YES;
    [self getUserInfo];
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuTabBarViewController *menuTab = [mainView instantiateViewControllerWithIdentifier:@"menuTabBar"];
    [self.navigationController pushViewController:menuTab animated:YES];
    
    //[[NSNotificationCenter defaultCenter] postNotificationName:@"getUserInfo" object:nil];
    
}
-(void)getUserInfo
{
    
    NSString *userName = [CoreArchive strForKey:@"name"];
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"2"};
    NSDictionary *pageInfo = @{@"page":page,@"usr_name":userName};
    NSString *pageStr = [pageInfo JSONString];
    NSString *userInfoData = [@"user=" stringByAppendingString:pageStr];
    // NSString *urlStr=[NSString stringWithFormat:@"http://192.168.0.42:8080/platform/user/page"];
    //userInfo = [WGAPI httpAsynchronousRequestUrl:urlStr postStr:userInfoData];
    [WGAPI post:API_GET_USERINFO RequestParams:userInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonStr);
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            // NSDictionary *userInfo = [infojson objectForKey:@"data"];
            userInfoArray = [infojson objectForKey:@"datas"];
            
            if(userInfoArray.count > 0){
                
                NSDictionary *userMessage = userInfoArray[0];
                //nickName = [userMessage objectForKey:@"usr_name"];
                userId = [userMessage objectForKey:@"usr_id"];
                
                [self performSelectorOnMainThread:@selector(saveUserInfo) withObject:data waitUntilDone:YES];//刷新UI线程
            }
            
            
        }
        
        
    }];
    
}

-(void)saveUserInfo
{

     [CoreArchive setStr:userId key:@"userId"];

}

//提示错误信息
-(void)errorMessage:(NSString *)str
{

     [SVProgressHUD  showErrorWithStatus:str];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
