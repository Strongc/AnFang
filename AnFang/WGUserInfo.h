//
//  WGUserInfo.h
//  AnFang
//
//  Created by mac   on 15/10/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <CoreData/CoreData.h>
#import <Foundation/Foundation.h>

@interface WGUserInfo : NSManagedObject

@property(nonatomic,retain) NSString *strName;
@property(nonatomic,retain) NSString *strUserId;
@property(nonatomic,retain) NSString *strPwd;

@end
