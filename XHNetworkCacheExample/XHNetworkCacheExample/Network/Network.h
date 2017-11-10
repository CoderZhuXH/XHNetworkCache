//
//  Network.h
//  XHLaunchAdExample
//
//  Created by zhu zhuxiaohui on 2016/6/28.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd
//  数据请求类

#import <Foundation/Foundation.h>

typedef void(^NetworkSucess) (id response);
typedef void(^NetworkFailure) (NSError *error);

@interface Network : NSObject

/**
 GET请求
 */
+(void)getWithURL:(NSString *)URL params:(NSDictionary *)params success:(NetworkSucess)success failure:(NetworkFailure)failure;

@end
