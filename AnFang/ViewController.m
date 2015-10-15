//
//  ViewController.m
//  AnFang
//
//  Created by mac   on 15/9/24.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "ViewController.h"
#import "UIColor+Extensions.h"
#import "UIView+KGViewExtend.h"
#import "Common.h"
#import "GradientButton.h"
#import "MenuTabBarViewController.h"
#import "RSA.h"
#import "JSONKit.h"
#import "Security.h"
#import "Base64.h"
//#import "BigInt.h"
#import "JKBigInteger.h"
//#import "StringToBytes.h"
#import "RsaFactory.h"

@interface ViewController ()
{
    GradientButton *loginBtn;
    NSString *token;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithHexString:@"1e90ff"]];
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, WIDTH, 35)];
    //self.navigationController.navigationBar.b
    UIImageView *headView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 60)];
    [headView setImage:[UIImage imageNamed:@"header_bg.png"]];
    
    UILabel *title = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 50)];
    title.textAlignment = NSTextAlignmentCenter;
    title.text = @"登录";
    title.textColor = [UIColor whiteColor];
    [headView addSubview:title];
    //[self.view addSubview:headView];
    
    UIButton *regBtn = [[UIButton alloc]initWithFrame:CGRectMake(WIDTH-50, 15, 40, 40)];
    [self.view addSubview:regBtn];
    [regBtn setTitle:@"注册" forState:UIControlStateNormal];
    regBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    regBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [regBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    //[regBtn addTarget:self action:@selector(gotoRegisterView) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view setBackgroundColor:[UIColor colorWithHexString:@"ededed"]];
    
    UIView *inputView = [[UIView alloc] initWithFrame:CGRectMake(0, (headView.bottom+20)*WIDTH/375, self.view.width, 100*WIDTH/375)];
    inputView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:inputView];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [inputView addSubview:line1];
    
    UIView *line2  = [[UIView alloc] initWithFrame:CGRectMake(10*WIDTH/375, 50*WIDTH/375, self.view.width-20*WIDTH/375, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [inputView addSubview:line2];
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0,100*WIDTH/375, self.view.width, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"ededed"];
    [inputView addSubview:line3];
    
    loginBtn = [[GradientButton alloc] initWithFrame:CGRectMake(15*WIDTH/375, 220*WIDTH/375, self.view.width-30*WIDTH/375, 40*WIDTH/375)];
    
    UILabel *title2 = [[UILabel alloc]initWithFrame:CGRectMake(150*WIDTH/375, 0, 40*WIDTH/375, 40*WIDTH/375)];
    title2.text = @"登录";
    title2.textColor = [UIColor whiteColor];
    [loginBtn addSubview:title2];
    [loginBtn useGreenConfirmStyle];
    [self.view addSubview:loginBtn];
    [loginBtn addTarget:self action:@selector(initViewController) forControlEvents:UIControlEventTouchUpInside];
    
    name = [[UITextField alloc] initWithFrame:CGRectMake(10*WIDTH/375, 5*WIDTH/375, self.view.width-20*WIDTH/375, 40*WIDTH/375)];
    [inputView addSubview:name];
    name.placeholder = @"手机号／邮箱／用户名";
    
    passWordField = [[UITextField alloc]initWithFrame:CGRectMake(10*WIDTH/375, 50*WIDTH/375, self.view.width-20*WIDTH/375, 40*WIDTH/375)];
    [inputView addSubview:passWordField];
    passWordField.placeholder = @"密码";
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] init];
    item.title = @"返回";
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];//设置导航栏返回按钮及文字背景颜色
    //self.navigationController.navigationBar.translucent = NO;
    self.navigationItem.backBarButtonItem = item;
    
    

    // Do any additional setup after loading the view, typically from a nib.
}

