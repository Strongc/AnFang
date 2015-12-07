//
//  schoolClassModel.h
//  AnFang
//
//  Created by MyOS on 15/12/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SchoolClassModel : NSObject

/** 视频的截图*/
@property (nonatomic,copy) NSString *titleImage;

/** 视频的名称*/
@property (nonatomic,copy) NSString *titleName;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)schoolClassModelWithDict:(NSDictionary *)dict;

@end
