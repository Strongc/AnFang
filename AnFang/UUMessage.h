//
//  UUMessage.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-26.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UUMessage : NSObject

@property (nonatomic, copy) NSString *strTime;
//@property (nonatomic, copy) NSString *strContent;
//@property (nonatomic, strong) UIImage  *picture;
@property (nonatomic, copy) NSData   *voice;
@property (nonatomic, copy) NSString *strVoiceTime;
@property (nonatomic, copy) NSString *voiceUrl;

@property (nonatomic, assign) BOOL showDateLabel;

-(instancetype ) initWithDict:(NSDictionary *)dict;
+(instancetype ) UUMessageModelWithDict:(NSDictionary *)dict;

//- (void)minuteOffSetStart:(NSString *)start end:(NSString *)end;

@end
