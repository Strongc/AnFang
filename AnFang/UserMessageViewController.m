//
//  UserMessageViewController.m
//  AnBao
//
//  Created by mac   on 15/9/10.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "UserMessageViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@interface UserMessageViewController (){

     UILabel *alertLab;
}

@end

@implementation UserMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, WIDTH, 15*HEIGHT/667)];
    [self.view addSubview:alertLab];
    alertLab.text = @"暂无内容！";
    alertLab.textAlignment = NSTextAlignmentCenter;
    self.view.backgroundColor = [UIColor colorWithHexString:@"efefef"];

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
