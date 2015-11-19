//
//  AnFangTabBar.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AnFangTabBar.h"
#import "UIColor+Extensions.h"
#import "Common.h"

@interface AnFangTabBar()
{
    UIScrollView    *_navgationTabBar;      // all items on this scroll view
    UIImageView     *_arrowButton;          // arrow button
    
    UIView          *_line;
    UIImageView     *_imageView;
    // underscore show which item selected
   // SCPopView       *_popView;              // when item menu, will show this view
    
    NSMutableArray  *_items;                // SCNavTabBar pressed item
    NSArray         *_itemsWidth;           // an array of items' width
    BOOL            _showArrowButton;       // is showed arrow button
    BOOL            _popItemMenu;    // is needed pop item menu
    UIButton      *_selectBtn;
}

@end

@implementation AnFangTabBar

- (id)initWithFrame:(CGRect)frame showArrowButton:(BOOL)show
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _showArrowButton = show;
        [self initConfig];
    }
    return self;
}

#pragma mark -
#pragma mark - Private Methods

- (void)initConfig
{
    _items = [@[] mutableCopy];
    _arrowImage = [UIImage imageNamed:SCNavTabbarSourceName(@"back")];
    
    [self viewConfig];
    [self addTapGestureRecognizer];
}

- (void)viewConfig
{
    
    CGFloat functionButtonX = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    //    if (_showArrowButton)
    //    {
    _arrowButton = [[UIImageView alloc] initWithFrame:CGRectMake(2, DOT_COORDINATE, 30, 30)];
    _arrowButton.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    _itemImageArray = [[NSArray alloc] initWithObjects:@"human", @"house",nil];
    _itemImageSelectArray = [[NSArray alloc] initWithObjects:@"humanSelect",@"houseSelect", nil];
   // _arrowButton.userInteractionEnabled = YES;
    
    //[self addSubview:_arrowButton];
  //  [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
    
   // UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
   // [_arrowButton addGestureRecognizer:tapGestureRecognizer];
    //}
    
    _navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, functionButtonX, 64)];
    _navgationTabBar.scrollEnabled = NO;
    //_navgationTabBar = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, DOT_COORDINATE, functionButtonX, NAV_TAB_BAR_HEIGHT)];
    _navgationTabBar.showsHorizontalScrollIndicator = NO;
    [self addSubview:_navgationTabBar];
    
    //[self viewShowShadow:self shadowRadius:10.0f shadowOpacity:10.0f];
}


- (void)showLineWithButtonWidth:(CGFloat)width
{
    _line = [[UIView alloc] initWithFrame:CGRectMake(13 + 10, NAV_TAB_BAR_HEIGHT - 10.0f, 66, 2.0f)];
    _line.backgroundColor = [UIColor colorWithHexString:@"333333"];
    //_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(23,  NAV_TAB_BAR_HEIGHT - 10.0f, 66, 2.0f)];
    
    // backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 0, 20, 20)];
    //backBtn.titleLabel.text = @"返回";
    //[self.view addSubview:backBtn];
    
    // [_navgationTabBar addSubview:_line];
    //[_navgationTabBar addSubview:backBtn];
}



- (CGFloat)contentWidthAndAddNavTabBarItemsWithButtonsWidth:(NSArray *)widths
{
    CGFloat buttonX = 70;
    for (NSInteger index = 0; index < [_itemTitles count]; index++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        //UIImageView *tabImageView = [[UIImageView alloc] initWithFrame:CGRectMake(, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)];
        button.frame = CGRectMake(buttonX, 25.0, [widths[index] floatValue], 30);
        //button.frame = CGRectMake(buttonX, 15.0, 100*WIDTH/375, 44);
        //[button setTitle:_itemTitles[index] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont boldSystemFontOfSize:20*WIDTH/375];
        [button setBackgroundImage:[UIImage imageNamed:_itemImageArray[index]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:_itemImageSelectArray[index]] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateSelected];
        [button addTarget:self action:@selector(itemPressed:) forControlEvents:UIControlEventTouchUpInside];
        //button.backgroundColor = [UIColor redColor];
        [_navgationTabBar addSubview:button];
        
        [_items addObject:button];
        buttonX += [widths[index] floatValue] + (WIDTH - 2*30  -140);
        // buttonX += [widths[index] floatValue]*WIDTH/375;
        //buttonX += 140*WIDTH/375;
        if (index == 0) {
            _selectBtn = button;
            button.selected = YES;
        }
    }
    
      return buttonX;
}


- (void)addTapGestureRecognizer
{
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(functionButtonPressed)];
    [_arrowButton addGestureRecognizer:tapGestureRecognizer];
}

- (void)itemPressed:(UIButton *)button
{
    NSInteger index = [_items indexOfObject:button];
    [_delegate itemDidSelectedWithIndex:index];
}

- (void)functionButtonPressed
{
    _popItemMenu = !_popItemMenu;
    [_delegate shouldPopNavgationItemMenu:_popItemMenu height:[self popMenuHeight]];
}

