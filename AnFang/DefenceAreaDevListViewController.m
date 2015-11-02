//
//  DefenceAreaDevListViewController.m
//  AnBao
//
//  Created by mac   on 15/9/14.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "DefenceAreaDevListViewController.h"
#include "Common.h"
#import "UIColor+Extensions.h"

@interface DefenceAreaDevListViewController ()
{

    UITableView *devTable;
    NSMutableArray *devImage;
    NSMutableArray *deviceName;
    NSMutableArray *deviceState;

}

@end

@implementation DefenceAreaDevListViewController


-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(5*WIDTH/375, 80*HEIGHT/667, 161*WIDTH/375, 16*HEIGHT/667)];
    title.textColor = [UIColor blackColor];
    title.text = @"华业大厦广场北区";
    title.font = [UIFont systemFontOfSize:16*WIDTH/375];
    [self.view addSubview:title];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    
    devTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 100*HEIGHT/667, WIDTH, HEIGHT) style:UITableViewStylePlain];
    devTable.delegate = self;
    devTable.dataSource = self;
    devTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    devTable.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    // monitorTable.separatorStyle = NO;
    [self.view addSubview:devTable];
    
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64*HEIGHT/667)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *headTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    headTitle.textAlignment = NSTextAlignmentCenter;
    headTitle.text = @"防区设备列表";
    headTitle.textColor = [UIColor whiteColor];
    [headView addSubview:headTitle];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH/375, 7*HEIGHT/667, 32, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont systemFontOfSize:16];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5*HEIGHT/667, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    // backBtn.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:backBtn];
    
    deviceName = [[NSMutableArray alloc]initWithObjects:@"大楼西侧朝南监控", @"大楼西侧朝北监控",@"大楼东侧朝南监控",@"大楼北侧朝南监控",nil];
    deviceState = [[NSMutableArray alloc]initWithObjects:@"已关机", @"工作正常",@"工作正常",@"无法连接",nil];

    // Do any additional setup after loading the view.
}

-(void)backAction
{
    NSLog(@"%@",@"ddddd");
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return deviceState.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentify = @"cell";
    DefenceAreaDevTableViewCell *cell = (DefenceAreaDevTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if(cell == nil){
        
        cell = [[DefenceAreaDevTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    cell.devName.text = [deviceName objectAtIndex:indexPath.row];
    cell.devState.text = [deviceState objectAtIndex:indexPath.row];
    if([cell.devState.text isEqualToString:@"已关机"]){
        
        cell.devState.textColor = [UIColor grayColor];
    }else if ([cell.devState.text isEqualToString:@"工作正常"]){
    
        cell.devState.textColor = [UIColor greenColor];
    }else if([cell.devState.text isEqualToString:@"无法连接"]){
    
        cell.devState.textColor = [UIColor redColor];
    }
    
    return cell;

}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65.0*HEIGHT/667;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DeviceManagerViewController *defenceArea = [mainView instantiateViewControllerWithIdentifier:@"deviceManagerId"];
    self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = item;
    defenceArea.deviceName = [deviceName objectAtIndex:indexPath.row];
    defenceArea.deviceState = [deviceState objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:defenceArea animated:YES];
    
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
