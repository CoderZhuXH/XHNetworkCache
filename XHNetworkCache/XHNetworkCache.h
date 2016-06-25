//
//  XHNetworkCache.h
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/6/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//  https://github.com/CoderZhuXH/XHNetworkCache

#import <Foundation/Foundation.h>

@interface XHNetworkCache : NSObject

/**
 *  写入/更新缓存
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

@end
