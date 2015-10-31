//
//  SystemMessageViewController.h
//  AnBao
//
//  Created by mac   on 15/9/10.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AlarmMessageTableViewCell.h"

@interface SystemMessageViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *sysMessageArray;
@property (nonatomic,assign) NSInteger amount;
@end
