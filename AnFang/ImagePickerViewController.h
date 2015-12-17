//
//  ImagePickerViewController.h
//  AnFang
//
//  Created by mac   on 15/10/16.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URBMediaFocusViewController.h"
#import "CTAssetsPickerController.h"

@protocol PickImageDelegate <NSObject>

-(void) flushImageViews:(NSMutableArray*)arrayMutable;

@end

@interface ImagePickerViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIImagePickerControllerDelegate,CTAssetsPickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic,weak) id<PickImageDelegate> pickImageDelegate;
@property NSString *strOldAvatar;


@end
