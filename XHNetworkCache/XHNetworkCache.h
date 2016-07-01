//
//  XHNetworkCache.h
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/6/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import <Foundation/Foundation.h>

@interface XHNetworkCache : NSObject

/**
 *  写入/更新缓存 [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse 要写入的数据(JSON)
 *  @param URL    请求URL
 *
 *  @return 是否写入成功
 */
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL;

/**
 *  获取缓存的对象
 *
 *  @param URL 请求URL
 *
 *  @return 缓存对象
 */
+(id )cacheJsonWithURL:(NSString *)URL;

/**
 *  清除所有缓存
 */
+(BOOL)clearCache;

/**
 *  获取缓存总大小(单位:M)
 *
 *  @return 缓存大小
 */
+ (float)cacheSize;

@end
