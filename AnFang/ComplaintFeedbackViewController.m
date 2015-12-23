//
//  ComplaintFeedbackViewController.m
//  AnFang
//
//  Created by MyOS on 15/12/23.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "ComplaintFeedbackViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "WGAPI.h"
#import "CoreArchive.h"
#import "CMTool.h"
#import "SVProgressHUD.h"

@interface ComplaintFeedbackViewController ()

@end

@implementation ComplaintFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"222121"];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [headView addSubview:navView];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"意见反馈";
    title.font = [UIFont systemFontOfSize:20];
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
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"ededed"]];
    
    UITextView *messageText = [[UITextView alloc] initWithFrame:CGRectMake(20, 15+64, WIDTH-40, 125)];
    [self.view addSubview:messageText];
    messageText.backgroundColor = [UIColor whiteColor];
    messageText.layer.cornerRadius = 6;
    messageText.layer.masksToBounds = YES;
    messageText.layer.borderWidth = 2;
    messageText.layer.borderColor = [[UIColor colorWithHexString:@"bababa"] CGColor];
    self.textView = messageText;
    
    UIButton *commitBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, CGRectGetMaxY(messageText.frame)+10, WIDTH-120, 40)];
    [self.view addSubview:commitBtn];
    commitBtn.layer.cornerRadius = 5;
    commitBtn.layer.masksToBounds = YES;
    commitBtn.backgroundColor = [UIColor colorWithHexString:@"1e90ff"];
    [commitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor colorWithHexString:@"ededed"] forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor colorWithHexString:@"bababa"] forState:UIControlStateHighlighted];
    self.commitBtn = commitBtn;
    [self.commitBtn addTarget:self action:@selector(commitCommentContent) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)commitCommentContent
{

    NSString *userId = [CoreArchive strForKey:@"userId"];
    NSString *title = @"意见反馈";
    NSString *content = self.textView.text;
    NSDictionary *params = @{@"usr_id":userId,
                             @"title":title,
                             @"content":content
                             };
    
    NSString *paramsStr = [CMTool dictionaryToJson:params];
    NSString *str = @"comment=";
    NSString *paramStr = [str stringByAppendingString:paramsStr];
    [self.view endEditing:YES];
    if(![CMTool isConnectionAvailable]){
        
        [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
    }else if ([content isEqualToString:@""]){
        
        [SVProgressHUD showInfoWithStatus:@"请输入评论的内容！"];
    }else{
        
        [SVProgressHUD showWithStatus:@"加载中..."];
        [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"8f8f8f"]];
        [WGAPI post:API_ADDCOMMENT RequestParams:paramStr FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            if(data){
                NSString *json =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:json];
                NSLog(@"%@",json);
                if(infojson != nil){
                    NSDictionary *messageJson = [infojson objectForKey:@"data"];
                    NSString *commentId = [messageJson objectForKey:@"comment_id"];
                    NSLog(@"%@",commentId);
                    if(![commentId isEqualToString:@""]){
                        
                        [self performSelectorOnMainThread:@selector(showRequestMessage) withObject:data waitUntilDone:YES];//通知主线程刷新(UI)
                        
                    }
                }
                
            }else{
                
                [SVProgressHUD  showErrorWithStatus:@"网络异常!"];
                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"8f8f8f"]];
            }
            
        }];
        
    }
}

-(void)showRequestMessage
{
    
   [SVProgressHUD showSuccessWithStatus:@"发送成功！" maskType:SVProgressHUDMaskTypeBlack];
   self.textView.text = nil;
   

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
