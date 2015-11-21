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
#import "SDRefresh.h"
#import "MessageViewController.h"
#import "UIColor+Extensions.h"

@interface SystemMessageViewController ()
{
    UITableView *messageTable;
    
    NSMutableArray *tempArray;
    UILabel *alertLab;
    int pageSize;
}
@property (nonatomic,weak) SDRefreshFooterView *refreshFooter;
@property (nonatomic,weak) SDRefreshHeaderView *refreshHeader;

@end

@implementation SystemMessageViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithHexString:@"040818"];
    
    self.sysMessageArray = [[NSMutableArray alloc]init];
    tempArray = [[NSMutableArray alloc] init];
    
    messageTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) style:UITableViewStylePlain];
    messageTable.delegate = self;
    messageTable.dataSource = self;
    messageTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    messageTable.backgroundColor = [UIColor colorWithHexString:@"040818"];
    [self.view addSubview:messageTable];

    alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 80, WIDTH, 15*HEIGHT/667)];
    [self.view addSubview:alertLab];
    alertLab.text = @"暂无内容！";
    alertLab.textAlignment = NSTextAlignmentCenter;
    pageSize = 1;
    [self getSystemMessage];
    [self setupHeader];
    [self setupFooter];
   
//    MessageViewController *messageView = [[MessageViewController alloc] init];
//    UIButton *item = [messageView.navTabBarController.navTabBar.items objectAtIndex:1];
//    [item.badgeView setPosition:MGBadgePositionTopRight];
//    [item.badgeView setBadgeColor:[UIColor redColor]];
//    [item.badgeView setBadgeValue:sysMessageArray.count];

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
            [self.sysMessageArray removeAllObjects];
            [self getSystemMessage];
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


-(void)getSystemMessage
{
    
    NSString *pagesize = [NSString stringWithFormat:@"%d",pageSize];
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":pagesize};
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
                    [self.sysMessageArray addObject:model];
                }
                
                
            }
            [self performSelectorOnMainThread:@selector(refreshData) withObject:data waitUntilDone:YES];
            
        }
        
        
    }];
    
    
}

-(void)refreshData
{
    if(self.sysMessageArray.count > 0){
        
        alertLab.hidden = YES;
    }else if (self.sysMessageArray.count == 0){
        
        alertLab.hidden = NO;;
    }

     self.amount = self.sysMessageArray.count;
    [messageTable reloadData];
}


#pragma mark UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return  self.sysMessageArray.count;
    
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
    
    SystemMessageModel *model = [self.sysMessageArray objectAtIndex:indexPath.row];
    cell.sysMessage = model;
   // NSString *msgId = model.messageId;
   // [cell.checkBtn setTag:indexPath.row];
   // [cell.checkBtn addT];
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
    
    SystemMessageModel *model = [self.sysMessageArray objectAtIndex:indexPath.row];
    NSString *msgId = model.messageId;
    detailView.messageId = msgId;
    [self.navigationController pushViewController:detailView animated:YES];
    
}

//-(void)jumpToDetailView
//{
//   // NSInteger n = [sender tag];
//}
//

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
