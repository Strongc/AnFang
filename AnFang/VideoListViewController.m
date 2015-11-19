//
//  VideoListViewController.m
//  AnBao
//
//  Created by mac   on 15/9/8.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "VideoListViewController.h"
#import "UIView+KGViewExtend.h"
#import "Common.h"
#import "UIColor+Extensions.h"
#import "WGAPI.h"
#import "JSONKit.h"
#import "CMTool.h"
#import "CameraModel.h"
#import "MonitorInfoTableViewCell.h"

@implementation VideoListViewController
{
    NSMutableArray *tempArray;
    NSMutableArray *temp2Array;
    NSString *tempId;
    NSMutableArray *cameraArray;
    UITableView *monitorTable;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    tempArray = [[NSMutableArray alloc] init];
    cameraArray = [[NSMutableArray alloc] init];
    temp2Array = [[NSMutableArray alloc] init];
    
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64)];
    headView.backgroundColor = [UIColor colorWithHexString:@"ce7031"];
    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 44)];
    [headView addSubview:navView];
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 30)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"监控列表";
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
    
    monitorTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, WIDTH, HEIGHT) style:UITableViewStylePlain];
    monitorTable.delegate = self;
    monitorTable.dataSource = self;
    monitorTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    monitorTable.backgroundColor = [UIColor whiteColor];
    [self getAreaInfo];

    // Do any additional setup after loading the view.
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
}

//获取防区信息
-(void)getAreaInfo
{
    
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"2"};
    NSDictionary *pageInfo = @{@"page":page};
    NSString *pageStr = [pageInfo JSONString];
    NSString *userInfoData = [@"area=" stringByAppendingString:pageStr];
    
    [WGAPI post:API_GET_AREAINFO RequestParams:userInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
            
            NSString *jsonStr =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%@",jsonStr);
            NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:jsonStr];
            if(infojson != nil){
                NSDictionary *messageInfo = [infojson objectForKey:@"data"];
                // NSString *messageInfoStr = [CMTool dictionaryToJson:messageInfo];
                // NSLog(@"%@",messageInfoStr);
                tempArray = [messageInfo objectForKey:@"datas"];
                if(tempArray.count > 0){
                    
                    NSDictionary *dict = tempArray[0];
                    tempId = [dict objectForKey:@"area_id"];
                    [self getCameraInfo:tempId];
                    
                }
                
                
            }
            //[self performSelectorOnMainThread:@selector(getAreaId) withObject:data waitUntilDone:YES];
        }
        
    }];
    
}


//获取防区的所有摄像头信息
-(void)getCameraInfo:(NSString *)areaId
{
    //NSString *pagesize = [NSString stringWithFormat:@"%d",pageSize];
    NSDictionary *page = @{@"pageNo":@"1",@"pageSize":@"100"};//@"area_id":@"201510120000030712",
    NSDictionary *pageInfo = @{@"area_id":areaId,@"page":page};
    NSString *pageStr = [pageInfo JSONString];
    NSString *userInfoData = [@"camera=" stringByAppendingString:pageStr];
    
    [WGAPI post:API_GET_CAMERAINFO RequestParams:userInfoData FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if(data){
            
            NSString *jsonStr1 =  [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonStr1);
            NSDictionary *infojson1 = [CMTool parseJSONStringToNSDictionary:jsonStr1];
            if(infojson1 != nil){
                NSDictionary *messageInfo = [infojson1 objectForKey:@"data"];
                NSString *messageInfoStr = [CMTool dictionaryToJson:messageInfo];
                NSLog(@"%@",messageInfoStr);
                temp2Array = [messageInfo objectForKey:@"datas"];
                if(temp2Array.count > 0){
                    for(NSDictionary *dict in temp2Array){
                        
                        CameraModel *model = [CameraModel CameraWithDict:dict];
                        [cameraArray addObject:model];
                    }
                    
                }
    
            }
            
            [self performSelectorOnMainThread:@selector(refreshMonitorData) withObject:data waitUntilDone:YES];
        }
    }];
    
}

-(void)refreshMonitorData
{
    
    [monitorTable reloadData];
}


#pragma mark - UITableViewDataSource

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return cameraArray.count;
    
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
    
    CameraModel *model = [cameraArray objectAtIndex:indexPath.row];
    cell.cameraModel = model;
    
    return cell;
    
}

#pragma mark - UITableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80.0*HEIGHT/667;
    
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
