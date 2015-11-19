//
//  ShangMengViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/10.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "ShangMengViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@interface ShangMengViewController ()

@property (nonatomic,strong) UIWebView *webView;
@property (nonatomic,strong) UIActivityIndicatorView *activityView;
@end

@implementation ShangMengViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"ce7031"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"商盟";
    title.font = [UIFont fontWithName:@"MicrosoftYaHei" size:28];
    [headView addSubview:title];
    [self.view addSubview:headView];

    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT)];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((WIDTH-50)/2, (HEIGHT-64-50)/2, 50, 50)];
    [self.view addSubview:self.activityView];
    
    // Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dongyang.dfsh88.com/?did=10070"]];
    [self.webView loadRequest:request];

}

-(void)webViewDidStartLoad:(UIWebView *)webView
{

    [self.activityView startAnimating];
}

-(void)webViewDidFinishLoad:(UIWebView *)webView
{

    [self.activityView stopAnimating];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityView stopAnimating];

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
