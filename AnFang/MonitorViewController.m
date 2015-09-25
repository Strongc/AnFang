//
//  MonitorViewController.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MonitorViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "MonitorInfoTableViewCell.h"
#import "DefenceAreaViewController.h"

@interface MonitorViewController ()
{
    
    UITableView *monitorTable;
   
    NSMutableArray *defenceAreaName;
    NSMutableArray *defenceAreaInfo;
    NSMutableArray *defenceAreaImage;

}

@end

@implementation MonitorViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;

}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    self.view.backgroundColor = [UIColor whiteColor];
    [self ConfigControl];
    
    UINavigationBar *bar = [self.navigationController navigationBar];
    CGFloat navBarHeight = 44*HEIGHT/667;
    CGRect rect = CGRectMake(0, 0, WIDTH, navBarHeight);
    [bar setFrame:rect];
    
    defenceAreaName = [[NSMutableArray alloc]initWithObjects:@"防区001: 华业大厦广场北区", @"防区002: 华业大厦广场南区",@"防区003: 华业大厦广场东区",@"防区004: 华业大厦广场西区",nil];
    
    defenceAreaInfo = [[NSMutableArray alloc]initWithObjects:@"   车位监控3个，大楼摄像机1个，北墙西墙红外探头2对...",@"   车位监控2个，大楼摄像机1个，北墙西墙红外探头3对...",@"   车位监控1个，大楼摄像机1个，北墙西墙红外探头4对...",@"   车位监控3个，大楼摄像机3个，北墙西墙红外探头2对...", nil];

    
    // Do any additional setup after loading the view.
}

