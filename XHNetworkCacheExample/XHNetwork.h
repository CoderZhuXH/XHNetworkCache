//
//  XHNetwork.h
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/7/1.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import <Foundation/Foundation.h>

/**
 *  成功
 */
typedef void(^httpRequestSucess) (id responseObject);
/**
 *  失败
 */
typedef void(^httpRequestFailed) (NSError *error);


@interface XHNetwork : NSObject

/**
 *  POST请求
 *
 *  @param URL     URL String
 *  @param dic     参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)POST:(NSString *)URL parameters:(NSDictionary *)dic success:(httpRequestSucess)success failure:(httpRequestFailed)failure;


/**
 *  GET请求
 *
 *  @param URL     URL String
 *  @param dic     参数
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+(void)GET:(NSString *)URL parameters:(NSDictionary *)dic success:(httpRequestSucess)success failure:(httpRequestFailed)failure;
@end
