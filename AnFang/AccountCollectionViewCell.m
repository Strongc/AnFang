//
//  AccountCollectionViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AccountCollectionViewCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@implementation AccountCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self){
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UILabel * accountLab= [[UILabel alloc]initWithFrame:CGRectMake(10*WIDTH/375, 0,65*WIDTH/375, 30*HEIGHT/667)];
        accountLab.layer.borderWidth = 1.5;
        accountLab.layer.borderColor = [[UIColor colorWithHexString:@"bababa"]CGColor];
        accountLab.font = [UIFont systemFontOfSize:15];
        accountLab.textColor = [UIColor blackColor];
        accountLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:accountLab];
        self.accountLab = accountLab;
        
        
        
        
    }
    
    return self;
}

- (void)setHightlightBackground:(BOOL)isSelected withAimate:(BOOL)animate
{
    [self.accountLab.layer removeAllAnimations];
    //[self.bgView.layer removeAllAnimations];
    [self.layer removeAllAnimations];
    
    if (isSelected == YES) {
        
        [self setHightlightBackground];
        
    } else {
        
        [self setNormalBackground:animate];
        
    }
}

- (void)setNormalBackground:(BOOL)animate
{
    
    self.accountLab.layer.borderColor = [[UIColor colorWithHexString:@"bababa"]CGColor];
    
    if (animate) {
        
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [self.accountLab setFrame:CGRectMake(self.accountLab.frame.origin.x+1, self.accountLab.frame.origin.y+1, self.accountLab.frame.size.width-2, self.accountLab.frame.size.height-2)];
                             
                             //[self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x+1, self.bgView.frame.origin.y+1, self.bgView.frame.size.width-2, self.bgView.frame.size.height-2)];
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self.accountLab setFrame:CGRectMake(self.accountLab.frame.origin.x-1, self.accountLab.frame.origin.y-1, self.accountLab.frame.size.width+2, self.accountLab.frame.size.height+2)];
                             
                             //[self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x-1, self.bgView.frame.origin.y-1, self.bgView.frame.size.width+2, self.bgView.frame.size.height+2)];
                             
                         }
         ];
        
    }
    
   // self.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    
}

- (void)setHightlightBackground
{
    
     self.accountLab.layer.borderColor = [[UIColor colorWithHexString:@"87cefa"]CGColor];
   // self.bgView.layer.borderWidth = 1.0f;
    //self.accountLab.layer.borderColor = [UIColor greenColor].CGColor;
    
    [UIView animateWithDuration:0.2f
                          delay:0.0f
                        options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                     animations:^{
                         
                         //[self.accountLab setFrame:CGRectMake(self.accountLab.frame.origin.x+1, self.accountLab.frame.origin.y+1, self.accountLab.frame.size.width-2, self.accountLab.frame.size.height-2)];
                        
                        // [self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x+1, self.bgView.frame.origin.y+1, self.bgView.frame.size.width-2, self.bgView.frame.size.height-2)];
                         
                     }
                     completion:^(BOOL finished){
                         
                        // [self.accountLab setFrame:CGRectMake(self.accountLab.frame.origin.x-1, self.accountLab.frame.origin.y-1, self.accountLab.frame.size.width+2, self.accountLab.frame.size.height+2)];
                         
                        // [self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x-1, self.bgView.frame.origin.y-1, self.bgView.frame.size.width+2, self.bgView.frame.size.height+2)];
                         
                     }
     ];
    
    
}



@end
