//
//  UUMessageCell.m
//  UUChatDemoForTextVoicePicture
//
//  Created by shake on 14-8-27.
//  Copyright (c) 2014年 uyiuyao. All rights reserved.
//

#import "UUMessageCell.h"
#import "UUMessage.h"
#import "UUAVAudioPlayer.h"
#import "ACMacros.h"
#import "Common.h"
//#import "UIImageView+AFNetworking.h"
//#import "UIButton+AFNetworking.h"
//#import "UUImageAvatarBrowser.h"

@interface UUMessageCell ()<UUAVAudioPlayerDelegate>
{
    AVAudioPlayer *player;
    NSString *voiceURL;
    NSData *songData;
    
    UUAVAudioPlayer *audio;
    
    UIView *headImageBackView;
    BOOL contentVoiceIsPlaying;
}
@end

@implementation UUMessageCell

-(void)setMessage:(UUMessage *)message
{

    _message = message;
    self.labelTime.text = message.strTime;
    self.btnContent.voiceBackView.hidden = NO;
    self.btnContent.second.text = [NSString stringWithFormat:@"%@'s Voice",message.strVoiceTime];
    songData = message.voice;
    voiceURL = message.voiceUrl;

}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(15*WIDTH/375, 24*HEIGHT/667, WIDTH-30*WIDTH/375, 80*HEIGHT/667)];
        backgroundView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:backgroundView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;

        //1、创建标题
        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(5*WIDTH/375, 5*HEIGHT/667, 60*WIDTH/375, 20*HEIGHT/667)];
        [backgroundView addSubview:titleLab];
        titleLab.textAlignment = NSTextAlignmentCenter;
        titleLab.textColor = [UIColor blackColor];
        titleLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        titleLab.text = @"语音报警";
        
        // 2、创建时间
        self.labelTime = [[UILabel alloc] init];
        self.labelTime.textAlignment = NSTextAlignmentCenter;
        self.labelTime.textColor = [UIColor grayColor];
        self.labelTime.font = ChatTimeFont;
        self.labelTime.frame = CGRectMake(0, 0, WIDTH, 24*HEIGHT/667);
        [backgroundView addSubview:self.labelTime];
        
        // 3、创建内容
        self.btnContent = [UUMessageContentButton buttonWithType:UIButtonTypeCustom];
        [self.btnContent setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.btnContent.titleLabel.font = ChatContentFont;
        self.btnContent.titleLabel.numberOfLines = 0;
        self.btnContent.frame = CGRectMake(90*WIDTH/375, 30*HEIGHT/667, self.frame.size.width-120, 40*HEIGHT/667 );
        [self.btnContent setBackgroundImage:[UIImage imageNamed:@"chatto_bg_normal.png"] forState:UIControlStateNormal];
        [self.btnContent addTarget:self action:@selector(btnContentClick)  forControlEvents:UIControlEventTouchUpInside];
        [backgroundView addSubview:self.btnContent];
        
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(UUAVAudioPlayerDidFinishPlay) name:@"VoicePlayHasInterrupt" object:nil];
        
        //红外线感应监听
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChange:)
                                                     name:UIDeviceProximityStateDidChangeNotification
                                                   object:nil];
        contentVoiceIsPlaying = NO;

    }
    return self;
}

//点击内容触发的事件
- (void)btnContentClick{
    //play audio
   
        if(!contentVoiceIsPlaying){
            [[NSNotificationCenter defaultCenter] postNotificationName:@"VoicePlayHasInterrupt" object:nil];
            contentVoiceIsPlaying = YES;
            audio = [UUAVAudioPlayer sharedInstance];
            audio.delegate = self;
            //[audio playSongWithUrl:voiceURL];
            [audio playSongWithData:songData];
        }else{
            
            [self UUAVAudioPlayerDidFinishPlay];
        }
    
    //show the picture
   }

- (void)UUAVAudioPlayerBeiginLoadVoice
{
    [self.btnContent benginLoadVoice];
}
- (void)UUAVAudioPlayerBeiginPlay
{
    [self.btnContent didLoadVoice];
}
- (void)UUAVAudioPlayerDidFinishPlay
{
    contentVoiceIsPlaying = NO;
    [self.btnContent stopPlay];
    [[UUAVAudioPlayer sharedInstance]stopSound];
}


- (void)makeMaskView:(UIView *)view withImage:(UIImage *)image
{
    UIImageView *imageViewMask = [[UIImageView alloc] initWithImage:image];
    imageViewMask.frame = CGRectInset(view.frame, 0.0f, 0.0f);
    view.layer.mask = imageViewMask.layer;
}

//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    if ([[UIDevice currentDevice] proximityState] == YES){
        NSLog(@"Device is close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }
    else{
        NSLog(@"Device is not close to user");
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

@end



