//
//  AlarmMessageDetailViewController.m
//  AnBao
//
//  Created by mac   on 15/9/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AlarmMessageDetailViewController.h"

@interface AlarmMessageDetailViewController ()

@end

@implementation AlarmMessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *str = self.messageId;
    NSLog(@"%@",str);
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
