//
//  NewFeatureViewController.m
//  AnFang
//
//  Created by MyOS on 15/11/7.
//  Copyright © 2015年 wellgood. All rights reserved.
//

#import "NewFeatureViewController.h"
#import "ViewController.h"
#import "LoginNavigationViewController.h"
#define kCount 4

@interface NewFeatureViewController ()<UIScrollViewDelegate>
{

    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}
@property (weak, nonatomic) IBOutlet UIScrollView *guidScrollView;

@end

@implementation NewFeatureViewController

//-(void)loadView
//{
//
//    UIImageView *imageView = [[UIImageView alloc] init];
//    imageView.frame = [UIScreen mainScreen].bounds;
//    imageView.image = [UIImage imageNamed:@"header_bg.png"];
//    imageView.userInteractionEnabled = YES;
//    self.view = imageView;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize viewSize = self.view.frame.size;
    CGFloat imageH = viewSize.height;
    CGFloat imageY = 0;
    CGFloat imageW = viewSize.width;

    UIImageView *imgView;
    for(int i=0; i< kCount; i++){
    
        imgView = [[UIImageView alloc] init];
        NSString *name = [NSString stringWithFormat:@"newFeature_%d.png",i +1];
        imgView.image = [UIImage imageNamed:name];
        CGFloat imgX = i * viewSize.width;
        imgView.frame = CGRectMake(imgX, imageY, imageW, imageH);
        [self.guidScrollView addSubview:imgView];
        //if(i == kCount - 1){
        
                      // [view addSubview:start];

        //}
        
    }
    self.guidScrollView.contentSize = CGSizeMake(kCount * imageW, 0);
    self.guidScrollView.delegate = self;
    self.guidScrollView.pagingEnabled = YES;
    
    //加载UIPageControl
    UIPageControl *pageControl = [[UIPageControl alloc] init];
    pageControl.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.8);
    pageControl.bounds = CGRectMake(0, 0, 100, 0);
    pageControl.numberOfPages = kCount;
    pageControl.userInteractionEnabled = NO;
    pageControl.currentPage = 0;
    [self.view addSubview:pageControl];
    _pageControl = pageControl;
    
    UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *image = [UIImage imageNamed:@"tiyan.png"];
    [start setBackgroundImage:image forState:UIControlStateNormal];
    start.bounds = CGRectMake(0, 0, image.size.width, image.size.height);
    start.center = CGPointMake(viewSize.width * 0.5, viewSize.height * 0.5);
    [start addTarget:self action:@selector(jumpToMainView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:start];

        // Do any additional setup after loading the view.
}



-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{

    CGFloat offsetX = scrollView.contentOffset.x;
    offsetX = offsetX + (scrollView.frame.size.width * 0.5);
    
    int page = offsetX / scrollView.frame.size.width;
    
    _pageControl.currentPage = page;

}

-(void)jumpToMainView
{
     UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
     LoginNavigationViewController *loginView = [mainView instantiateViewControllerWithIdentifier:@"loginNavId"];
    
     self.view.window.rootViewController = loginView;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
