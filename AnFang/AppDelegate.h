//
//  AppDelegate.h
//  AnFang
//
//  Created by mac   on 15/9/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "LoginNavigationViewController.h"
#import "NewFeatureViewController.h"
#import "WXApi.h"
//@class HTTPServer;
//#import "HTTPServer.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate, WXApiDelegate>
{

   // HTTPServer *httpServer;

}

@property (strong, nonatomic) UIWindow *window;
//@property (strong, nonatomic) ViewController *loginView;
//@property (strong, nonatomic) NewFeatureViewController *newFeatureView;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

