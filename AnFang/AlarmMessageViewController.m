//
//  AlarmMessageViewController.m
//  AnBao
//
//  Created by mac   on 15/9/10.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AlarmMessageViewController.h"
#import "UIColor+Extensions.h"
#import "Common.h"
#import "AlarmMessageDetailViewController.h"

@interface AlarmMessageViewController ()
{
     UITableView *messageTable;
     NSMutableArray *messageTime;
     NSMutableArray *messageTitle;

}

@end

@implementation AlarmMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor blackColor];
    
    messageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    messageTable.delegate = self;
    messageTable.dataSource = self;
    messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageTable.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    // monitorTable.separatorStyle = NO;
    [self.view addSubview:messageTable];
    
    messageTime = [[NSMutableArray alloc]initWithObjects:@"2015-5-21  23:25", @"2015-5-13  14:25",@"2015-5-4  21:25",@"2015-4-21  19:25",nil];
    messageTitle = [[NSMutableArray alloc]initWithObjects:@"食堂防区异常",@"停车场防区异常",@"华业大厦北侧广场异常",@"华业大厦一楼走廊异常", nil];

    // Do any additional setup after loading the view.
}

#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return messageTitle.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *reuseIdentify = @"cell";
    AlarmMessageTableViewCell *cell = (AlarmMessageTableViewCell *)[tableView dequeueReusableCellWithIdentifier:reuseIdentify];
    
    if(cell == nil){
        
        cell = [[AlarmMessageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentify];
        
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.backgroundColor = [UIColor whiteColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.messageTime.text = [messageTime objectAtIndex:indexPath.row];
    cell.areaInfo.text = [messageTitle objectAtIndex:indexPath.row];
    
    [cell.checkBtn addTarget:self action:@selector(jumpToDetailView) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 65.0*HEIGHT/667;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   // DeviceManagerViewController *defenceArea = [mainView instantiateViewControllerWithIdentifier:@"deviceManagerId"];
   // self.navigationController.navigationBarHidden = NO;
   // [self.navigationController pushViewController:defenceArea animated:YES];
    
}

-(void)jumpToDetailView
{
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlarmMessageDetailViewController *detailView = [mainView instantiateViewControllerWithIdentifier:@"alarmMessageDetailId"];
    [self.navigationController pushViewController:detailView animated:YES];

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
