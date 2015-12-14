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
//#import "RSA.h"
#import "JSONKit.h"
//#import "Security.h"
#import "CMTool.h"
//#import "JKBigInteger.h"
//#import "RsaFactory.h"
#import "CoreArchive.h"
#import "WGAPI.h"
#import "SVProgressHUD.h"
#import "UIImageView+WebCache.h"


@interface ViewController ()
{
    UIButton *loginBtn;
    NSString *token;
    NSString *message;
    NSMutableArray *userInfoArray;
    NSString *userId;
    UIView *inputView;
    //NSString *userName;
   // NSMutableData *infoData;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //infoData= [[NSMutableData alloc] init];
//    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
//    headView.backgroundColor = [UIColor colorWithHexString:@"ce7031"];
//    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
//    title.textAlignment = NSTextAlignmentCenter;
//    title.text = @"登录";
//    title.font = [UIFont fontWithName:@"MicrosoftYaHei" size:24];
//    //title.textColor = [UIColor colorWithHexString:@"ffffff"];
//    [headView addSubview:title];
//    [self.view addSubview:headView];
    //[self.view setBackgroundColor:[UIColor colorWithHexString:@"fafafa"]];
//    UIImageView *backGroundImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT-64)];
//    [self.view addSubview:backGroundImage];
//    backGroundImage.image = [UIImage imageNamed:@"loginBackGround"];
    self.view.backgroundColor = [UIColor colorWithHexString:@"040818"];
    UIImageView *logoImage = [[UIImageView alloc] initWithFrame:CGRectMake((WIDTH-80)/2, 180, 80, 80)];
    [self.view addSubview:logoImage];
    logoImage.image = [UIImage imageNamed:@"logo"];
    
    inputView = [[UIView alloc] initWithFrame:CGRectMake(0, (64+250)*HEIGHT/667, self.view.width, 91)];
    //inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputView];
    
//    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
//    line1.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    //[inputView addSubview:line1];
    
    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 48, 50)];
    [inputView addSubview:nameTitle];
    nameTitle.textAlignment = NSTextAlignmentCenter;
    nameTitle.text = @"账号";
    nameTitle.font = [UIFont systemFontOfSize:20];
    nameTitle.textColor = [UIColor whiteColor];
    
    UIView *line2  = [[UIView alloc] initWithFrame:CGRectMake(35, 50, self.view.width-70, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"323232"];
    [inputView addSubview:line2];
    
    UILabel *passwordTitle = [[UILabel alloc] initWithFrame:CGRectMake(30, 51, 48, 50)];
    [inputView addSubview:passwordTitle];
    passwordTitle.textAlignment = NSTextAlignmentCenter;
    passwordTitle.text = @"密码";
    passwordTitle.font = [UIFont systemFontOfSize:20];
    passwordTitle.textColor = [UIColor whiteColor];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(35,100, self.view.width-70, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"323232"];
    [inputView addSubview:line3];
    
    loginBtn = [[UIButton alloc] initWithFrame:CGRectMake((WIDTH-190)/2, inputView.frame.size.height + inputView.frame.origin.y + 44, 190, 45)];
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, loginBtn.frame.size.width, loginBtn.frame.size.height)];
    title2.text = @"登录";
    title2.textAlignment = NSTextAlignmentCenter;
    title2.textColor = [UIColor whiteColor];
    [loginBtn addSubview:title2];
    [self.view addSubview:loginBtn];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"login.png"] forState:UIControlStateNormal];
    [loginBtn setBackgroundImage:[UIImage imageNamed:@"loginPress.png"] forState:UIControlStateHighlighted];
    [loginBtn addTarget:self action:@selector(initViewController) forControlEvents:UIControlEventTouchUpInside];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(100, 0, inputView.width-70, 50)];
    [inputView addSubview:name];
    name.textColor = [UIColor whiteColor];
    //[name setValue:[UIColor whiteColor] forKeyPath:@"_Label.textColor"];
    name.placeholder = @"手机号/邮箱/用户名";
    
    passWordField = [[UITextField alloc]initWithFrame:CGRectMake(100, 51, inputView.width-70, 50)];
    [inputView addSubview:passWordField];
    passWordField.placeholder = @"请输入密码";
    passWordField.secureTextEntry = YES;
    passWordField.textColor = [UIColor whiteColor];
    //[passWordField setValue:[UIColor whiteColor] forKeyPath:@"_placeholderLabel.textColor"];
    passWordField.keyboardType = UIKeyboardTypeDecimalPad;
    
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyBoardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];

//    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
//    item.title = @"返回";
//    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
//    self.navigationItem.backBarButtonItem = item;
    userInfoArray = [[NSMutableArray alloc]init];
    
    // Do any additional setup after loading the view, typically from a nib.
}

//监听键盘弹出事件
-(void)keyBoardWillChangeFrame:(NSNotification *)noteInfo
{
    
    CGRect rectEnd = [noteInfo.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat keyboardY = rectEnd.origin.y - self.view.frame.size.height;
    CGFloat tranformValue = keyboardY;
    self.view.transform = CGAffineTransformMakeTranslation(0, tranformValue);
    
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
    if(![CMTool isConnectionAvailable]){
        [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
    
    }else if([userName isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入用户名！"];
    
    }else if ([pwd isEqualToString:@""]){
   
        [SVProgressHUD showInfoWithStatus:@"请输入密码！"];
        
    }else{
 
        [SVProgressHUD showWithStatus:@"加载中..."];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"8f8f8f"]];
        [WGAPI post:API_USER_LOGIN RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if(data){
                NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
                NSLog(@"%@",json);
                if(infojson != nil){
                    NSDictionary *messageJson = [infojson objectForKey:@"data"];
                    message = [messageJson objectForKey:@"message"];
                    NSLog(@"%@",message);
                    if([message isEqualToString:@"登陆成功"]){
                        
                        [self performSelectorOnMainThread:@selector(jumpToMainView) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
                        
                    }else {
                        
                        [self performSelectorOnMainThread:@selector(errorMessage:) withObject:message waitUntilDone:YES];
                    }

                }
                
            }else{
               
               [SVProgressHUD  showErrorWithStatus:@"网络异常!"];
               [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"8f8f8f"]];
            }
            
        }];
        
    }
    
}


//登录成功后界面跳转
-(void)jumpToMainView
{

    [SVProgressHUD showSuccessWithStatus:@"登录成功！" maskType:SVProgressHUDMaskTypeBlack];
     NSString *userName = name.text;
    [CoreArchive setStr:userName key:@"name"];
    self.navigationController.navigationBarHidden = YES;
    //[self getUserInfo];
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
    [WGAPI post:API_GET_USEDATA RequestParams:nil FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonStr);
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            // NSDictionary *userInfo = [infojson objectForKey:@"data"];
            NSDictionary *userInfo = [infojson objectForKey:@"data"];
            userId = [userInfo objectForKey:@"usr_id"];
            
               [self performSelectorOnMainThread:@selector(saveUserInfo) withObject:data waitUntilDone:YES];//刷新UI线程

            
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

-(BOOL)prefersStatusBarHidden
{

    return YES;
}

@end
