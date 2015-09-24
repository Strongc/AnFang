//
//  RechargeViewController.m
//  AnBao
//
//  Created by mac   on 15/9/21.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "RechargeViewController.h"
#import "Common.h"
#import "AccountCollectionViewCell.h"
#import "UIColor+Extensions.h"
#import "PayStyle.h"
#import "PayStyleCollectionViewCell.h"
//#import "AFNetworking.h"
//#import "BCPaySDK/Channel/PayPal/PayPalMobile.h"


@interface RechargeViewController ()
{
    UICollectionView *accountCollectionView;
    NSMutableArray *accountArray;
    NSIndexPath *currentSelectedIndex;
    NSIndexPath *previousSelectedIndex;
    NSIndexPath *currentSelectedIndex1;
    NSIndexPath *previousSelectedIndex1;
    UICollectionView *payStyleCollectionView;
    
}

@property (nonatomic,strong) NSArray *styleIcon;

@end

@implementation RechargeViewController

-(NSArray *)styleIcon
{
    if(_styleIcon == nil){
    
        //1.获取PayStyleIcon.plist文件的路径
        NSString *path = [[NSBundle mainBundle] pathForResource:@"PayStyleIcon.plist" ofType:nil];
        //2.根据路径加载数据
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        
        //3.创建一个可变数组来保存一个一个对象
        NSMutableArray *arrayModels = [NSMutableArray array];
        
        //4.循环字典数组，把每个字典对象转化成一个模型对象
        for(NSDictionary *dict in arrayDict){
        
            PayStyle *model = [PayStyle appWithDict:dict];
        
            [arrayModels addObject:model];
        }
        
        _styleIcon = arrayModels;
        
    }

    return _styleIcon;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initControl];
     accountArray = [[NSMutableArray alloc]initWithObjects:@"10元", @"50元",@"100元",@"200元",nil];
    // Do any additional setup after loading the view.
}

