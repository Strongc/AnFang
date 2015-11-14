//
//  UUMessageCell.h
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#define ChatTimeFont [UIFont systemFontOfSize:11]   //时间字体
#define ChatContentFont [UIFont systemFontOfSize:14]//内容字体
#import <UIKit/UIKit.h>
#import "UUMessageContentButton.h"
#import "UUMessage.h"
@class UUMessageCell;

@protocol UUMessageCellDelegate <NSObject>
@optional

- (void)headImageDidClick:(UUMessageCell *)cell userId:(NSString *)userId;
- (void)cellContentDidClick:(UUMessageCell *)cell image:(UIImage *)contentImage;
@end

@interface UUMessageCell : UITableViewCell

@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, strong) UUMessageContentButton *btnContent;
@property (nonatomic, assign) id<UUMessageCellDelegate>delegate;
@property (nonatomic, strong) UUMessage *message;

@end

