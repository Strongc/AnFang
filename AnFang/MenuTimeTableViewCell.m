//
//  MenuTimeTableViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuTimeTableViewCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@implementation MenuTimeTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if(self){
        
        UILabel *menuTime = [[UILabel alloc]initWithFrame:CGRectMake(45*WIDTH/375, 5*HEIGHT/667, 160*WIDTH/375, 50*HEIGHT/667)];
        menuTime.textColor = [UIColor blackColor];
        menuTime.font = [UIFont systemFontOfSize:15*WIDTH/375];
        menuTime.backgroundColor = [UIColor colorWithHexString:@"ededed"];
        menuTime.layer.borderWidth = 1.5;
        menuTime.layer.borderColor = [[UIColor clearColor]CGColor];
        menuTime.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:menuTime];
        self.menuTime = menuTime;
        
        UILabel *menuPrice = [[UILabel alloc]initWithFrame:CGRectMake(210*WIDTH/375, 25*HEIGHT/667, 60*WIDTH/375, 15*HEIGHT/667)];
        menuPrice.textColor = [UIColor blackColor];
        menuPrice.font = [UIFont systemFontOfSize:15*WIDTH/375];
        menuPrice.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:menuPrice];
        self.menuPrice = menuPrice;
        
    }
    
    return self;
    
}

- (void)setHightlightBackground:(BOOL)isSelected withAimate:(BOOL)animate
{
    [self.menuTime.layer removeAllAnimations];
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
    
    self.menuTime.layer.borderColor = [[UIColor clearColor]CGColor];
    self.menuPrice.textColor = [UIColor blackColor];
    
    if (animate) {
        
        [UIView animateWithDuration:0.2f
                              delay:0.0f
                            options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionAllowUserInteraction
                         animations:^{
                             
                             [self.menuTime setFrame:CGRectMake(self.menuTime.frame.origin.x+1, self.menuTime.frame.origin.y+1, self.menuTime.frame.size.width-2, self.menuTime.frame.size.height-2)];
                             
                             //[self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x+1, self.bgView.frame.origin.y+1, self.bgView.frame.size.width-2, self.bgView.frame.size.height-2)];
                             
                         }
                         completion:^(BOOL finished){
                             
                             [self.menuTime setFrame:CGRectMake(self.menuTime.frame.origin.x-1, self.menuTime.frame.origin.y-1, self.menuTime.frame.size.width+2, self.menuTime.frame.size.height+2)];
                             
                             //[self.bgView setFrame:CGRectMake(self.bgView.frame.origin.x-1, self.bgView.frame.origin.y-1, self.bgView.frame.size.width+2, self.bgView.frame.size.height+2)];
                             
                         }
         ];
        
    }
    
    // self.bgView.layer.borderColor = [UIColor clearColor].CGColor;
    
}

- (void)setHightlightBackground
{
    
    self.menuTime.layer.borderColor = [[UIColor colorWithHexString:@"87cefa"]CGColor];
    self.menuPrice.textColor = [UIColor greenColor];
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
