//
//  MenuSelect.h
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuSelect : NSObject

@property (nonatomic,copy) NSString *icon;
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *intruction;
@property (nonatomic,copy) NSString *details;

-(MenuSelect *)initWithDict:(NSDictionary *)dict;
+(MenuSelect *)appWithDict:(NSDictionary *)dict;

@end
