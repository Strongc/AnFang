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
//#import <AlipaySDK/AlipaySDK.h>
//#import "Order.h"
//#import "DataSigner.h"
//#import "payRequsestHandler.h"
//#import "WXApiObject.h"
//#import "WXApi.h"


@interface RechargeViewController ()
{
    UICollectionView *accountCollectionView;
    NSMutableArray *accountArray;
    NSIndexPath *currentSelectedIndex;
    NSIndexPath *previousSelectedIndex;
    NSIndexPath *currentSelectedIndex1;
    NSIndexPath *previousSelectedIndex1;
    UICollectionView *payStyleCollectionView;
    //2088902492111085
    
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
    title.font = [UIFont systemFontOfSize:18];
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    [self.view addSubview:headView];
    
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectMake(10*WIDTH/375, 30*HEIGHT/667, 60*WIDTH/375, 30*HEIGHT/667)];
    UILabel *backTitle = [[UILabel alloc]initWithFrame:CGRectMake(18*WIDTH/375, 7*HEIGHT/667, 32, 16)];
    backTitle.textAlignment = NSTextAlignmentCenter;
    backTitle.text = @"返回";
    backTitle.font = [UIFont systemFontOfSize:16];
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
    [commitBtn addTarget:self action:@selector(doAliPay) forControlEvents:UIControlEventTouchUpInside];
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

- (NSString *)generateTradeNO
{
    static int kNumber = 15;
    
    NSString *sourceStr = @"0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    NSMutableString *resultStr = [[NSMutableString alloc] init];
    srand(time(0));
    for (int i = 0; i < kNumber; i++)
    {
        unsigned index = rand() % [sourceStr length];
        NSString *oneStr = [sourceStr substringWithRange:NSMakeRange(index, 1)];
        [resultStr appendString:oneStr];
    }
    return resultStr;
}



#pragma mark - 支付宝
- (void)doAliPay {
    
    NSString *partner = @"2088021410775742";
    NSString *seller = @"3266924131@qq.com";
    
    NSString *str1 = @"-----BEGIN RSA PRIVATE KEY-----";
    NSString *str3 = @"-----END RSA PRIVATE KEY-----";
    
    NSString *privateKeyTemp = @"MIICeAIBADANBgkqhkiG9w0BAQEFAASCAmIwggJeAgEAAoGBAMqzsWdaz4/iaGvdZEsDYr+VAU5AF/ysnc3Ftj4YAnu1cx9L+fUNKexwBqaeQrVhQ3GSqlAwRADKPJxsMh4wt3F5qdF78nf/V2ONLFE11RHHOwtvIfeUHFuStYldsFg6HjVKpfYkEF4IqKje6ycK9sWhGcfob8PrjvCqigVa8ni9AgMBAAECgYEAgyGeacuArYd9oBI4WKLXFjNyBcpG+ko9SCpYjHEB4j/vOtbu3E3oyjFqzA1kAGzssaN9FKU0yQIMFfGUtp0zfknHMTFyyLouUJbMSxnpDzIqoJZffD9D3fCCjJOOmsBiF26eaprHnjqh4xQLMbE4uFi2pDoh+8DjEDq5IV4E1CECQQDj6as3klBIiz+8yvEUI4but9zmvdyG3fcJgBs2e+8BA5euAoyLyleqUl9cfGsWpLu8ASIldyJ0dXLJAHimneKVAkEA466oN3EmyM2PbOoXmyNccOw6q2NGUp2QpHlfBVd0ZMwMV2llfmSC8kV3cTXHHc5imVRY4QixY36pEsIbyjSbiQJBAM/tSIVEePYWBCorQ9HJr7puB5yDLoPkURJby3fjjWLxchoQvURzb5M130YzREe+NoAI0Kw5ijeRRw1V3ryzYhkCQQDOeQ1DefFaGFAAzSkrHx4tqYxq8FRNh2YsQYTSK0T6Q7DNdF7+B9hYLHbsy4AOn6L6uWsAaAm12J8qy6y36o1BAkB3pLndLIMNNG26MDAHmukP4qRZJ0ho8ECRgP4HWyYsBxhN2DuR76lIHAtHgKuIZ9MK2A6YbyNSu/Sgavsvpaln";
    
    NSString *str2 = [str1 stringByAppendingString:privateKeyTemp];
    NSString *privateKey = [str2 stringByAppendingString:str3];
    
//    Order *order = [[Order alloc] init];
//    order.partner = partner;
//    order.seller = seller;
//    order.tradeNO = [self generateTradeNO]; //订单ID（由商家自行制定）
//    order.productName = @"套餐"; //商品标题
//    order.productDescription = @"安防服务套餐"; //商品描述
//    order.amount = [NSString stringWithFormat:@"%.2f",2.00]; //商品价格
//    order.notifyURL =  @"http://www.xxx.com"; //回调URL
//    
//    order.service = @"mobile.securitypay.pay";
//    order.paymentType = @"1";
//    order.inputCharset = @"utf-8";
//    order.itBPay = @"30m";
//    order.showUrl = @"m.alipay.com";
//    NSString *orderSpec = [order description];
//    
//    //获取私钥并将商户信息签名,外部商户可以根据情况存放私钥和签名,只需要遵循RSA签名规范,并将签名字符串base64编码和UrlEncode
//    id<DataSigner> signer = CreateRSADataSigner(privateKey);
//    NSString *signedString = [signer signString:orderSpec];
//    NSLog(@"私钥：%@",signer);
    
    NSString *appScheme = @"anfang";
    
//    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
//                   orderSpec, signedString, @"RSA"];
//    [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//        
//        NSLog(@"result = %@",resultDic);
//    }];
    
}


