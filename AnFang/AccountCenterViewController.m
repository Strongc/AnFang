//
//  AccountCenterViewController.m
//  AnBao
//
//  Created by mac   on 15/9/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AccountCenterViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "RechargeViewController.h"
#import "MenuSelectViewController.h"

@interface AccountCenterViewController ()
{

    UITableView *accountOptionTable;
    NSMutableArray *accountOptionName;

}

@end

@implementation AccountCenterViewController

-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
   // self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ConfigControl];
    // Do any additional setup after loading the view.
}

-(void)ConfigControl
{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"ce7031"];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [headView addSubview:navView];

    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"账户中心";
    title.font = [UIFont fontWithName:@"MicrosoftYaHei" size:28];
    [navView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 10, 80, 50)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(5, 7, 60, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont fontWithName:@"MicrosoftYaHei" size:28];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [navView addSubview:backBtn];
    
    UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WIDTH, 130*HEIGHT/667)];
    backgroundView.backgroundColor = [UIColor colorWithHexString:@"ee9a49"];
    [self.view addSubview:backgroundView];
    
    UILabel *title1 = [[UILabel alloc]initWithFrame:CGRectMake(90*WIDTH/375, 30*HEIGHT/667, 140*WIDTH/375, 20*HEIGHT/667)];
    title1.text = @"当前帐户余额:";
    title1.textAlignment = NSTextAlignmentLeft;
    title1.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    title1.textColor = [UIColor whiteColor];
    [backgroundView addSubview:title1];
    
    UILabel *account = [[UILabel alloc]initWithFrame:CGRectMake(230*WIDTH/375, 30*HEIGHT/667, 80*WIDTH/375, 20*HEIGHT/667)];
    account.text = @"¥ 79";
    account.textAlignment = NSTextAlignmentLeft;
    account.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
    account.textColor = [UIColor whiteColor];
    [backgroundView addSubview:account];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(25*WIDTH/375, 80*HEIGHT/667, 115*WIDTH/375, 20*HEIGHT/667)];
    title2.text = @"当前服务类型:";
    title2.font = [UIFont italicSystemFontOfSize:15*WIDTH/375];
    title2.textColor = [UIColor purpleColor];
    [backgroundView addSubview:title2];
    
    UILabel *setMeal = [[UILabel alloc]initWithFrame:CGRectMake(125*WIDTH/375, 80*HEIGHT/667, 100*WIDTH/375, 20*HEIGHT/667)];
    setMeal.text = @"专业版套餐";
    setMeal.font = [UIFont italicSystemFontOfSize:15*WIDTH/375];
    setMeal.textColor = [UIColor blackColor];
    [backgroundView addSubview:setMeal];
    
    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(210*WIDTH/375, 80*HEIGHT/667, 50*WIDTH/375, 20*HEIGHT/667)];
    timeLab.text = @"一季度";
    timeLab.font = [UIFont italicSystemFontOfSize:15*WIDTH/375];
    timeLab.textColor = [UIColor blackColor];
    [backgroundView addSubview:timeLab];
    
    UILabel *timeOdd = [[UILabel alloc]initWithFrame:CGRectMake(260*WIDTH/375, 80*HEIGHT/667, 144*WIDTH/375, 20*HEIGHT/667)];
    timeOdd.text = @"(余15天7小时)";
    timeOdd.font = [UIFont italicSystemFontOfSize:15*WIDTH/375];
    timeOdd.textColor = [UIColor redColor];
    [backgroundView addSubview:timeOdd];

    accountOptionTable = [[UITableView alloc] initWithFrame:CGRectMake(0,195*HEIGHT/667, WIDTH, 151*HEIGHT/667) style:UITableViewStylePlain];
    accountOptionTable.delegate = self;
    accountOptionTable.dataSource = self;
    accountOptionTable.separatorStyle = UITableViewCellAccessoryNone;
    accountOptionTable.scrollEnabled = NO;
    
    [self.view addSubview:accountOptionTable];
    
    accountOptionName = [[NSMutableArray alloc]initWithObjects:@"套餐选购", @"账户充值",@"查看充值记录",nil];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)backAction
{

    [self.navigationController popViewControllerAnimated:YES];

}

#pragma mark UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{


    return 3;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *reuseIdentify = @"cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentify];
        
       // cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 50*HEIGHT/667, WIDTH, 1)];
    line.backgroundColor = [UIColor colorWithHexString:@"bababa"];
    [cell.contentView addSubview:line];
    
    cell.textLabel.text = [accountOptionName objectAtIndex:indexPath.row];
    //cell.areaDetailInfo.text = [defenceAreaInfo objectAtIndex:indexPath.row];
    return cell;

}

#pragma mark UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 50.0*HEIGHT/667;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
    if(indexPath.row == 1){
    
        [self jumpToRechargeView];
    
    }else if (indexPath.row == 0){
    
    
        [self jumpToMenuSelectView];
    }

}

/**
 
   跳转到充值界面
 */
-(void)jumpToRechargeView
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RechargeViewController *accountView = [mainView instantiateViewControllerWithIdentifier:@"rechargeViewId"];
    [self.navigationController pushViewController:accountView animated:YES];
    
    
    
}

/**
 
  跳转到套餐界面
 */
-(void)jumpToMenuSelectView
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuSelectViewController *selectView = [mainView instantiateViewControllerWithIdentifier:@"selectMenuId"];
    [self.navigationController pushViewController:selectView animated:YES];
    
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
