//
//  RegisterViewController.h
//  AnBao
//
//  Created by mac   on 15/8/26.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController

@property (nonatomic,strong) UITextField *userNameField;
@property (nonatomic,strong) UITextField *passwordField;
@property (nonatomic,strong) UITextField *ConfirmPasswordField;
@property (nonatomic,copy) NSString *message;
@end