-(void)initViewController
{
    
    NSString *mod = @"524400350532625471120549085942766021162363340941665600484766533989038671449815574446725214233841884170492883666996512506446783024983266734329533667728160975879163620744967611306622696446499738901582520659602883372092686046095789226770869647094658882798575204880069289897088096947590797006939933151651016459018810576772532800280233638746305994553380800312787204459403728486502699610026604047700011656351649026253828731118134630149349309420532805655146650325381026270392708242720932785296065785987942329658426405276208930254712145502782516840175566777175832555120186157908058963280682396510594506309589415346101203047823476020583197010108789660212452256133578497156059231618233048880308622466492238451584373032773416348740289771588741814690341749197859882023110758723460761257313994000973999424722236912514392450031326782346720910040848930713887978909576505657107094009992206316905592544130387985021888585220398098076428379465316391654837145985227414518497566160664214187383158789753250959430605605684468793474465598595098404867151832725882938123454395094195211809871522647626502291049092840607250996562799676149649775271400235091307866238512526647532449431246381313592096637343412734337089117219997077312686117823309417023860773903189";
//    NSString *expont = @"65537";
//    
//    NSString *str = @"1234567";
    
    //NSString *result = [RsaFactory encryptDataWithData:str data2:expont andData3:mod];
   // NSLog(@"加密：%@",result);
    
    //NSString *decryptResult = [RsaFactory decryptDataWithData:result data2:expont andData3:mod];
   // NSLog(@"解密：%@",decryptResult);
    
   
//    NSString *strRandom = @"";
//    
//    for(int i=0; i<1233; i++)
//    {
//        strRandom = [ strRandom stringByAppendingFormat:@"%i",(arc4random() % 9)];
//    }
    
   // NSLog(@"随机数: %@", strRandom);
    
    //第一步，创建url
    NSString *urlStr = [NSString stringWithFormat:@"http://192.168.0.40:8080/wellgood/base"];
    //NSURL *url = [NSURL URLWithString:urlStr];
    
    NSString *type = @"pre_sign";
    NSMutableDictionary *params1 = [NSMutableDictionary new];
    [params1 setValue:@"65537" forKey:@"Exponent"];
    [params1 setValue:mod forKey:@"Modulus"];
    
    NSMutableDictionary *params = [NSMutableDictionary new];
    [params setValue:params1 forKey:@"cpk"];
    [params setValue:type forKey:@"requestType"];

    NSString *param = [params JSONString];
   // NSLog(@"%@",param);
//    [WGAPI postUrl:nil Param:param Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//        if(succeed){
//        
//        
//        
//        }
//    }];

//    if(![CMTool isConnectionAvailable]){
//    
//         [SVProgressHUD showInfoWithStatus:@"网络没有连接！"];
//        
//    }else{
    
    
        [WGAPI post:urlStr RequestParams:param FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            if(data){
                
                NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                //NSLog(@"%@",dict);
                token = [dict objectForKey:@"token"];
                NSLog(@"token= %@",token);
    
               // NSString *spk = [dict objectForKey:@"spk"];
                
                NSString *userName = @"LSC";
                NSString *password = @"123456";
                
              //  NSInteger *ex = exponent.integerValue;
                //NSInteger *mod = modulus.integerValue;
                
                NSMutableDictionary *userInfo = [NSMutableDictionary new];
                [userInfo setValue:userName forKey:@"usrname"];
                [userInfo setValue:password forKey:@"paswd"];
                //NSString *user = [userInfo JSONString];
                
                NSMutableDictionary *params2= [NSMutableDictionary new];
                [params2 setValue:@"76880124501688789475587766685718789815921833248154831178272559700219417501979566360143753199464068297622205621231359071992565657954881090215201467577738517113131520823162503956410653549827771094494031368633464946659106140970694902430716989726972329421669799023360395632213878569065524494169427743120303211835" forKey:@"sub"];
                [params2 setValue:@"sign_in" forKey:@"requestType"];
                [params2 setValue:token forKey:@"token"];
                NSString *param1 = [params2 JSONString];
                
                
                [WGAPI post:urlStr RequestParams:param1 FinishBlock:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
                    
                   if(data){
                        
                       NSDictionary *dict1 = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                       NSString *param4 = [dict1 JSONString];
                       // NSString *result = [dict1 objectForKey:@"result"];
                       //NSLog(@"%@",param4);
                       
                    }
                    
                    //NSLog(@"%@",@"ssss");
                    
                }];

                
            }
            
           
        }];

