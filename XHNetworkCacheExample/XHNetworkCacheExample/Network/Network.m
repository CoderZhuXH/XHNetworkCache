//
//  Network.m
//  XHLaunchAdExample
//
//  Created by zhu zhuxiaohui on 2016/6/28.
//  Copyright © 2016年 it7090.com. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHLaunchAd
//  数据请求类
#import "Network.h"

@implementation Network


/**
 GET请求
 */
+(void)getWithURL:(NSString *)URL params:(NSDictionary *)params success:(NetworkSucess)success failure:(NetworkFailure)failure
{
    //此处仅做模拟请求,实际开发中请做真是请求
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        NSData *JSONData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Test" ofType:@"json"]];
        NSDictionary *json =  [NSJSONSerialization JSONObjectWithData:JSONData options:NSJSONReadingAllowFragments error:nil];
        if(success) success(json);
    });

}

@end
