//
//  PublicVideoClassModel.h
//  AnFang
//
//  Created by MyOS on 15/11/21.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PublicVideoClassModel : NSObject

/** 分类图片*/
@property (nonatomic,copy) NSString *classImage;

/** 分类名称*/
@property (nonatomic,copy) NSString *className;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)publicVideoClassModel:(NSDictionary *)dict;
@end