//    spk =     {
//        Exponent = 65537;
//        Modulus = 107597281537308908269913096493743096457651498668509350906290130212075147508862519883944157343759005459233511201977806189639722779758514612137493475028379111981275862869840972076427152035548995763920646139450679485518048638871041375695931414455186525130010424610738530887269646042943627593082354397064610223717;
//    };

    
    //"76880124501688789475587766685718789815921833248154831178272559700219417501979566360143753199464068297622205621231359071992565657954881090215201467577738517113131520823162503956410653549827771094494031368633464946659106140970694902430716989726972329421669799023360395632213878569065524494169427743120303211835"
    
    //@"76880124501688789475587766685718789815921833248154831178272559700219417501979566360143753199464068297622205621231359071992565657954881090215201467577738517113131520823162503956410653549827771094494031368633464946659106140970694902430716989726972329421669799023360395632213878569065524494169427743120303211835"
    //spk = 353122099046455495742132340497512545221186858492726507988958233416336249822484326663762032359142519750525150728676646213016936845191719459460916796545047954466414428121073685095862246955475914178518325954090254217137228466065004671153502252275522722739413744290639399420419911920697717751603791305950268842240125155299409704952335719500044353093314121269097906902553889781226419176517736346593456554327159393256483410530202379264357509162693778627843699684350816432033584719770595466878729007632279843712428648069761019458624657571767755190239439604701963873985593543195283144007983211015140132672882922818443098333991363592276407012123979154883450989313390212022643417998020576937377702429762127298719540189817607346335905317907359370023019174208363485163310356140216567929100507866706808657914303629523202496676755371475236510363365547268654231900168479368666215770282224725049305479669800625078258178054360286711455785285680646462577561689387947951373279261240427044693878294357280896101134441344665924970549227187513842845387321259350874363464979450532065469305664010115427150727736768174592038219898956357156104672910068994296881841702470639093781092960835500354371313099028244738509205171192622660396160595347627668953843486628
    
    
//        [WGAPI postUrl:nil Param:params Settings:nil completion:^(BOOL succeed, NSDictionary *detailDict, NSError *error) {
//
//            NSString *result = [detailDict valueForKey:@"result"];
//            NSLog(@"%@",result);
//            if(succeed){
//                
//                // NSDictionary *dic=[detailDict valueForKey:@"result"];
//                
//                 NSString *subString = [detailDict valueForKey:@"sub"];
//                 NSLog(@"%@",subString);
//                
//            }else{
//                
//                NSDictionary *dic=[detailDict valueForKey:@"result"];
//                if(!!dic&&dic.count>0)
//                    result=[dic valueForKey:@"reason"];
//                
//                result=[NSString stringWithFormat:@"\n\n\t%@\t\n\n",result];
//                
//                [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
//                [SVProgressHUD setBackgroundColor:[UIColor colorWithHexString:@"676767"]];
//                [SVProgressHUD setInfoImage:nil];
//                [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
//                [SVProgressHUD showInfoWithStatus:result];
//
//                
//            }
//        }];
//        
    
   // }

    
    self.navigationController.navigationBarHidden = YES;
    UIStoryboard *mainView = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MenuTabBarViewController *menuTab = [mainView instantiateViewControllerWithIdentifier:@"menuTabBar"];

    [self.navigationController pushViewController:menuTab animated:YES];
   
    
}

-(void)generateKeyPair:(NSUInteger)keySize
{
    
   // KeyPairGenerator
    OSStatus sanityCheck = noErr;
    publicKey = NULL;
    privateKey = NULL;

    NSMutableDictionary * privateKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * publicKeyAttr = [[NSMutableDictionary alloc] init];
    NSMutableDictionary * keyPairAttr = [[NSMutableDictionary alloc] init];
    
    [keyPairAttr setObject:(__bridge id)kSecAttrKeyTypeRSA forKey:(__bridge id)kSecAttrKeyType];
    [keyPairAttr setObject:[NSNumber numberWithUnsignedInteger:keySize] forKey:(__bridge id)kSecAttrKeySizeInBits];
    
    [privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrIsPermanent];
    [privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrCanEncrypt];
    [privateKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrCanDecrypt];
    [privateKeyAttr setObject:privateTag forKey:(__bridge id)kSecAttrApplicationTag];

    [publicKeyAttr setObject:[NSNumber numberWithBool:YES] forKey:(__bridge id)kSecAttrIsPermanent];
    [publicKeyAttr setObject:publicTag forKey:(__bridge id)kSecAttrApplicationTag];

    [keyPairAttr setObject:privateKeyAttr forKey:(__bridge id)kSecPrivateKeyAttrs];
    [keyPairAttr setObject:publicKeyAttr forKey:(__bridge id)kSecPublicKeyAttrs];
    
    sanityCheck = SecKeyGeneratePair((__bridge CFDictionaryRef)keyPairAttr, &publicKey, &privateKey);
   // LOGGING_FACILITY( sanityCheck == noErr && publicKeyRef != NULL && privateKeyRef != NULL, @"Something really bad went wrong with generating the key pair.");
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
