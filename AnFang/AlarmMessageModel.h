//
//  AlarmMessage.h
//  AnFang
//
//  Created by mac   on 15/10/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlarmMessageModel : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *messageId;
@property (nonatomic,copy) NSString *messageSource;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) AlarmMessageModelWithDict:(NSDictionary *)dict;

@end
