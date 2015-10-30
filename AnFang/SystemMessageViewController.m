//
//  SystemMessageViewController.m
//  AnBao
//
//  Created by mac   on 15/9/10.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "SystemMessageViewController.h"
#import "Common.h"
#import "AlarmMessageDetailViewController.h"
#import "WGAPI.h"
#import "JSONKit.h"
#import "CMTool.h"

@interface SystemMessageViewController ()
{

    UITableView *messageTable;
    NSMutableArray *sysMessageArray;
    NSMutableArray *tempArray;
}

@end

@implementation SystemMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    sysMessageArray = [[NSMutableArray alloc]init];
    tempArray = [[NSMutableArray alloc] init];
    
    messageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    messageTable.delegate = self;
    messageTable.dataSource = self;
    messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageTable.backgroundColor = [UIColor whiteColor];
    // monitorTable.separatorStyle = NO;
    [self.view addSubview:messageTable];

    [self getSystemMessage];
    // Do any additional setup after loading the view.
}

-(void)getSystemMessage
{
    // NSString *urlStr=[NSString stringWithFormat:@"http://192.168.0.41:8080/platform/alarm/page"];,@"alrm_id":@"201510112342290296"
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"2"};
    NSDictionary *pageInfo = @{@"page":page};
    NSString *pageStr = [pageInfo JSONString];
    NSString *userInfoData = [@"message=" stringByAppendingString:pageStr];
    
    [WGAPI post:API_GET_MESSAGEINFO RequestParams:userInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonStr);
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
                NSDictionary *messageInfo = [infojson objectForKey:@"data"];
                NSString *messageInfoStr = [CMTool dictionaryToJson:messageInfo];
                NSLog(@"%@",messageInfoStr);
                tempArray = [messageInfo objectForKey:@"datas"];
                for(NSDictionary *dict in tempArray){
                    
                    SystemMessageModel *model = [SystemMessageModel SystemMessageModelWithDict:dict];
                    [sysMessageArray addObject:model];
                }
                
                
            }
            [self performSelectorOnMainThread:@selector(refreshData) withObject:data waitUntilDone:YES];
            
        }
        
        
    }];
    
    
}

-(void)refreshData
{
    
    [messageTable reloadData];
}


#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  sysMessageArray.count;
    
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
    
    SystemMessageModel *model = [sysMessageArray objectAtIndex:indexPath.row];
    cell.sysMessage = model;
    
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
