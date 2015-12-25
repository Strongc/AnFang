//
//  RegisterViewController.m
//  AnBao
//
//  Created by mac   on 15/8/26.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "RegisterViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "WGAPI.h"
#import "SVProgressHUD.h"
#import "CMTool.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"ededed"]];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"dfdfdf"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 15, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"注册";
    title.font = [UIFont boldSystemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [headView addSubview:title];
    [self.view addSubview:headView];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 44)];
    [headView addSubview:navView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 50)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 60, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont fontWithName:@"MicrosoftYaHei" size:28];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    [self ConfigUIView];
    
    // Do any additional setup after loading the view.
}

-(void)ConfigUIView
{

    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, 78, WIDTH, 1)];
    [self.view addSubview:line1];
    line1.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, 117, WIDTH, 1)];
    [self.view addSubview:line2];
    line2.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, 136, WIDTH, 1)];
    [self.view addSubview:line3];
    line3.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    UIView *line4 = [[UIView alloc] initWithFrame:CGRectMake(0, 175, WIDTH, 1)];
    [self.view addSubview:line4];
    line4.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    UIView *line5 = [[UIView alloc] initWithFrame:CGRectMake(0, 214, WIDTH, 1)];
    [self.view addSubview:line5];
    line5.backgroundColor = [UIColor colorWithHexString:@"bababa"];

    UITextField *userNameField = [[UITextField alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(line1.frame), WIDTH-80, 38)];
    [self.view addSubview:userNameField];
    userNameField.placeholder = @"请输入至少四位的英文字母";
    userNameField.backgroundColor = [UIColor whiteColor];
    UILabel *nameTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line1.frame), 80, 38)];
    nameTitle.text = @"用户名";
    nameTitle.textAlignment = NSTextAlignmentCenter;
    nameTitle.font = [UIFont systemFontOfSize:16];
    nameTitle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:nameTitle];
    self.userNameField = userNameField;
    
    UITextField *passwordField = [[UITextField alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(line3.frame), WIDTH-80, 38)];
    [self.view addSubview:passwordField];
    passwordField.secureTextEntry = YES;
    passwordField.backgroundColor = [UIColor whiteColor];
    UILabel *passwordTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line3.frame), 80, 38)];
    passwordTitle.text = @"密码";
    passwordField.placeholder = @"请输入密码，至少6位";
    passwordTitle.textAlignment = NSTextAlignmentCenter;
    passwordTitle.font = [UIFont systemFontOfSize:16];
    passwordTitle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:passwordTitle];
    self.passwordField = passwordField;

    UITextField *ConfirmPasswordField = [[UITextField alloc] initWithFrame:CGRectMake(80, CGRectGetMaxY(line4.frame), WIDTH-80, 38)];
    [self.view addSubview:ConfirmPasswordField];
    ConfirmPasswordField.secureTextEntry = YES;
    ConfirmPasswordField.backgroundColor = [UIColor whiteColor];
    UILabel *ConfirmPasswordTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(line4.frame), 80, 38)];
    ConfirmPasswordTitle.text = @"确认密码";
    ConfirmPasswordField.placeholder = @"请这次输入密码";
    ConfirmPasswordTitle.textAlignment = NSTextAlignmentCenter;
    ConfirmPasswordTitle.font = [UIFont systemFontOfSize:16];
    ConfirmPasswordTitle.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:ConfirmPasswordTitle];
    self.ConfirmPasswordField = ConfirmPasswordField;
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(50, CGRectGetMaxY(line5.frame)+20, WIDTH-100, 40)];
    [self.view addSubview:commitBtn];
    commitBtn.layer.cornerRadius = 5;
    commitBtn.layer.masksToBounds = YES;
    [commitBtn setTitle:@"确认" forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[UIColor colorWithHexString:@"1e90ff"]];
    [commitBtn setTitleColor:[UIColor colorWithHexString:@"ededed"] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor colorWithHexString:@"bababa"] forState:UIControlStateHighlighted];
    [commitBtn addTarget:self action:@selector(registerAction) forControlEvents:UIControlEventTouchUpInside];

    
}

-(void)registerAction
{
    NSString *userName = self.userNameField.text;
    userName = [userName stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *password = self.passwordField.text;
    password = [password stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSString *confirmPassword = self.ConfirmPasswordField.text;
    confirmPassword = [confirmPassword stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    NSDictionary *params = @{@"usr_name":userName,
                             @"usr_pwd":password
                             };
    
    NSString *paramsStr = [CMTool dictionaryToJson:params];
    NSString *str = @"user=";
    NSString *paramStr = [str stringByAppendingString:paramsStr];
    if(![CMTool isConnectionAvailable]){
    
        [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
    }else if ([userName isEqualToString:@""]){
    
        [SVProgressHUD showInfoWithStatus:@"请输入用户名！"];
    }else if ([password isEqualToString:@""] || [confirmPassword isEqualToString:@""]){
    
        [SVProgressHUD showInfoWithStatus:@"请输入密码！"];
    }else if (![password isEqualToString:confirmPassword]){
    
        [SVProgressHUD showInfoWithStatus:@"两次密码不一致！"];
    }else if (password.length < 6 || confirmPassword.length < 6){
    
        [SVProgressHUD showInfoWithStatus:@"密码不能小于6位！"];
    }else{
        [SVProgressHUD showWithStatus:@"加载中..."];
        [WGAPI post:API_USER_REG RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if(data){
                NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
                if(infojson != nil){
                    _message = [infojson objectForKey:@"msg"];
                    
                    if([_message isEqualToString:@"success"]){
                        
                         [self performSelectorOnMainThread:@selector(jumpToLoginView) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
                    }else if([_message isEqualToString:@"exist"]){
                         _message = @"用户名已存在！";
                         [self performSelectorOnMainThread:@selector(errorMessage:) withObject:_message waitUntilDone:YES];
                    }else{
                    
                         _message = @"注册失败！";
                        [self performSelectorOnMainThread:@selector(errorMessage:) withObject:_message waitUntilDone:YES];
                    }
                
                }
            
            }
        }];
    
    }
    
}

-(void)jumpToLoginView
{
    [SVProgressHUD showSuccessWithStatus:@"注册成功！" maskType:SVProgressHUDMaskTypeBlack];
    [self.view endEditing:YES];
    [self performSelector:@selector(backAction) withObject:nil afterDelay:1.0];
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

-(void)backAction
{

    [self.navigationController popViewControllerAnimated:YES];
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
