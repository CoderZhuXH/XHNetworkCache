//
//  XHNetwork.m
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/7/1.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import "XHNetwork.h"
#import "AFNetworking.h"

@implementation XHNetwork
+(AFHTTPSessionManager *)createManager
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //申明请求类型:HTTP
    //(AFJSONRequestSerializer,AFHTTPRequestSerializer)
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    //申明返回的结果:JSON
    //AFJSONResponseSerializer,AFHTTPResponseSerializer
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    
    return manager;
}
/**
 *  POST请求
 */
+(void)POST:(NSString *)URL parameters:(NSDictionary *)dic  success:(httpRequestSucess)success failure:(httpRequestFailed)failure
{
    AFHTTPSessionManager *manager = [self createManager];
    [manager POST:URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error=%@",error);
        failure(error);
    }];
}
/**
 *  GET请求
 */
+(void)GET:(NSString *)URL parameters:(NSDictionary *)dic success:(httpRequestSucess)success failure:(httpRequestFailed)failure
{
    AFHTTPSessionManager *manager = [self createManager];
    [manager GET:URL parameters:dic progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error=%@",error);
        
        failure(error);
        
    }];
}
@end
