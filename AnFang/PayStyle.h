//
//  PayStyle.h
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PayStyle : NSObject

@property (nonatomic,copy) NSString *icon;

-(PayStyle *)initWithDict:(NSDictionary *)dict;
+(PayStyle *)appWithDict:(NSDictionary *)dict;

@end
