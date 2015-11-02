//
//  WGData.m
//  AnFang
//
//  Created by mac   on 15/9/30.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "WGData.h"
#import "CoreArchive.h"


@implementation WGData

+ (NSString*) getStringInDefByKey:(NSString*)key
{
    return [self getStringInDefByKey:key Default:@"0"];
}

+ (NSString*) getStringInDefByKey:(NSString*)key Default:(NSString *)strDefault
{
    NSUserDefaults *def = [NSUserDefaults standardUserDefaults];
    NSString *result = [def valueForKey:key];
    
    if (!result) {
        result = strDefault;
    }
    return result;
}

+(WGUserInfo*) getUser
{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    NSString* tel = [userDefaults objectForKey:@"name"];
    NSFetchRequest* fetchRequest;
    NSError* error;
    WGUserInfo* userData;
    if (tel)
    {
        fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"WGUserInfo"];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"strTel CONTAINS '%@'", tel]];
        NSArray* array = [appDelegate.managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (array.count > 0)
        {
            userData = array[0];
        }
        else
        {
            userData = nil;
        }
    }
    return userData;
}

+(void)setUser:(NSDictionary*)dict
{
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    
    AppDelegate* appDelegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    BOOL isNew = YES;
    WGUserInfo* userData = [self getUser];
    
    if (userData) {
        isNew = NO;
    }
    else
    {
        isNew = YES;
    }
    
    if (isNew)
    {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"WGUserInfo" inManagedObjectContext:appDelegate.managedObjectContext];
        userData = [[WGUserInfo alloc] initWithEntity:entity insertIntoManagedObjectContext:appDelegate.managedObjectContext];
    }
    
   
    userData.strName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    userData.strUserId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"userId"]];
    userData.strPwd = [NSString stringWithFormat:@"%@",[dict objectForKey:@"pwd"]];;
   
    //    if([dict objectForKey:@"id_card"] == nil){
    //        userData.strName = @"";
    //    }else{
    //        userData.strName = [dict objectForKey:@"id_card"];
    //    }
    
    //    userData.strJifen = [dict objectForKey:@"id_card"];//依然报错
   
    [appDelegate saveContext];
    [userDefaults setObject:[dict objectForKey:@"name"] forKey:@"name"];
}

+(NSString *)getUserName
{
    
    WGUserInfo* userData = [self getUser];
    if(userData){
        return userData.strName;
    }else{
        return  @"";
    }

}

+(NSString *)getuserId
{
    
    WGUserInfo* userData = [self getUser];
    if (userData) {
        return userData.strUserId;
    }
    else
    {
        return @"0";
    }

}

+(NSString*) getPwd
{
    return [self getStringInDefByKey:@"pwd" Default:@""];
}


@end
