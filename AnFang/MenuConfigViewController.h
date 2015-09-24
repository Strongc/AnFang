//
//  MenuConfigViewController.h
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuConfigViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
   
    
}

@property(nonatomic,copy) NSString *menuImageName;
@property(nonatomic,copy) NSString *menuStyle;
@property(nonatomic,copy) NSString *menuDetail;
@end