- (NSArray *)getButtonsWidthWithTitles:(NSArray *)titles;
{
    NSMutableArray *widths = [@[] mutableCopy];
    
    for (NSString *title in titles)
    {
        CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:[UIFont systemFontSize]]];
       // NSNumber *width = [NSNumber numberWithFloat:size.width + 40.0f];
        NSNumber *width =[NSNumber numberWithInt: 30.0f];
        [widths addObject:width];
    }
    
    return widths;
}

- (void)viewShowShadow:(UIView *)view shadowRadius:(CGFloat)shadowRadius shadowOpacity:(CGFloat)shadowOpacity
{
    view.layer.shadowRadius = shadowRadius;
    view.layer.shadowOpacity = shadowOpacity;
}

- (CGFloat)popMenuHeight
{
    CGFloat buttonX = DOT_COORDINATE;
    CGFloat buttonY = ITEM_HEIGHT;
    CGFloat maxHeight = SCREEN_HEIGHT - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT - NAV_TAB_BAR_HEIGHT;
    for (NSInteger index = 0; index < [_itemsWidth count]; index++)
    {
        buttonX += [_itemsWidth[index] floatValue];
        
        @try {
            if ((buttonX + [_itemsWidth[index + 1] floatValue]) >= SCREEN_WIDTH)
            {
                buttonX = DOT_COORDINATE;
                buttonY += ITEM_HEIGHT;
            }
        }
        @catch (NSException *exception) {
            
        }
        @finally {
            
        }
    }
    
    buttonY = (buttonY > maxHeight) ? maxHeight : buttonY;
    return buttonY;
}

//- (void)popItemMenu:(BOOL)pop
//{
//    if (pop)
//    {
//        [self viewShowShadow:_arrowButton shadowRadius:DOT_COORDINATE shadowOpacity:DOT_COORDINATE];
//        [UIView animateWithDuration:0.5f animations:^{
//            _navgationTabBar.hidden = YES;
//            _arrowButton.transform = CGAffineTransformMakeRotation(M_PI);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2f animations:^{
//                if (!_popView)
//                {
//                    _popView = [[SCPopView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, NAVIGATION_BAR_HEIGHT, SCREEN_WIDTH, self.frame.size.height - NAVIGATION_BAR_HEIGHT)];
//                    _popView.delegate = self;
//                    _popView.itemNames = _itemTitles;
//                    [self addSubview:_popView];
//                }
//                _popView.hidden = NO;
//            }];
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:0.5f animations:^{
//            _popView.hidden = !_popView.hidden;
//            _arrowButton.transform = CGAffineTransformIdentity;
//        } completion:^(BOOL finished) {
//            _navgationTabBar.hidden = !_navgationTabBar.hidden;
//            [self viewShowShadow:_arrowButton shadowRadius:20.0f shadowOpacity:20.0f];
//        }];
//    }
//}

#pragma mark -
#pragma mark - Public Methods
- (void)setArrowImage:(UIImage *)arrowImage
{
    _arrowImage = arrowImage ? arrowImage : _arrowImage;
    _arrowButton.image = _arrowImage;
}


- (void)setCurrentItemIndex:(NSInteger)currentItemIndex
{
    _currentItemIndex = currentItemIndex;
    UIButton *button = _items[currentItemIndex];
    CGFloat flag = _showArrowButton ? (SCREEN_WIDTH - ARROW_BUTTON_WIDTH) : SCREEN_WIDTH;
    
    if (button.frame.origin.x + button.frame.size.width > flag)
    {
        CGFloat offsetX = button.frame.origin.x + button.frame.size.width;
        if (_currentItemIndex < [_itemTitles count] - 1)
        {
            offsetX = offsetX + 40.0f;
        }
        
        [_navgationTabBar setContentOffset:CGPointMake(offsetX, DOT_COORDINATE) animated:YES];
    }
    else
    {
        [_navgationTabBar setContentOffset:CGPointMake(DOT_COORDINATE, DOT_COORDINATE) animated:YES];
    }
    
    [UIView animateWithDuration:0.2f animations:^{
        _line.frame = CGRectMake(button.frame.origin.x + 15.0f, _line.frame.origin.y, 66, _line.frame.size.height);
        //        button.selected = YES;
        _selectBtn.selected = NO;
        _selectBtn = button;
        _selectBtn.selected = YES;
    }];
}


- (void)updateData
{
    _arrowButton.backgroundColor = self.backgroundColor;
    
    _itemsWidth = [self getButtonsWidthWithTitles:_itemTitles];
    if (_itemsWidth.count)
    {
        CGFloat contentWidth = [self contentWidthAndAddNavTabBarItemsWithButtonsWidth:_itemsWidth];
        _navgationTabBar.contentSize = CGSizeMake(contentWidth, DOT_COORDINATE);
    }
}

- (void)refresh
{
    //[self popItemMenu:_popItemMenu];
}

#pragma mark - SCFunctionView Delegate Methods
#pragma mark -
- (void)itemPressedWithIndex:(NSInteger)index
{
    [self functionButtonPressed];
    [_delegate itemDidSelectedWithIndex:index];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
