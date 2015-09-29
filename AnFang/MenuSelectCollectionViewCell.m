//
//  MenuSelectCollectionViewCell.m
//  AnBao
//
//  Created by mac   on 15/9/22.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "MenuSelectCollectionViewCell.h"
#import "Common.h"
#import "UIColor+Extensions.h"

@implementation MenuSelectCollectionViewCell

-(void)setMenuSelect:(MenuSelect *)menuSelect
{
    _menuSelect = menuSelect;
    
    self.icon.image = [UIImage imageNamed:menuSelect.icon];
    self.styleLab.text = menuSelect.name;
    self.menuIndruction.text = menuSelect.intruction;
    


}

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self){
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        UIView *backgroundView = [[UIView alloc]initWithFrame:CGRectMake(10*WIDTH/375, 0, 155, 75)];
        backgroundView.layer.borderWidth = 1.5;
        backgroundView.layer.borderColor = [[UIColor colorWithHexString:@"87cefa"]CGColor];
        [self.contentView addSubview:backgroundView];
        
        UIImageView * icon= [[UIImageView alloc]initWithFrame:CGRectMake(20*WIDTH/375, 10*HEIGHT/667,50*WIDTH/375, 50*HEIGHT/667)];
        [self.contentView addSubview:icon];
        self.icon = icon;
        
        UILabel *styleLab = [[UILabel alloc]initWithFrame:CGRectMake(70*WIDTH/375, 10*HEIGHT/667, 80*WIDTH/375, 13*HEIGHT/667)];
        styleLab.font = [UIFont boldSystemFontOfSize:12*WIDTH/375];
        styleLab.textAlignment = NSTextAlignmentCenter;
        styleLab.textColor = [UIColor blackColor];
        [self.contentView addSubview:styleLab];
        self.styleLab = styleLab;
        
        UILabel *menuIndruction = [[UILabel alloc]initWithFrame:CGRectMake(80*WIDTH/375, 20*HEIGHT/667, 80*WIDTH/375, 40*HEIGHT/667)];
        
        menuIndruction.numberOfLines = 0;
        menuIndruction.font = [UIFont boldSystemFontOfSize:11*WIDTH/375];
        menuIndruction.textColor = [UIColor colorWithHexString:@"bababa"];
        [self.contentView addSubview:menuIndruction];
        self.menuIndruction = menuIndruction;
        
    }
    
    return self;
}


@end
