//
//  PayStyleCollectionViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "PayStyleCollectionViewCell.h"
#import "UIColor+Extensions.h"
#import "Common.h"

@implementation PayStyleCollectionViewCell

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self){
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIImageView * payStyle= [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,95*WIDTH/375, 50*HEIGHT/667)];
        payStyle.layer.borderWidth = 1.5;
        payStyle.layer.borderColor = [[UIColor clearColor]CGColor];
      
        [self.contentView addSubview:payStyle];
        self.payStyle = payStyle;
        
        
        
        
    }
    
    return self;
}

- (void)setHightlightBackground:(BOOL)isSelected withAimate:(BOOL)animate
{
    [self.payStyle.layer removeAllAnimations];
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
    
    self.payStyle.layer.borderColor = [[UIColor clearColor]CGColor];
    
    if (animate) {
        
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [self.payStyle setFrame:CGRectMake(self.payStyle.frame.origin.x+1, self.payStyle.frame.origin.y+1, self.payStyle.frame.size.width-2, self.payStyle.frame.size.height-2)];
                             
                             //[self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x+1, self.bgView.frame.origin.y+1, self.bgView.frame.size.width-2, self.bgView.frame.size.height-2)];
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self.payStyle setFrame:CGRectMake(self.payStyle.frame.origin.x-1, self.payStyle.frame.origin.y-1, self.payStyle.frame.size.width+2, self.payStyle.frame.size.height+2)];
                             
                             //[self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x-1, self.bgView.frame.origin.y-1, self.bgView.frame.size.width+2, self.bgView.frame.size.height+2)];
                             
                         }
         ];
        
    }
    
    // self.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    
}

- (void)setHightlightBackground
{
    
    self.payStyle.layer.borderColor = [[UIColor colorWithHexString:@"87cefa"]CGColor];
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
