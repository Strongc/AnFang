//
//  WGAPI.m
//  AnFang
//
//  Created by mac   on 15/9/30.
//  Copyright (c) 2015年 wellgood. All rights reserved.
//

#import "WGAPI.h"
#import "CMTool.h"
#import "ASIFormDataRequest.h"
//#import "HttpRequest.h"
//#import "AFURLRequestSerialization.h"
#import "WGData.h"
//#define NSString *const CMAPIBaseURL=@"http://192.168.0.159:8080/wellgood/base"

//项目根路径
//#ifdef DEBUG

//NSString *const CMAPIBaseURL=@"http://192.168.0.42:8080/wellgood/base";
//NSString *const CMAPIBaseURL = @"http://wellgood.tpddns.cn:8080/";
//NSString *const CMAPIBaseURL = @"http://111.1.8.117:8080/";
NSString *const CMAPIBaseURL = @"http://121.41.24.19:8080/";
//NSString *const CMAPIBaseURL = @"http://wellgood.tpddns.cn:8080/";

//#else
//NSString *const CMAPIBaseURL=@"http://guanwu.puyuntech.com/yht_api/";
//NSString *const CMAPIBaseURL=@"http://192.168.0.159:8080/wellgood/user";

//#endif

//@implementation WGResult
//
//@end
//
//@implementation WGResultSET
//
//- (instancetype)initWithKey:(NSString*)key Type:(WGResultType) type
//{
//    WGResultSET *setting = [super init];
//    [setting setKey:key];
//    [setting setType:type];
//    return setting;
//}
//
//@end
//
//@implementation WGResetValueKey
// -(instancetype)initNewkey:(NSString*)newkey OldKey:(NSString*)oldkey;
//{
//    WGResetValueKey *setting=[super init];
//    [setting setMynewKey:newkey];
//    [setting setOldKey:oldkey];
//    return setting;
//
//}
//
//@end
@interface WGAPI()
@property(nonatomic,strong)NSURLConnection *connection;
@end

@implementation WGAPI

/**
 * post异步请求封装函数
 * @param URL 服务器地址
 * @param params 请求参数
 *
 
 */

+ (void)post:(NSString *)URL RequestParams:(NSString *)params FinishBlock:(void (^)(NSURLResponse *response, NSData *data, NSError *connectionError)) block{
    //把传进来的URL字符串转变为URL地址
    NSString *strUrl = [CMAPIBaseURL stringByAppendingString:URL];
    NSURL *url = [NSURL URLWithString:strUrl];
    //请求初始化，可以在这针对缓存，超时做出一些设置
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                       timeoutInterval:5];
    //解析请求参数，用NSDictionary来存参数，通过自定义的函数parseParams把它解析成一个post格式的字符串
   // NSString *parseParamsResult = [self parseParams:params];
    NSData *postData = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    //NSURLConnection *connection =[[NSURLConnection alloc]initWithRequest:request delegate:self];
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
    
   
}

/**
 *  post上传文件
 *
 *  @param strUrl   接口路径
 *  @param image    上传的文件流
 *  @param fileName 文件名
 *  @param block    回调方法
 */
+(void)post:(NSString *)strUrl RequsetParam:(id)image withFileName:(NSString *)fileName FinishBlock:(void (^)(NSURLResponse *, NSData *, NSError *))block
{
    NSString *url = [CMAPIBaseURL stringByAppendingString:strUrl];
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"---------------------------JHMLY622510";
    
    //根据url初始化request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:10];
    //分界线
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    //结束符
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //得到图片的data
    NSData *data = UIImageJPEGRepresentation(image, 1.0);
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
   // NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\n",@"file",fileName];
    //[body appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",fileName];
    //[body appendFormat:disposition];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: image/png\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", (int)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    //[NSURLConnection sendSynchronousRequest:request returningResponse:response error:nil];
    [NSURLConnection sendAsynchronousRequest:request
                                           queue:queue
                               completionHandler:block];

}


+(void)post:(NSString *)strUrl RequestParam:(NSData *)data withFileName:(NSString *)fileName FinishBlock:(void (^)(NSURLResponse *, NSData *, NSError *))block
{

    NSString *url = [CMAPIBaseURL stringByAppendingString:strUrl];
    //分界线的标识符
    NSString *TWITTERFON_FORM_BOUNDARY = @"---------------------------JHMLY622510";
    
    //根据url初始化request
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]
                                                            cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                        timeoutInterval:10];

    //分界线
    NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
    
    //结束符
    NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
    //   //要上传的图片
    //   UIImage *image=[params objectForKey:@"pic"];
    //得到图片的data
    //http body的字符串
    NSMutableString *body=[[NSMutableString alloc]init];
    //NSMutableData *body = [NSMutableData data];
    ////添加分界线，换行
    [body appendFormat:@"%@\r\n",MPboundary];
    //声明pic字段，文件名为boris.png
    // NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\n",@"file",fileName];
    //[body appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"%@\"\r\n",fileName];
    //[body appendFormat:disposition];
    //声明上传文件的格式
    [body appendFormat:@"Content-Type: audio/mp3.caf\r\n\r\n"];
    //声明结束符：--AaB03x--
    NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
    //声明myRequestData，用来放入http body
    NSMutableData *myRequestData=[NSMutableData data];
    //NSString *disposition = [NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\n",@"file",fileName];
    //[myRequestData appendData:[disposition dataUsingEncoding:NSUTF8StringEncoding]];
    //将body字符串转化为UTF8格式的二进制
    [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
    //将image的data加入
    [myRequestData appendData:data];
    //加入结束符--
    [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
    //设置HTTPHeader中Content-Type的值
    NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
    //设置HTTPHeader
    [request setValue:content forHTTPHeaderField:@"Content-Type"];
    //设置Content-Length
    [request setValue:[NSString stringWithFormat:@"%d", (int)[myRequestData length]] forHTTPHeaderField:@"Content-Length"];
    //设置http body
    [request setHTTPBody:myRequestData];
    //http method
    [request setHTTPMethod:@"POST"];
    
    //创建一个新的队列（开启新线程）
    NSOperationQueue *queue = [NSOperationQueue new];
    //发送异步请求，请求完以后返回的数据，通过completionHandler参数来调用
    //[NSURLConnection sendSynchronousRequest:request returningResponse:response error:nil];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:block];
    
}

+(NSDictionary *) httpAsynchronousRequestUrl:(NSString*) spec postStr:(NSString *)sData
{
    NSString *strUrl = [CMAPIBaseURL stringByAppendingString:spec];
    NSURL *url = [NSURL URLWithString:strUrl];
    NSMutableURLRequest *requst = [NSMutableURLRequest requestWithURL:url];
    [requst setHTTPMethod:@"POST"];
    NSData *postData = [sData dataUsingEncoding:NSUTF8StringEncoding];
    [requst setHTTPBody:postData];
    [requst setTimeoutInterval:15.0];
    
    NSHTTPURLResponse *urlResponse = nil;
    NSError *error = nil;
    //如果使用局部变量指针需要传指针的地址
    NSData *data = [NSURLConnection sendSynchronousRequest:requst returningResponse:&urlResponse error:&error];
    if(data){
        NSString *returnStr = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSDictionary *infojson = [CMTool parseJSONStringToNSDictionary:returnStr];
        return infojson;

    }
    
    return nil;
}

@end
