//
//  AppDelegate.m
//  AnFang
//
//  Created by mac   on 15/9/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AppDelegate.h"
#import<AlipaySDK/AlipaySDK.h>
//#import "DDTTYLogger.h"
//#import "DDLog.h"
#import "VideoPlaySDK.h"
#import "WXApiManager.h"
#import "Constant.h"


/**
 *  微信开放平台申请得到的 appid, 需要同时添加在 URL schema
 */
NSString * const WXAppId = @"wx263870c2830052ee";

/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppKey = @"L8LrMqqeGRxST5reouB0K66CaYAWpqhAVsq7ggKkxHCOastWksvuX1uvmvQclxaHoYd3ElNBrNO2DHnnzgfVG9Qs473M3DTOZug5er46FhuGofumV8H2FVR9qkjSlC5K";

/**
 * 微信开放平台和商户约定的密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXAppSecret = @"cf36de2224d7d8db339b7ae8591dcc24";
//cf36de2224d7d8db339b7ae8591dcc24
/**
 * 微信开放平台和商户约定的支付密钥
 *
 * 注意：不能hardcode在客户端，建议genSign这个过程由服务器端完成
 */
NSString * const WXPartnerKey = @"hzwellgood163company201512021525";

/**
 *  微信公众平台商户模块生成的ID
 */
NSString * const WXPartnerId = @"1280576201";

@interface AppDelegate ()

@end

@implementation AppDelegate

//- (void)startServer
//{
//    // Start the server (and check for problems)
//    
//    NSError *error;
//    if([httpServer start:&error])
//    {
//        //NSLog(@"Started HTTP Server on port %hu", [httpServer listeningPort]);
//    }
//    else
//    {
//       // NSLog(@"Error starting HTTP Server: %@", error);
//    }
//}
//

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //初始化视频播放库
    VP_InitSDK();
    //创建窗口
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    /*
     2.判断是否第一次使用这个版本
     */
    NSString *key = (NSString *)kCFBundleVersionKey;
    //先去沙盒中取出上次使用的版本号
    NSString *lastVersionCode = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    //加载info.plist文件
    NSString *currentVersionCode = [NSBundle mainBundle].infoDictionary[key];
    
    if([lastVersionCode isEqualToString:currentVersionCode]){
    
        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginNavigationViewController *loginViewNav = [mainView instantiateViewControllerWithIdentifier:@"loginNavId"];
        self.window.rootViewController = loginViewNav;
    
    }else{
    
        //第一次使用软件,保存当前软件版本号
        [[NSUserDefaults standardUserDefaults] setObject:currentVersionCode forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        NewFeatureViewController *newFeatureView = [mainView instantiateViewControllerWithIdentifier:@"guidViewId"];
        self.window.rootViewController = newFeatureView;
    
    }
    
    //向微信注册
    [WXApi registerApp:@"wx263870c2830052ee" withDescription:@"掌上安防"];
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];
//    
//    httpServer = [[HTTPServer alloc]init];
//    
//    [httpServer setType:@"_http._tcp."];
//    
//    [httpServer setPort:12345];
//
//    NSString *webPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Private Documents/Temp"];
//    NSFileManager *fileManager=[NSFileManager defaultManager];
//    if(![fileManager fileExistsAtPath:webPath])
//    {
//        [fileManager createDirectoryAtPath:webPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
//    [httpServer setDocumentRoot:webPath];
//    
//    [self startServer];
    [self.window makeKeyAndVisible];
    return YES;
}

-(void) onResp:(BaseResp*)resp
{
    NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    NSString *strTitle;
    
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
    }
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        strTitle = [NSString stringWithFormat:@"支付结果"];
        
        switch (resp.errCode) {
            case WXSuccess:
                strMsg = @"支付结果：成功！";
                NSLog(@"支付成功－PaySuccess，retcode = %d", resp.errCode);
                break;
                
            default:
               // strMsg = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                strMsg = [NSString stringWithFormat:@"支付结果：交易取消！"];
                NSLog(@"错误，retcode = %d, retstr = %@", resp.errCode,resp.errStr);
                break;
        }
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
    
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    
   // [httpServer stop];
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
   
   // [self startServer];
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}



-(BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    [WXApi handleOpenURL:url delegate:self];
    return  YES;
}


-(BOOL)prefersStatusBarHidden
{
    
    return  NO;

}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
   
    [[AlipaySDK  defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            
            NSLog(@"result = %@",resultDic);
    }];
    
    [WXApi handleOpenURL:url delegate:self];
    
    return YES;
}

#pragma mark - Core Data stack

@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

- (NSURL *)applicationDocumentsDirectory {
    // The directory the application uses to store the Core Data store file. This code uses a directory named "com.wellgood.www.AnFang" in the application's documents directory.
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSManagedObjectModel *)managedObjectModel {
    // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"AnFang" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // The persistent store coordinator for the application. This implementation creates and return a coordinator, having added the store for the application to it.
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    // Create the coordinator and store
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"AnFang.sqlite"];
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _persistentStoreCoordinator;
}


- (NSManagedObjectContext *)managedObjectContext {
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.)
    if (_managedObjectContext != nil) {
        return _managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (!coordinator) {
        return nil;
    }
    _managedObjectContext = [[NSManagedObjectContext alloc] init];
    [_managedObjectContext setPersistentStoreCoordinator:coordinator];
    return _managedObjectContext;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        NSError *error = nil;
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

@end
