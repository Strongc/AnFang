//
//  AlarmMessageDetailViewController.m
//  AnBao
//
//  Created by mac   on 15/9/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AlarmMessageDetailViewController.h"
#import "Common.h"
#import "WGAPI.h"
#import "CMTool.h"
#import "SVProgressHUD.h"
#import "UIColor+Extensions.h"

@interface AlarmMessageDetailViewController ()
@property (nonatomic,strong) UITextView *textLab;
@property (nonatomic,copy) NSString *message;
@end

@implementation AlarmMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [headView addSubview:navView];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"资讯详情";
    title.font = [UIFont boldSystemFontOfSize:20];
    title.textColor = [UIColor colorWithHexString:@"ce7031"];
    [navView addSubview:title];
    [self.view addSubview:headView];
    
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

    self.view.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    NSString *str = self.messageId;
    NSLog(@"%@",str);
    
    self.textLab = [[UITextView alloc] initWithFrame:CGRectMake(0, 84, WIDTH, HEIGHT-90)];
    [self.view addSubview:self.textLab];
    self.textLab.editable = NO;
   
    self.textLab.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self getMessageById];
    // Do any additional setup after loading the view.
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getMessageById
{
    NSString *msgId = self.messageId;
    NSString *param = [@"id=" stringByAppendingString:msgId];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [WGAPI post:API_GETMESSAGEBYID RequestParams:param FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *infojson = [CMTool strDic:jsonStr];
            if(infojson != nil){
                NSDictionary *json = [infojson objectForKey:@"data"];
                NSDictionary *contentJson = [json objectForKey:@"result"];
                self.message = [contentJson objectForKey:@"msg_content"];
                
            
            }
            
             [self performSelectorOnMainThread:@selector(refreshData) withObject:data waitUntilDone:YES];
        
        }
    }];


}

-(void)refreshData
{
    [SVProgressHUD showSuccessWithStatus:@"加载完成！" maskType:SVProgressHUDMaskTypeBlack];
    self.textLab.font = [UIFont fontWithName:@"Helvetica" size:18];
    self.textLab.text = self.message;
    [self.view addSubview:self.textLab];

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