-(void)initControl
{

    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 64*HEIGHT/667)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 20*HEIGHT/667, WIDTH, 50*HEIGHT/667)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"充值";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH/375, 7*HEIGHT/667, 32, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont systemFontOfSize:16*WIDTH/375];
    backTitle.textColor = [UIColor whiteColor];
    [backBtn addSubview:backTitle];
    
    UIImageView *backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 5*HEIGHT/667, 20, 20)];
    backImage.image = [UIImage imageNamed:@"back.png"];
    [backBtn addSubview:backImage];
    [backBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(20*WIDTH/375, 94*HEIGHT/667, 75*WIDTH/375, 15*HEIGHT/667)];
    title2.text = @"充值金额:";
    title2.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    title2.textColor = [UIColor blackColor];
    [self.view addSubview:title2];
    
    UICollectionViewFlowLayout *flowLayout2 = [[UICollectionViewFlowLayout alloc] init];
    UICollectionViewFlowLayout *flowLayout1 = [[UICollectionViewFlowLayout alloc] init];

    accountCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 120*HEIGHT/667, WIDTH-20, 40*HEIGHT/667) collectionViewLayout:flowLayout1];
    accountCollectionView.delegate = self;
    accountCollectionView.dataSource = self;
    accountCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:accountCollectionView];
    [accountCollectionView registerClass:[AccountCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    UILabel *otherAccountLab = [[UILabel alloc]initWithFrame:CGRectMake(20*WIDTH/375, 170*HEIGHT/667, 75*WIDTH/375, 15*HEIGHT/667)];
    otherAccountLab.text = @"其他金额:";
    otherAccountLab.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    otherAccountLab.textColor = [UIColor blackColor];
    [self.view addSubview:otherAccountLab];
    
    UITextField *txtAccount = [[UITextField alloc]initWithFrame:CGRectMake(100*WIDTH/375, 165*HEIGHT/667, 90*WIDTH/375, 30*HEIGHT/667)];
    txtAccount.borderStyle = UITextBorderStyleLine;
    txtAccount.layer.borderWidth = 1.5;
    txtAccount.layer.borderColor = [[UIColor colorWithHexString:@"ededed"]CGColor];
    [self.view addSubview:txtAccount];
    
    
    UILabel *payStyleLab = [[UILabel alloc]initWithFrame:CGRectMake(20*WIDTH/375, 210*HEIGHT/667, 75*WIDTH/375, 15*HEIGHT/667)];
    payStyleLab.text = @"支付方式:";
    payStyleLab.font = [UIFont boldSystemFontOfSize:15*WIDTH/375];
    payStyleLab.textColor = [UIColor blackColor];
    [self.view addSubview:payStyleLab];

    payStyleCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20*WIDTH/375, 230*HEIGHT/667, WIDTH-20, 60*HEIGHT/667) collectionViewLayout:flowLayout2];
    payStyleCollectionView.delegate = self;
    payStyleCollectionView.dataSource = self;
    payStyleCollectionView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:payStyleCollectionView];
    [payStyleCollectionView registerClass:[PayStyleCollectionViewCell class] forCellWithReuseIdentifier:@"styleCell"];
    
    UIButton *commitBtn = [[UIButton alloc]initWithFrame:CGRectMake(120*WIDTH/375, 400*HEIGHT/667, 135*WIDTH/375, 40*HEIGHT/667)];
    [commitBtn setTitle:@"提交订单" forState:UIControlStateNormal];
    [commitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [commitBtn setBackgroundColor:[UIColor orangeColor]];
    [commitBtn setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    commitBtn.titleLabel.font = [UIFont boldSystemFontOfSize:18*WIDTH/375];
    [commitBtn addTarget:self action:@selector(doUnionPay) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    
}

-(void)backAction
{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma mark UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger n;
    if(collectionView == accountCollectionView){
        
        n = 4;
    
    }else if (collectionView == payStyleCollectionView){
    
        n = 3;
    }
    
        return n;
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *identifyId = @"cell";
    static NSString *identifyIdStyle = @"styleCell";
    UICollectionViewCell *cell;
    
    if(collectionView == accountCollectionView){
    
        AccountCollectionViewCell *accountCell = (AccountCollectionViewCell *)[accountCollectionView dequeueReusableCellWithReuseIdentifier:identifyId forIndexPath:indexPath];
        
        accountCell.accountLab.text = [accountArray objectAtIndex:indexPath.item];
        BOOL isSelected = [indexPath isEqual:currentSelectedIndex];
        BOOL isDeselectedShouldAnimate = currentSelectedIndex != nil && [indexPath isEqual:currentSelectedIndex];
        
        [accountCell setHightlightBackground:isSelected withAimate:isDeselectedShouldAnimate];
        
        cell = accountCell;
    
    }else if (collectionView == payStyleCollectionView){
        
        PayStyleCollectionViewCell *payStyleCell = (PayStyleCollectionViewCell *)[payStyleCollectionView dequeueReusableCellWithReuseIdentifier:identifyIdStyle forIndexPath:indexPath];
        
        PayStyle *model = [self.styleIcon objectAtIndex:indexPath.item];
        
        NSString *name = model.icon;
        payStyleCell.payStyle.image = [UIImage imageNamed:name];
        BOOL isSelected = [indexPath isEqual:currentSelectedIndex1];
        BOOL isDeselectedShouldAnimate = currentSelectedIndex1 != nil && [indexPath isEqual:currentSelectedIndex1];
        
        [payStyleCell setHightlightBackground:isSelected withAimate:isDeselectedShouldAnimate];
        payStyleCell.backgroundColor = [UIColor blueColor];
        
        cell = payStyleCell;

    
    }

    
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout

//定义每个cell的大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGSize size;
    if(collectionView == accountCollectionView){
    
        size = CGSizeMake((WIDTH-75)/4, 30*HEIGHT/667);
    }else if (collectionView == payStyleCollectionView){
    
        size = CGSizeMake((WIDTH-90)/3, 50*HEIGHT/667);
    }
    
    return size;
}

//设置每组cell的边界
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    UIEdgeInsets edge;
    
    if(collectionView == accountCollectionView){
    
        edge = UIEdgeInsetsMake(0, 10, 0, 10);//上,左，下，右
    
    }else if (collectionView == payStyleCollectionView){
    
        edge = UIEdgeInsetsMake(0, 17.5, 0, 17.5);//上,左，下，右
    }
    
    return edge;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    
    CGFloat n;
    if(collectionView == accountCollectionView){
    
        n = 0;
        
    }else if (collectionView == payStyleCollectionView){
    
        n =0;
    }
    
    return n;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    
    CGFloat n;
    if(collectionView == accountCollectionView){
        
        n = 0;
    }else if (collectionView == payStyleCollectionView){
        
        n =0;
    }
    
    return n;

}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    
    if(collectionView == accountCollectionView){
    
        previousSelectedIndex = currentSelectedIndex;
        
        if ([currentSelectedIndex isEqual:indexPath] ) {
            
            currentSelectedIndex = nil;
            
        } else {
            
            currentSelectedIndex = indexPath;
            
        }
        
        [accountCollectionView reloadData];

    }else if (collectionView == payStyleCollectionView){
        
        previousSelectedIndex1 = currentSelectedIndex1;
        
        if ([currentSelectedIndex1 isEqual:indexPath] ) {
            
            currentSelectedIndex1 = nil;
            
        } else {
            
            currentSelectedIndex1 = indexPath;
            
        }
        
        [payStyleCollectionView reloadData];

    }

}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 银联在线
- (void)doUnionPay {
   // [self doPay:PayChannelUnApp];
}

//#pragma mark - 生成订单号
//- (NSString *)genOutTradeNo {
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"yyyyMMddHHmmssSSS"];
//    return [formatter stringFromDate:[NSDate date]];
//}
//
//
//- (void)doPay:(PayChannel)channel {
//    NSString *outTradeNo = [self genOutTradeNo];
//    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"value",@"key", nil];
//    
//    BCPayReq *payReq = [[BCPayReq alloc] init];
//    payReq.channel = channel;
//    payReq.title = billTitle;
//    payReq.totalfee = @"1";
//    payReq.billno = outTradeNo;
//    payReq.scheme = @"payDemo";
//    payReq.viewController = self;
//    payReq.optional = dict;
//    [BeeCloud sendBCReq:payReq];
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