-(void)WeiXinPay
{

//    //从服务器获取支付参数，服务端自定义处理逻辑和格式
//    //订单标题
//    NSString *ORDER_NAME    = @"Ios服务器端签名支付 测试";
//    //订单金额，单位（元）
//    NSString *ORDER_PRICE   = @"0.01";
//    
//    //根据服务器端编码确定是否转码
//    NSStringEncoding enc;
//    //if UTF8编码
//    //enc = NSUTF8StringEncoding;
//    //if GBK编码
//    enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    NSString *urlString = [NSString stringWithFormat:@"%@?plat=ios&order_no=%@&product_name=%@&order_price=%@",
//                           SP_URL,
//                           [[NSString stringWithFormat:@"%ld",time(0)] stringByAddingPercentEscapesUsingEncoding:enc],
//                           [ORDER_NAME stringByAddingPercentEscapesUsingEncoding:enc],
//                           ORDER_PRICE];
//    
//    //解析服务端返回json数据
//    NSError *error;
//    //加载一个NSURL对象
//    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//    //将请求的url数据放到NSData对象中
//    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//
//    if ( response != nil) {
//        NSMutableDictionary *dict = NULL;
//        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//        
//        NSLog(@"url:%@",urlString);
//        if(dict != nil){
//            NSMutableString *retcode = [dict objectForKey:@"retcode"];
//            if (retcode.intValue == 0){
//                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//                
//                //调起微信支付
//                PayReq* req             = [[PayReq alloc] init];
//                req.openID              = [dict objectForKey:@"appid"];
//                req.partnerId           = [dict objectForKey:@"partnerid"];
//                req.prepayId            = [dict objectForKey:@"prepayid"];
//                req.nonceStr            = [dict objectForKey:@"noncestr"];
//                req.timeStamp           = stamp.intValue;
//                req.package             = [dict objectForKey:@"package"];
//                req.sign                = [dict objectForKey:@"sign"];
//                [WXApi sendReq:req];
//                //日志输出
//                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",req.openID,req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
//            }else{
//                
//                //[self alert:@"提示信息" msg:[dict objectForKey:@"retmsg"]];
//            }
//        }else{
//            
//            //[self alert:@"提示信息" msg:@"服务器返回错误，未获取到json对象"];
//        }
//    }else{
//        
//        //[self alert:@"提示信息" msg:@"服务器返回错误"];
//    }

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