-(void)ConfigControl
{

    UIImageView *locationImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*WIDTH/375, 20*HEIGHT/667, 110*WIDTH/375, 110*HEIGHT/667)];
    locationImage.image = [UIImage imageNamed:@"location.png"];
    [self.view addSubview:locationImage];
    
    UILabel *locationName = [[UILabel alloc]initWithFrame:CGRectMake(200*WIDTH/375, 10*HEIGHT/667, 120*WIDTH/375, 20*HEIGHT/667)];
    locationName.textColor = [UIColor blackColor];
    locationName.textAlignment = NSTextAlignmentLeft;
    locationName.text = @"华业大厦";
    locationName.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    [self.view addSubview:locationName];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(150*WIDTH/375, 40*HEIGHT/667, 45*WIDTH/375, 15*HEIGHT/667)];
    title1.text = @"地址:";
    title1.textAlignment = NSTextAlignmentCenter;
    title1.textColor = [UIColor blackColor];
    title1.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [self.view addSubview:title1];
    
    UILabel *locationLab = [[UILabel alloc]initWithFrame:CGRectMake(170*WIDTH/375, 65*HEIGHT/667, 180*WIDTH/375, 15*HEIGHT/667)];
    locationLab.text = @"杭州市滨江区建业路511号";
    locationLab.textAlignment = NSTextAlignmentCenter;
    locationLab.textColor = [UIColor grayColor];
    locationLab.font = [UIFont boldSystemFontOfSize:13*WIDTH/375];
    [self.view addSubview:locationLab];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(150*WIDTH/375, 85*HEIGHT/667, 45*WIDTH/375, 15*HEIGHT/667)];
    title2.text = @"公司:";
    title2.textAlignment = NSTextAlignmentCenter;
    title2.textColor = [UIColor blackColor];
    title2.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [self.view addSubview:title2];
    
    UILabel *companyLab = [[UILabel alloc]initWithFrame:CGRectMake(170*WIDTH/375, 105*HEIGHT/667, 180*WIDTH/375, 15*HEIGHT/667)];
    companyLab.text = @"杭州润宇物业管理有限公司";
    companyLab.textAlignment = NSTextAlignmentCenter;
    companyLab.textColor = [UIColor grayColor];
    companyLab.font = [UIFont boldSystemFontOfSize:13*WIDTH/375];
    [self.view addSubview:companyLab];
    
    UILabel *title3 = [[UILabel alloc]initWithFrame:CGRectMake(130*WIDTH/375, 140*HEIGHT/667, 70*WIDTH/375, 15*HEIGHT/667)];
    title3.text = @"主机状态:";
    title3.textAlignment = NSTextAlignmentCenter;
    title3.textColor = [UIColor blackColor];
    title3.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    [self.view addSubview:title3];

    UILabel *stateLab = [[UILabel alloc]initWithFrame:CGRectMake(215*WIDTH/375, 141*HEIGHT/667, 50*WIDTH/375, 15*HEIGHT/667)];
    stateLab.text = @"已部防";
    stateLab.textAlignment = NSTextAlignmentCenter;
    stateLab.textColor = [UIColor greenColor];
    stateLab.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [self.view addSubview:stateLab];
    
    UIButton *refreshBtn = [[UIButton alloc]initWithFrame:CGRectMake(270*WIDTH/375, 140*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
    [self.view addSubview:refreshBtn];
    refreshBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14*WIDTH/375];
    [refreshBtn setTitle:@"刷新状态" forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [refreshBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    
    UIButton *bufangBtn = [[UIButton alloc]initWithFrame:CGRectMake(40*WIDTH/375, 175*HEIGHT/667, 110*WIDTH/375, 40*HEIGHT/667)];
    [self.view addSubview:bufangBtn];
    bufangBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    [bufangBtn setTitle:@"布 防" forState:UIControlStateNormal];
    [bufangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [bufangBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    bufangBtn.backgroundColor = [UIColor greenColor];
    bufangBtn.layer.borderColor = [[UIColor grayColor]CGColor];
    bufangBtn.layer.borderWidth = 1.0;
    
    UIButton *chefangBtn = [[UIButton alloc]initWithFrame:CGRectMake(220*WIDTH/375, 175*HEIGHT/667, 110*WIDTH/375, 40*HEIGHT/667)];
    [self.view addSubview:chefangBtn];
    chefangBtn.titleLabel.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    [chefangBtn setTitle:@"撤 防" forState:UIControlStateNormal];
    [chefangBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [chefangBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    chefangBtn.backgroundColor = [UIColor redColor];
    chefangBtn.layer.borderColor = [[UIColor grayColor]CGColor];
    chefangBtn.layer.borderWidth = 1.0;
    
    UIView *blueLine = [[UIView alloc]initWithFrame:CGRectMake(0, 225*HEIGHT/667, WIDTH, 3.0)];
    [self.view addSubview:blueLine];
    blueLine.backgroundColor = [UIColor colorWithHexString:@"6495ED"];
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 228*HEIGHT/667, WIDTH, 40*HEIGHT/667)];
    [self.view addSubview:titleView];
    titleView.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    UIView *grayLine = [[UIView alloc]initWithFrame:CGRectMake(0, 268*HEIGHT/667, WIDTH, 3.0)];
    [self.view addSubview:grayLine];
    grayLine.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    
    UILabel *title5 = [[UILabel alloc]initWithFrame:CGRectMake(15*WIDTH/375, 10*HEIGHT/667, 80*WIDTH/375, 20*HEIGHT/667)];
    [titleView addSubview:title5];
    title5.text = @"监控列表";
    title5.textColor = [UIColor blackColor];
    title5.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    
    
    monitorTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 271*HEIGHT/667, WIDTH, HEIGHT) style:UITableViewStylePlain];
    monitorTable.delegate = self;
    monitorTable.dataSource = self;
    monitorTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    monitorTable.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [self.view addSubview:monitorTable];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return defenceAreaInfo.count;

}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentify = @"cell";
    MonitorInfoTableViewCell *cell = (MonitorInfoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if(cell == nil){
        
        cell = [[MonitorInfoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
      
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    }
    cell.areaName.text = [defenceAreaName objectAtIndex:indexPath.row];
    cell.areaDetailInfo.text = [defenceAreaInfo objectAtIndex:indexPath.row];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 80.0*WIDTH/375;

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     DefenceAreaViewController *defenceArea = [mainView instantiateViewControllerWithIdentifier:@"defenceArea"];
     //self.navigationController.navigationBarHidden = NO;
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = item;
    defenceArea.defenceAreaName = [defenceAreaName objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:defenceArea animated:YES];

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
