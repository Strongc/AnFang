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
    
    self.view.backgroundColor = [UIColor colorWithHexString:@"fafafa"];
    NSString *str = self.messageId;
    NSLog(@"%@",str);
    
    self.textLab = [[UITextView alloc] initWithFrame:CGRectMake(5, 20, WIDTH-10, HEIGHT-70)];
    [self.view addSubview:self.textLab];
    self.textLab.editable = NO;
    self.textLab.font = [UIFont systemFontOfSize:14];
    self.textLab.backgroundColor = [UIColor colorWithHexString:@"ffffff"];
    [self getMessageById];
    // Do any additional setup after loading the view.
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
    self.textLab.text = self.message;

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
