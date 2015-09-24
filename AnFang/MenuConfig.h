//
//  MenuConfig.h
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuConfig : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *price;

-(MenuConfig *)initWithDict:(NSDictionary *)dict;
+(MenuConfig *)appWithDict:(NSDictionary *)dict;

@end
