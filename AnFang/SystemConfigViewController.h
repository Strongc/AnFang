//
//  SystemConfigViewController.h
//  AnFang
//
//  Created by MyOS on 15/12/22.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SystemConfigViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *setTableView;
@end
