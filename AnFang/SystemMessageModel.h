//
//  SystemMessageModel.h
//  AnFang
//
//  Created by mac   on 15/10/29.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SystemMessageModel : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *messageId;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) SystemMessageModelWithDict:(NSDictionary *)dict;


@end
