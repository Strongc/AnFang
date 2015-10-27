//
//  ResourceTreeViewController.m
//  Demo-SDK3.0
//
//  Created by HuYafeng on 15/9/1.
//  Copyright (c) 2015年 sunda. All rights reserved.
//

#import "ResourceTreeViewController.h"
#import "PlayViewController.h"

@implementation ResourceTreeViewController {
    NSMutableArray *_allResorceList;
    NSMutableArray *_lineList;
    int _selectedLineID;
}

- (void)viewDidLoad {
    UITableView *tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStyleGrouped];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    _serverAddress = @"http://112.12.17.3";
    //获取线路列表
    _lineList = [NSMutableArray array];
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
//    if (_serverAddressTextField.text.length <= 7) {
//        _serverAddressTextField.text = @"http://10.10.48.105"; //海康内网测试环境
//    }
    BOOL result = [vmsNetSDK getLineList:_serverAddress toLineInfoList:_lineList]; //执行方法后，将把线路列表写入_lineList
    if (NO == result) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"获取线路失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }

    _selectedLineID = [_lineList[1] lineID];
    _mspInfo = [[CMSPInfo alloc] init];
   // VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
//    if (0 == _userNameTextField.text.length && 0 == _passwordTextField.text.length) {
//        _userNameTextField.text = @"admin"; //海康内网测试环境
//        _passwordTextField.text = @"hik12345+";
//    }
    BOOL result1 = [vmsNetSDK login:_serverAddress
                        toUserName:@"test"
                        toPassword:@"12345"
                          toLineID:_selectedLineID toServInfo:_mspInfo]; //方法执行后，msp信息将写入mapInfo
    if (NO == result1) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:@"登录失败"
                                                           delegate:nil cancelButtonTitle:@"好"
                                                  otherButtonTitles:nil, nil];
        [alertView show];
        return;
    }
    

    
    
    [self _getAllResources];
    [tableView reloadData];
}

//获取当前层级的所有资源
- (NSMutableArray *)_getAllResources {
    VMSNetSDK *vmsNetSDK = [VMSNetSDK shareInstance];
    _allResorceList = [NSMutableArray array];
   // NSMutableArray *tempArray = [NSMutableArray array];
    
    //判断当前对象应该获取控制中心还是区域下的资源
//    if (nil == _regionInfo) {
//        if (nil == _controlUnitInfo) {
//            
//            //获取根控制中心
//            [vmsNetSDK getControlUnitList:_serverAddress
//                                             toSessionID:_mspInfo.sessionID
//                                         toControlUnitID:0
//                                            toNumPerOnce:50
//                                               toCurPage:1
//                                       toControlUnitList:tempArray];
//            [_allResorceList addObjectsFromArray:tempArray];
//        } else {
//        
//            //获取控制中心下的控制中心
//            [vmsNetSDK getControlUnitList:_serverAddress
//                                            toSessionID:_mspInfo.sessionID
//                                        toControlUnitID:_controlUnitInfo.controlUnitID
//                                           toNumPerOnce:50
//                                              toCurPage:1
//                                      toControlUnitList:tempArray];
//            [_allResorceList addObjectsFromArray:tempArray];
//            
//            //获取控制中心下的区域
//            [vmsNetSDK getRegionListFromCtrlUnit:_serverAddress
//                                     toSessionID:_mspInfo.sessionID
//                                 toControlUnitID:_controlUnitInfo.controlUnitID
//                                    toNumPerOnce:50
//                                       toCurPage:1
//                                    toRegionList:tempArray];
//            [_allResorceList addObjectsFromArray:tempArray];
//            
//            //获取控制中心下的设备
//            [vmsNetSDK getCameraListFromCtrlUnit:_serverAddress
//                                     toSessionID:_mspInfo.sessionID
//                                 toControlUnitID:_controlUnitInfo.controlUnitID
//                                    toNumPerOnce:50
//                                       toCurPage:1
//                                    toCameraList:tempArray];
//            [_allResorceList addObjectsFromArray:tempArray];
//        }
   // } else {
        
        //获取区域下的区域     _regionInfo.regionID
        [vmsNetSDK getRegionListFromRegion:_serverAddress
                               toSessionID:_mspInfo.sessionID
                                toRegionID:9
                              toNumPerOnce:50
                                 toCurPage:1
                              toRegionList:_allResorceList];
        
        //获取区域下的设备
        [vmsNetSDK getCameraListFromRegion:_serverAddress
                               toSessionID:_mspInfo.sessionID
                                toRegionID:9
                              toNumPerOnce:50
                                 toCurPage:1
                              toCameraList:_allResorceList];
       // }
    
    int Id = _regionInfo.regionID;
    int controlId = _controlUnitInfo.controlUnitID;
    NSLog(@"区域 ：%d",Id);
    NSLog(@"%d",controlId);
    
    return _allResorceList;
}

#pragma mark - TableView Delegate and DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ResourceTreeCell"];
    if (nil == cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ResourceTreeCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 320, 44)];
        [cell.contentView addSubview:label];
    }
    
    //更新cell内容
    UILabel *label = [[cell.contentView subviews] lastObject];
    label.text = [_allResorceList[indexPath.row] name];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _allResorceList.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    //点击了某个设备，播放控制器
    if ([_allResorceList[indexPath.row] isMemberOfClass:[CCameraInfo class]]) {
        PlayViewController *playVC = [[PlayViewController alloc] init];
        
        //把预览回放和云台控制所需的参数传过去
        playVC.serverAddress = _serverAddress;
        playVC.mspInfo = _mspInfo;
        playVC.cameraInfo = _allResorceList[indexPath.row];
        [self.navigationController pushViewController:playVC animated:YES];
        return;
    }
    
    //点击了某个控制器或者区域，获取此row下一级的所有资源
    ResourceTreeViewController *nextResourceTreeVC = [[ResourceTreeViewController alloc] init];
    nextResourceTreeVC.serverAddress = _serverAddress;
    nextResourceTreeVC.mspInfo = _mspInfo;
    if ([_allResorceList[indexPath.row] isMemberOfClass:[CControlUnitInfo class]]) {
        nextResourceTreeVC.controlUnitInfo = _allResorceList[indexPath.row];
    } else {
        nextResourceTreeVC.regionInfo = _allResorceList[indexPath.row];
    }
    [self.navigationController pushViewController:nextResourceTreeVC animated:YES];
}

@end
