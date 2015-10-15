//
//  HttpRequest.m
//  NewCut
//
//  Created by py on 15-7-18.
//  Copyright (c) 2015年 py. All rights reserved.
//

#import "HttpRequest.h"
#import "AFNetworking.h"
#import "ASIFormDataRequest.h"
#import "JSONKit.h"

@implementation HttpRequest

+(void)get:(NSString *)url params:(NSDictionary *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //2.发送Get请求
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if(success){
        
            success(responseObject);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        failure(error);
    }];


}

+(void)post:(NSString *)url params:(NSString *)params success:(void (^)(id))success failure:(void (^)(NSError *))failure
{
    //1.获得请求管理者
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    //NSString *param = [params JSONString];
   // NSLog(@"%@",param);
    //2.发送Post请求
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];

}

+(void)post:(NSString *)url params:(NSDictionary *)params FileData:(NSData*)filedata OpName:(NSString*)opname FileName:(NSString*)filename FileType:(NSString*)filetype success:(void(^)(id responseObj))success failure:(void(^)(NSError *))failure;
{
    AFHTTPRequestOperationManager *manager =[AFHTTPRequestOperationManager manager];
    
    [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [formData appendPartWithFileData:filedata name:opname fileName:filename mimeType:filetype];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+(void)post:(NSString*)strUrl params:(NSDictionary *)params ImageDatas:(NSArray*)imageDatas Key:(NSString*)key success:(void(^)(id responseObj))success failure:(void(^)(NSError *))failure
{
    NSURL* url = [NSURL URLWithString:strUrl];
    ASIFormDataRequest* request = [ASIFormDataRequest requestWithURL:url];
    [request setDelegate:self];
    [request setTimeOutSeconds:20];
    request.showAccurateProgress = YES;
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_4_0
    [request setShouldContinueWhenAppEntersBackground:YES];
#endif
    
    NSEnumerator* keyEnumerator = params.keyEnumerator;
    id thing;
    while (thing = [keyEnumerator nextObject]) {
        [request addPostValue:[params valueForKey:thing] forKey:thing];
    }
    
    //    [request setDidFinishSelector:@selector(requestDidSuccess:)];
    //    [request setDidFailSelector:@selector(requestDidFailed:)];
    
    if ([imageDatas count] > 0)
    {
        
        [request setPostFormat:ASIMultipartFormDataPostFormat];
        for (NSData* data in imageDatas) {
            [request addData:data withFileName:[NSString stringWithFormat:@"image%ld.png",(unsigned long)[imageDatas indexOfObject:data]] andContentType:@"image/png" forKey:key];
        }
        
        [request startSynchronous];
        NSError* error = request.error;
        if(error)
        {
            failure(error);
        }
        else
        {
            NSString* responseString = request.responseString;
            success([self dictionaryWithJsonString:responseString]);
        }
        //关闭网络
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }
}

/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    if (jsonString == nil) {
        return nil;
    }
    
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err) {
        return nil;
    }
    return dic;
}



@end
