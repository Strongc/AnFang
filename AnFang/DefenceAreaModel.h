//
//  DefenceAreaModel.h
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DefenceAreaModel : NSObject

@property(nonatomic,copy) NSString *devName;
@property(nonatomic,copy) NSString *devState;
@property(nonatomic,copy) NSString *devId;
@property(nonatomic,copy) NSString *photoPath;
@property(nonatomic,copy) NSString *videoUrl;

-(DefenceAreaModel *)initWithDict:(NSDictionary *)dict;
+(DefenceAreaModel *) monitorWithDict:(NSDictionary *)dict;

@end
