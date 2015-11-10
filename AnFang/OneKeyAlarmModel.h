//
//  OneKeyAlarmModel.h
//  AnFang
//
//  Created by mac   on 15/10/15.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OneKeyAlarmModel : NSObject

@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *location;
//@property (nonatomic,copy) NSString *state;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) OneKeyAlarmModelWithDict:(NSDictionary *)dict;

@end
