//
//  SystemConfigViewController.h
//  AnFang
//
//  Created by MyOS on 15/12/22.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemConfigViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong) UITableView *setTableView;
@property (nonatomic,strong) NSMutableArray *menuArray;
@end
