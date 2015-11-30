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
#import "SVProgressHUD.h"
//#import "LoadMoreTableFooterView.h"


@interface AlarmMessageViewController ()
{
     UITableView *messageTable;
     NSMutableArray *messageTime;
     NSMutableArray *messageTitle;
     NSMutableArray *messageArray;
     //NSDictionary *messageInfo;
     NSArray *tempArray;
     UILabel *alertLab;
    int pageSize;
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
    tempArray = [[NSArray alloc]init];
    self.view.backgroundColor = [UIColor colorWithHexString:@"040818"];
    
    messageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    messageTable.delegate = self;
    messageTable.dataSource = self;
    messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageTable.backgroundColor = [UIColor colorWithHexString:@"040818"];
    // monitorTable.separatorStyle = NO;
    [self.view addSubview:messageTable];
    
    [self setupHeader];
    [self setupFooter];

    messageTime = [[NSMutableArray alloc]initWithObjects:@"2015-5-21  23:25", @"2015-5-13  14:25",@"2015-5-4  21:25",@"2015-4-21  19:25",nil];
    messageTitle = [[NSMutableArray alloc]initWithObjects:@"食堂防区异常",@"停车场防区异常",@"华业大厦北侧广场异常",@"华业大厦一楼走廊异常", nil];
     pageSize = 2;
    [self getAlarmMessage];
    
    alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, WIDTH, 15*HEIGHT/667)];
    [self.view addSubview:alertLab];
    alertLab.text = @"暂无内容！";
    alertLab.textAlignment = NSTextAlignmentCenter;
    // Do any additional setup after loading the view.
}

- (void)setupHeader
{
    SDRefreshHeaderView *refreshHeader = [SDRefreshHeaderView refreshView];
    
    // 默认是在navigationController环境下，如果不是在此环境下，请设置 refreshHeader.isEffectedByNavigationController = NO;
    [refreshHeader addToScrollView:messageTable];
    
    __weak SDRefreshHeaderView *weakRefreshHeader = refreshHeader;
    //__weak typeof(self) weakSelf = self;
    refreshHeader.beginRefreshingOperation = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
             pageSize += 1;
            [messageArray removeAllObjects];
            [self getAlarmMessage];
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
       
            [self.refreshFooter endRefreshing];
        });
}


-(void)getAlarmMessage
{
    
        NSString *pagesize = [NSString stringWithFormat:@"%d",pageSize];
        NSDictionary *page = @{@"pageNo":@"1",@"pageSize":pagesize};
        NSDictionary *pageInfo = @{@"page":page};
        NSString *pageStr = [pageInfo JSONString];
        NSString *userInfoData = [@"alarm=" stringByAppendingString:pageStr];
        [SVProgressHUD showWithStatus:@"加载中..."];
        [WGAPI post:API_GET_ALARMINFO RequestParams:nil FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
            if(data){
        
                NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //NSLog(@"%@",jsonStr);
                NSDictionary *infojson = [CMTool strDic:jsonStr];
                if(infojson != nil){
                   // NSDictionary *messageInfo = [infojson objectForKey:@"data"];
                    tempArray = [infojson objectForKey:@"data"];
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
   [SVProgressHUD showSuccessWithStatus:@"加载完成！" maskType:SVProgressHUDMaskTypeBlack];
    if(messageArray.count > 0){
        
        alertLab.hidden = YES;
    }else if (messageArray.count == 0){
        
        alertLab.hidden = NO;
    }

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
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    AlarmMessageModel *model = [messageArray objectAtIndex:indexPath.row];
    cell.alarmMessage = model;
    //[cell.checkBtn setTag:indexPath.row];
    //[cell.checkBtn addTarget:self action:@selector(jumpToDetailView:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80.0;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    AlarmMessageDetailViewController *detailView = [mainView instantiateViewControllerWithIdentifier:@"alarmMessageDetailId"];
    AlarmMessageModel *model = [messageArray objectAtIndex:indexPath.row];
    detailView.messageId = model.messageId;
    [self.navigationController pushViewController:detailView animated:YES];
    
}

//-(void)jumpToDetailView:(id)sender
//{
//     NSInteger n = [sender tag];
//}

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
