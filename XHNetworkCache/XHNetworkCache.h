//
//  XHNetworkCache.h
//  XHNetworkCacheExample
//
//  Created by  zhuxiaohui on 16/6/25.
//  Copyright © 2016年 it7090. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN

typedef void(^XHNetworkCacheCompletionBlock)(BOOL result);

@interface XHNetworkCache : NSObject

/**
 *  写入/更新缓存(同步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse 要写入的数据(JSON)
 *  @param URL    数据请求URL
 *
 *  @return 是否写入成功
 */
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL;


/**
 *  写入/更新缓存(同步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse 要写入的数据(JSON)
 *  @param URL    数据请求URL
 *  @param params 数据请求参数(没有传nil)
 *
 *  @return 是否写入成功
 */
+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL params:(nullable NSDictionary *)params;


/**
 *  写入/更新缓存(异步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse    要写入的数据(JSON)
 *  @param URL             数据请求URL
 *  @param completedBlock  异步完成回调(主线程回调)
 */
+(void)save_asyncJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL completed:(nullable XHNetworkCacheCompletionBlock)completedBlock;

/**
 *  写入/更新缓存(异步) [按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
 *
 *  @param jsonResponse    要写入的数据(JSON)
 *  @param URL             数据请求URL
 *  @param params          数据请求参数(没有传nil)
 *  @param completedBlock  异步完成回调(主线程回调)
 */
+(void)save_asyncJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL params:(nullable NSDictionary *)params completed:(nullable XHNetworkCacheCompletionBlock)completedBlock;

/**
 *  获取缓存的对象(同步)
 *
 *  @param URL 数据请求URL
 *
 *  @return 缓存对象
 */
+(id )cacheJsonWithURL:(NSString *)URL;


/**
 *  获取缓存的对象(同步)
 *
 *  @param URL 数据请求URL
 *  @param params 数据请求参数
 *
 *  @return 缓存对象
 */
+(id )cacheJsonWithURL:(NSString *)URL params:(nullable NSDictionary *)params;

/**
 *  获取缓存路径
 *
 *  @return 缓存路径
 */
+(NSString *)cachePath;

/**
 *  清除缓存
 */
+(BOOL)clearCache;

/**
 *  获取缓存大小(单位:M)
 *
 *  @return 缓存大小
 */
+ (float)cacheSize;

/**
 *  获取缓存大小,(以..kb/..M)形式获取
 *  小于1M,以kb形式返回,大于1M,以M形式返回
 *  @return 缓存大小+单位
 */
+(NSString *)cacheSizeFormat;

@end

NS_ASSUME_NONNULL_END

