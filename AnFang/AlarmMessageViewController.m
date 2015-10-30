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
#import "WGAPI.h"
#import "JSONKit.h"
#import "CMTool.h"
#import "SDRefresh.h"
//#import "LoadMoreTableFooterView.h"


@interface AlarmMessageViewController ()
{
     UITableView *messageTable;
     NSMutableArray *messageTime;
     NSMutableArray *messageTitle;
     NSMutableArray *messageArray;
     //NSDictionary *messageInfo;
     NSMutableArray *tempArray;
    
    // LoadMoreTableFooterView *loadMoreTableFooterView;
}

@property (nonatomic, weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic, weak) SDRefreshHeaderView *refreshHeader;

@end

@implementation AlarmMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // messageInfo = [[NSDictionary alloc] init];
    messageArray = [[NSMutableArray alloc]init];
    tempArray = [[NSMutableArray alloc]init];
    //self.view.backgroundColor = [UIColor blackColor];
    
    messageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    messageTable.delegate = self;
    messageTable.dataSource = self;
    messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageTable.backgroundColor = [UIColor whiteColor];
    // monitorTable.separatorStyle = NO;
    [self.view addSubview:messageTable];
    
    [self setupHeader];
    [self setupFooter];

    messageTime = [[NSMutableArray alloc]initWithObjects:@"2015-5-21  23:25", @"2015-5-13  14:25",@"2015-5-4  21:25",@"2015-4-21  19:25",nil];
    messageTitle = [[NSMutableArray alloc]initWithObjects:@"食堂防区异常",@"停车场防区异常",@"华业大厦北侧广场异常",@"华业大厦一楼走廊异常", nil];

    [self getAlarmMessage];
    // Do any additional setup after loading the view.
}

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:messageTable];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    __weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //weakSelf.totalRowCount += 3;
            [messageTable reloadData];
            [weakRefreshHeader endRefreshing];
        });
    };
    
    // 进入页面自动加载一次数据
    [refreshHeader autoRefreshWhenViewDidAppear];
}

- (void)setupFooter
{
    SDRefreshFooterView *refreshFooter = [SDRefreshFooterView refreshView];
    [refreshFooter addToScrollView:messageTable];
    [refreshFooter addTarget:self refreshAction:@selector(footerRefresh)];
    _refreshFooter = refreshFooter;
}


- (void)footerRefresh
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        //self.totalRowCount += 2;
        [messageTable reloadData];
        [self.refreshFooter endRefreshing];
    });
}


-(void)getAlarmMessage
{
   // NSString *urlStr=[NSString stringWithFormat:@"http://192.168.0.41:8080/platform/alarm/page"];,@"alrm_id":@"201510112342290296"
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"2"};
    NSDictionary *pageInfo = @{@"page":page};
    NSString *pageStr = [pageInfo JSONString];
    NSString *userInfoData = [@"alarm=" stringByAppendingString:pageStr];
    
    [WGAPI post:API_GET_ALARMINFO RequestParams:userInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        if(data){
        
             NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
             NSLog(@"%@",jsonStr);
             NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
//                NSDictionary *messageInfo = [infojson objectForKey:@"datas"];
//                NSString *messageInfoStr = [CMTool dictionaryToJson:messageInfo];
//                NSLog(@"%@",messageInfoStr);
                tempArray = [infojson objectForKey:@"datas"];
                for(NSDictionary *dict in tempArray){
                    
                    AlarmMessageModel *model = [AlarmMessageModel AlarmMessageModelWithDict:dict];
                    [messageArray addObject:model];
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
    
    return  messageArray.count;
    
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
    
    AlarmMessageModel *model = [messageArray objectAtIndex:indexPath.row];
    cell.alarmMessage = model;
    
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
