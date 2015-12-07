//
//  RecommendVideoModel.h
//  AnFang
//
//  Created by MyOS on 15/12/5.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecommendVideoModel : NSObject

/** 分类图片*/
@property (nonatomic,copy) NSString *classImage;

/** 分类名称*/
@property (nonatomic,copy) NSString *className;

/** 区域ID*/
@property (nonatomic,copy) NSString *regionId;

@property (nonatomic,copy) NSString *regionCount;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)recommendVideoClassModel:(NSDictionary *)dict;

@end
