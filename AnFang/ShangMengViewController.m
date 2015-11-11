//
//  ShangMengViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/10.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "ShangMengViewController.h"
#import "Common.h"

@interface ShangMengViewController ()

@property (nonatomic,strong) UIWebView *webView;
@end

@implementation ShangMengViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT)];
    [self.view addSubview:self.webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://dongyang.dfsh88.com/?did=10070"]];
    [self.webView loadRequest:request];
    
    // Do any additional setup after loading the view.
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
