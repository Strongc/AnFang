//
//  MenuConfigViewController.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuConfigViewController.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "MenuTimeTableViewCell.h"
#import "MenuConfig.h"

@interface MenuConfigViewController ()
{

    UITableView *menuTimeTable;
    NSIndexPath *currentSelectedIndex;
    NSIndexPath *previousSelectedIndex;

}

@property (nonatomic,strong) NSArray *menuData;

@end

@implementation MenuConfigViewController

-(NSArray *)menuData
{
    if(_menuData == nil){
        
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuConfig.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
            
            MenuConfig *model = [MenuConfig appWithDict:dict];
            
            [arrayModels addObject:model];
        }
        
        _menuData = arrayModels;
        
    }
    
    return _menuData;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initControl];
    // Do any additional setup after loading the view.
}

-(void)initControl
{
    
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"ce7031"];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"套餐配置";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
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
    [self.view addSubview:backBtn];
    
    UIImageView *menuImage = [[UIImageView alloc]initWithFrame:CGRectMake(20*WIDTH/375, 90*HEIGHT/667, 80*WIDTH/375, 80*HEIGHT/667)];
    menuImage.image = [UIImage imageNamed:_menuImageName];
    [self.view addSubview:menuImage];
    
    UILabel *menuName = [[UILabel alloc]initWithFrame:CGRectMake(110*WIDTH/375, 90*HEIGHT/667, 100*WIDTH/375, 20*HEIGHT/667)];
    menuName.text = _menuStyle;
    menuName.textColor = [UIColor blackColor];
    menuName.font = [UIFont boldSystemFontOfSize:18*WIDTH/375];
    [self.view addSubview:menuName];
    
    UILabel *menuDetail = [[UILabel alloc]initWithFrame:CGRectMake(110*WIDTH/375, 112*HEIGHT/667, 260*WIDTH/375, 60*HEIGHT/667)];
    menuDetail.text = _menuDetail;
    menuDetail.numberOfLines = 0;
    menuDetail.textColor = [UIColor grayColor];
    menuDetail.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
    [self.view addSubview:menuDetail];

    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(40*WIDTH/375, 210*HEIGHT/667, 120*WIDTH/375, 13*HEIGHT/667)];
    title2.text = @"请选择套餐期限:";
    title2.textColor = [UIColor grayColor];
    title2.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:title2];
    
    menuTimeTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 240*HEIGHT/667, WIDTH, 270*HEIGHT/667) style:UITableViewStylePlain];
    menuTimeTable.delegate = self;
    menuTimeTable.dataSource = self;
    menuTimeTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    menuTimeTable.scrollEnabled = NO;
    menuTimeTable.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:menuTimeTable];
    
    UIButton *bankPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(40*WIDTH/375, 530*HEIGHT/667, 130*WIDTH/375, 40*HEIGHT/667)];
    [bankPayBtn setBackgroundImage:[UIImage imageNamed:@"bankpay"] forState:UIControlStateNormal];
    [self.view addSubview:bankPayBtn];
    
    UIButton *yuerPayBtn = [[UIButton alloc]initWithFrame:CGRectMake(205*WIDTH/375, 530*HEIGHT/667, 130*WIDTH/375, 40*HEIGHT/667)];
    [yuerPayBtn setBackgroundImage:[UIImage imageNamed:@"yuePay"] forState:UIControlStateNormal];
    [self.view addSubview:yuerPayBtn];
    
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.menuData.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentify = @"cell";
    MenuTimeTableViewCell *cell = (MenuTimeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if(cell == nil){
        
        cell = [[MenuTimeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    MenuConfig *model = [self.menuData objectAtIndex:indexPath.item];
   // cell.menuTime.text = model.time;
    //cell.menuPrice.text = model.price;
    cell.menuConfig = model;
    
    BOOL isSelected = [indexPath isEqual:currentSelectedIndex];
    BOOL isDeselectedShouldAnimate = currentSelectedIndex != nil && [indexPath isEqual:currentSelectedIndex];
    
    [cell setHightlightBackground:isSelected withAimate:isDeselectedShouldAnimate];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 70.0*WIDTH/375;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    previousSelectedIndex = currentSelectedIndex;
    
    if ([currentSelectedIndex isEqual:indexPath] ) {
        
        currentSelectedIndex = nil;
        
    } else {
        
        currentSelectedIndex = indexPath;
        
    }
    
    [menuTimeTable reloadData];
    
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
