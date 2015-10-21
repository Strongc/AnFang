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

@interface ViewController ()<NSURLConnectionDataDelegate>
{
    GradientButton *loginBtn;
    NSString *token;
    NSString *message;
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
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

//-(void)setUrl:(NSString *)urlStr
//{
//    
//    NSURL *url = [NSURL URLWithString:urlStr];
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
//                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
//                                                       timeoutInterval:0];
//    NSString *userName = name.text;
//    NSString *pwd = passWordField.text;
// 
//    NSDictionary *params = @{@"usr_name":@"leijiahong",
//                             @"usr_pwd":@"123456"
//                             };
//    
//    NSString *paramsStr = [CMTool dictionaryToJson:params];
//    NSString *str = @"user=";
//    NSString *paramStr = [str stringByAppendingString:paramsStr];
//    
//    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
//    NSData *postData = [paramStr dataUsingEncoding:NSUTF8StringEncoding];
//    
//    [request setHTTPMethod:@"POST"];
//    [request setHTTPBody:postData];
//   // [request setTimeoutInterval:10.0];
//    
//    [NSURLConnection connectionWithRequest:request delegate:self];
//    
//}
//
//
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
//{
//    [infoData appendData:data];
//    
//}
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection
//{
//    connection = nil;
//    //NSMutableArray *userInfoArray = [[NSMutableArray alloc]init];
//    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:infoData options:NSJSONReadingMutableLeaves error:nil];
//    // NSLog(@"%@",json);
//    NSDictionary *userInfo = [json objectForKey:@"data"];
//    message = [userInfo objectForKey:@"message"];
//    if([message isEqualToString:@"登录成功"]){
//    
//        [SVProgressHUD showInfoWithStatus:@"登录成功"];
//        self.navigationController.navigationBarHidden = YES;
//        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        MenuTabBarViewController *menuTab = [mainView instantiateViewControllerWithIdentifier:@"menuTabBar"];
//        [self.navigationController pushViewController:menuTab animated:YES];
//        
//    }else{
//    
//    
//        [SVProgressHUD showInfoWithStatus:@"用户名不存在"];
//    }
//        
//   
//    
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
//{
//    
//    
//}


-(void)initViewController
{
    
    NSString *urlStr=[NSString stringWithFormat:@"http://192.168.0.40:8080/platform/user/login"];
    NSString *userName = name.text;
    NSString *pwd = passWordField.text;
    
    NSDictionary *params = @{@"usr_name":userName,
                                 @"usr_pwd":pwd
                                 };
    
    NSString *paramsStr = [CMTool dictionaryToJson:params];
    NSString *str = @"user=";
    NSString *paramStr = [str stringByAppendingString:paramsStr];
    
    if(![CMTool isConnectionAvailable]){
            [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
    
    }else if([userName isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入用户名！"];
    
    }else if ([pwd isEqualToString:@""]){
   
         [SVProgressHUD showInfoWithStatus:@"请输入密码！"];
        
    }else{
        
        
        [WGAPI post:urlStr RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if(data){
            
                NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
                NSLog(@"%@",json);
                NSDictionary *messageJson = [infojson objectForKey:@"data"];
                message = [messageJson objectForKey:@"message"];
                NSLog(@"%@",message);
                if([message isEqualToString:@"登录成功"]){
                
                     [self performSelectorOnMainThread:@selector(jumpToMainView) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
                    
                }else {
                
                    [self performSelectorOnMainThread:@selector(errorMessage:) withObject:message waitUntilDone:YES];
                }
                
            }
            
        }];
        
    }
    
}

//登录成功后界面跳转
-(void)jumpToMainView
{
    
    [SVProgressHUD showInfoWithStatus:@"登录成功"];
    self.navigationController.navigationBarHidden = YES;
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuTabBarViewController *menuTab = [mainView instantiateViewControllerWithIdentifier:@"menuTabBar"];
    [self.navigationController pushViewController:menuTab animated:YES];

}

//提示错误信息
-(void)errorMessage:(NSString *)str
{

     [SVProgressHUD showInfoWithStatus:str];

}

-(void)generateKeyPair:(NSUInteger)keySize
{
    
   // KeyPairGenerator
    OSStatus sanityCheck = noErr;
    publicKey = NULL;
    privateKey = NULL;

    NSMutableDictionary * privateKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * publicKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * keyPairAttr = [[NSMutableDictionary alloc] init];
    
    [keyPairAttr setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [keyPairAttr setObject:[NSNumber numberWithUnsignedInteger:keySize] forKey:(__bridge id)kSecAttrKeySizeInBits];
    
    [privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrIsPermanent];
    [privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrCanEncrypt];
    [privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrCanDecrypt];
    [privateKeyAttr setObject:privateTag forKey:(__bridge id)kSecAttrApplicationTag];

    [publicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrIsPermanent];
    [publicKeyAttr setObject:publicTag forKey:(__bridge id)kSecAttrApplicationTag];

    [keyPairAttr setObject:privateKeyAttr forKey:(__bridge id)kSecPrivateKeyAttrs];
    [keyPairAttr setObject:publicKeyAttr forKey:(__bridge id)kSecPublicKeyAttrs];
    
    sanityCheck = SecKeyGeneratePair((__bridge CFDictionaryRef)keyPairAttr, &publicKey, &privateKey);
   // LOGGING_FACILITY( sanityCheck == noErr && publicKeyRef != NULL && privateKeyRef != NULL, @"Something really bad went wrong with generating the key pair.");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
