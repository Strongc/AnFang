//
//  AnFangTabBarViewController.m
//  AnBao
//
//  Created by mac   on 15/9/11.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "AnFangTabBarViewController.h"
#import "AnFangTabBar.h"
#import "Common.h"

@interface AnFangTabBarViewController ()<UIScrollViewDelegate,AnFangTabBarDelegate>
{
    NSInteger       _currentIndex;              // current page index
    NSMutableArray  *_titles;                   // array of children view controller's title
    
    AnFangTabBar     *_navTabBar;                // NavTabBar: press item on it to exchange view
    UIScrollView    *_mainView;

}

@end

@implementation AnFangTabBarViewController

- (id)initWithShowArrowButton:(BOOL)show
{
    self = [super init];
    if (self)
    {
        _showArrowButton = show;
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subViewControllers
{
    self = [super init];
    if (self)
    {
        _subViewControllers = subViewControllers;
    }
    return self;
}

- (id)initWithParentViewController:(UIViewController *)viewController
{
    self = [super init];
    if (self)
    {
        [self addParentController:viewController];
    }
    return self;
}

- (id)initWithSubViewControllers:(NSArray *)subControllers andParentViewController:(UIViewController *)viewController showArrowButton:(BOOL)show;
{
    self = [self initWithSubViewControllers:subControllers];
    
    _showArrowButton = show;
    [self addParentController:viewController];
    return self;
}



- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initConfig];
    [self viewConfig];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods
#pragma mark -
- (void)initConfig
{
    // Iinitialize value
    _currentIndex = 1;
    _navTabBarColor = _navTabBarColor ? _navTabBarColor : NavTabbarColor;
    
    // Load all title of children view controllers
    _titles = [[NSMutableArray alloc] initWithCapacity:_subViewControllers.count];
    for (UIViewController *viewController in _subViewControllers)
    {
        [_titles addObject:viewController.title];
    }
}

- (void)viewInit
{
    
    //self.view.backgroundColor = [UIColor whiteColor];
    //NAV_TAB_BAR_HEIGHT
    // Load NavTabBar and content view to show on window
    // _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(80, 30, SCREEN_WIDTH-40, 40) showArrowButton:_showArrowButton];
    //_navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(DOT_COORDINATE, 20, SCREEN_WIDTH, 20)];
    //     _navTabBar = [[SCNavTabBar alloc] initWithFrame:CGRectMake(80, 20, SCREEN_WIDTH-40, 40) showArrowButton:_showArrowButton];
    _navTabBar = [[AnFangTabBar alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64*HEIGHT/667) showArrowButton:_showArrowButton];
    
    _navTabBar.delegate = self;
    //_navTabBar.backgroundColor = _navTabBarColor
    _navTabBar.backgroundColor = [UIColor grayColor];
    
    _navTabBar.lineColor = [UIColor whiteColor];
    _navTabBar.itemTitles = _titles;
    // _navTabBar.arrowImage = _navTabBarArrowImage;
    [_navTabBar updateData];
    
    //    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _navTabBar.frame.origin.y + _navTabBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT - _navTabBar.frame.origin.y - _navTabBar.frame.size.height - STATUS_BAR_HEIGHT - NAVIGATION_BAR_HEIGHT)];
    
    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _navTabBar.frame.origin.y + _navTabBar.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT )];
    
    //    _mainView = [[UIScrollView alloc] initWithFrame:CGRectMake(DOT_COORDINATE, _navTabBar.frame.origin.y , SCREEN_WIDTH, SCREEN_HEIGHT )];
    
    _mainView.delegate = self;
    _mainView.pagingEnabled = YES;
    _mainView.backgroundColor = [UIColor whiteColor];
    _mainView.bounces = _mainViewBounces;
    _mainView.showsHorizontalScrollIndicator = NO;
    _mainView.contentSize = CGSizeMake(SCREEN_WIDTH * _subViewControllers.count, DOT_COORDINATE);
    
    UIImageView* imgView=[[UIImageView alloc]init];
    UIImage* img=[[UIImage alloc]init];
    img=[UIImage imageNamed:@"back"];
    [imgView setImage:img];
    //[self.backBtn addSubview:imgView];
    //    self.backBtn = [[UIButton alloc] initWithFrame:CGRectMake(16, 20, 30, 30)];
    //    [self.backBtn setBackgroundImage:[UIImage imageNamed:@"bt_back2"] forState:UIControlStateNormal];
    //
    //    [self.backBtn addTarget:self action:@selector(closeView) forControlEvents:UIControlEventTouchUpInside];
    //
    //    [self.view addSubview:backBtn];
    [self.view addSubview:_mainView];
    [self.view addSubview:_navTabBar];
    
    // [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"999999"], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    
    //[[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithHexString:@"333333"], NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];
    
}

-(void)closeView{
    
    //[SVProgressHUD showInfoWithStatus:@"wwwwww"];
    //    [self dismissViewControllerAnimated:NO completion:nil];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)viewConfig
{
    [self viewInit];
    
    // Load children view controllers and add to content view
    [_subViewControllers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop){
        
        UIViewController *viewController = (UIViewController *)_subViewControllers[idx];
        viewController.view.frame = CGRectMake(idx * SCREEN_WIDTH, DOT_COORDINATE, SCREEN_WIDTH, _mainView.frame.size.height);
        [_mainView addSubview:viewController.view];
        [self addChildViewController:viewController];
    }];
}

#pragma mark - Public Methods
#pragma mark -
- (void)setNavTabbarColor:(UIColor *)navTabbarColor
{
    // prevent set [UIColor clear], because this set can take error display
    CGFloat red, green, blue, alpha;
    if ([navTabbarColor getRed:&red green:&green blue:&blue alpha:&alpha] && !red && !green && !blue && !alpha)
    {
        navTabbarColor = NavTabbarColor;
    }
    _navTabBarColor = navTabbarColor;
}

- (void)addParentController:(UIViewController *)viewController
{
    // Close UIScrollView characteristic on IOS7 and later
    if ([viewController respondsToSelector:@selector(edgesForExtendedLayout)])
    {
        viewController.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    [viewController addChildViewController:self];
    [viewController.view addSubview:self.view];
}

#pragma mark - Scroll View Delegate Methods
#pragma mark -
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"hideKeyBoard" object:nil];
    _currentIndex = scrollView.contentOffset.x / SCREEN_WIDTH;
    _navTabBar.currentItemIndex = _currentIndex;
    
}

#pragma mark - SCNavTabBarDelegate Methods
#pragma mark -
- (void)itemDidSelectedWithIndex:(NSInteger)index
{
    [_mainView setContentOffset:CGPointMake(index * SCREEN_WIDTH, DOT_COORDINATE) animated:_scrollAnimation];
}

//- (void)shouldPopNavgationItemMenu:(BOOL)pop height:(CGFloat)height
//{
//    if (pop)
//    {
//        [UIView animateWithDuration:0.5f animations:^{
//            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, height + NAV_TAB_BAR_HEIGHT);
//        }];
//    }
//    else
//    {
//        [UIView animateWithDuration:0.5f animations:^{
//            _navTabBar.frame = CGRectMake(_navTabBar.frame.origin.x, _navTabBar.frame.origin.y, _navTabBar.frame.size.width, NAV_TAB_BAR_HEIGHT);
//        }];
//    }
//    [_navTabBar refresh];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
