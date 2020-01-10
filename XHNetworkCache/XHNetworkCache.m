//
//  XHNetworkCache.m
//  XHNetworkCacheExample
//
//  Created by  zhuxiaohui on 16/6/25.
//  Copyright © 2016年 it7090. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import "XHNetworkCache.h"
#import <CommonCrypto/CommonDigest.h>

#ifdef DEBUG
#define DebugLog(...) NSLog(__VA_ARGS__)
#else
#define DebugLog(...)
#endif

@implementation XHNetworkCache

+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL{
    
    return [self saveJsonResponseToCacheFile:jsonResponse andURL:URL params:nil];
}

+(BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL params:(nullable NSDictionary *)params{
    
    if(jsonResponse==nil || URL.length==0) return NO;
    NSData * data= [self jsonToData:jsonResponse];
    return[[NSFileManager defaultManager] createFileAtPath:[self cacheFilePathWithURL:URL params:params] contents:data attributes:nil];
}

+(void)save_asyncJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL completed:(nullable XHNetworkCacheCompletionBlock)completedBlock;{
    
    [self save_asyncJsonResponseToCacheFile:jsonResponse andURL:URL params:nil completed:completedBlock];
}

+(void)save_asyncJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL params:(nullable NSDictionary *)params completed:(nullable XHNetworkCacheCompletionBlock)completedBlock{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL result=[self saveJsonResponseToCacheFile:jsonResponse andURL:URL params:params];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if(completedBlock)  completedBlock(result);
            
        });
    });
}

+(id)cacheJsonWithURL:(NSString *)URL{
    
    return [self cacheJsonWithURL:URL params:nil];
    
}

+(id )cacheJsonWithURL:(NSString *)URL params:(nullable NSDictionary *)params{
    
    if(URL==nil) return nil;
    NSString *path = [self cacheFilePathWithURL:URL params:params];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([self checkCacheWithURL:URL params:params]){
        NSData *data = [fileManager contentsAtPath:path];
        return [self dataToJson:data];
    }
    return nil;
}


+(BOOL)checkCacheWithURL:(NSString *)URL{
    
    return [self checkCacheWithURL:URL params:nil];
}

+(BOOL)checkCacheWithURL:(NSString *)URL params:(nullable NSDictionary *)params{
    if(URL==nil) return NO;
    NSString *path = [self cacheFilePathWithURL:URL params:params];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return [fileManager fileExistsAtPath:path isDirectory:nil];
}


+(BOOL)clearCache
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *path = [self cachePath];
    BOOL result = [fileManager removeItemAtPath:path error:nil];
    [self checkDirectory:[self cachePath]];
    return result;
}

+ (float)cacheSize{
    NSString *directoryPath = [self cachePath];
    BOOL isDir = NO;
    unsigned long long total = 0;
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:directoryPath isDirectory:&isDir]) {
        if (isDir) {
            NSError *error = nil;
            NSArray *array = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:directoryPath error:&error];
            
            if (error == nil) {
                for (NSString *subpath in array) {
                    NSString *path = [directoryPath stringByAppendingPathComponent:subpath];
                    NSDictionary *dict = [[NSFileManager defaultManager] attributesOfItemAtPath:path
                                                                                          error:&error];
                    if (!error) {
                        total += [dict[NSFileSize] unsignedIntegerValue];
                    }
                }
            }
        }
    }
    return total/(1024.0*1024.0);
}

+(NSString *)cacheSizeFormat
{
    NSString *sizeUnitString;
    float size = [self cacheSize];
    if(size < 1)
    {
        size *= 1024.0;//小于1M转化为kb
        sizeUnitString = [NSString stringWithFormat:@"%.1fkb",size];
    }
    else{
        
        sizeUnitString = [NSString stringWithFormat:@"%.1fM",size];
    }
    
    return sizeUnitString;
}

#pragma mark - private
+ (NSString *)cacheFilePathWithURL:(NSString *)URL params:(NSDictionary *)params{
    
    NSString *path = [self cachePath];
    //checkDirectory
    [self checkDirectory:path];
    //fileName
    NSString *cacheFileName = [self cacheFileNameWithURL:URL params:params];
    path = [path stringByAppendingPathComponent:cacheFileName];
    return path;
}

+(NSData *)jsonToData:(id)jsonResponse
{
    if(jsonResponse==nil) return nil;
    NSError *error;
    NSData *data =[NSJSONSerialization dataWithJSONObject:jsonResponse options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        DebugLog(@"ERROR, faild to get json data");
        return nil;
    }
    return data;
}

+(id)dataToJson:(NSData *)data
{
    if(data==nil) return nil;
    return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
}

+(NSString *)cachePath
{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"XHNetworkCache"];
    return path;
}

+(NSString *)cacheFileNameWithURL:(NSString *)URL params:(NSDictionary *)params
{
    if(URL== nil || URL.length == 0) return nil;
    NSString *fileName = [NSString stringWithFormat:@"URL:%@%@ AppVersion:%@",URL,[self paramsStringWithParams:params],[self appVersionString]];
    //DebugLog(@"flieName=%@",fileName);
    return  [self md5StringFromString:fileName];
}
+(NSString *)paramsStringWithParams:(NSDictionary *)params
{
    if(params==nil) return @"";
    NSArray *keyArray = [params allKeys];
    NSArray *sortArray = [keyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    NSMutableArray *valueArray = [NSMutableArray array];
    for (NSString *sortString in sortArray) {
        [valueArray addObject:[params objectForKey:sortString]];
    }
    NSMutableArray *keyValueArray = [NSMutableArray array];
    for (int i = 0; i < sortArray.count; i++) {
        NSString *keyValueStr = [NSString stringWithFormat:@"%@=%@",sortArray[i],valueArray[i]];
        [keyValueArray addObject:keyValueStr];
    }
    return [NSString stringWithFormat:@"?%@",[keyValueArray componentsJoinedByString:@"&"]];
}
+(void)checkDirectory:(NSString *)path {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self createBaseDirectoryAtPath:path];
    } else {
        
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self createBaseDirectoryAtPath:path];
        }
    }
}

+ (void)createBaseDirectoryAtPath:(NSString *)path {
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES
                                               attributes:nil error:&error];
    if (error) {
        DebugLog(@"create cache directory failed, error = %@", error);
    } else {
        
        DebugLog(@"path = %@",path);
        [self addDoNotBackupAttribute:path];
    }
}

+ (void)addDoNotBackupAttribute:(NSString *)path {
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        DebugLog(@"error to set do not backup attribute, error = %@", error);
    }
}

+ (NSString *)md5StringFromString:(NSString *)string {
    
    if(string == nil || [string length] == 0)  return nil;
    
    const char *value = [string UTF8String];
    
    unsigned char outputBuffer[CC_MD5_DIGEST_LENGTH];
    CC_MD5(value, (CC_LONG)strlen(value), outputBuffer);
    
    NSMutableString *outputString = [[NSMutableString alloc] initWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for(NSInteger count = 0; count < CC_MD5_DIGEST_LENGTH; count++){
        [outputString appendFormat:@"%02x",outputBuffer[count]];
    }
    
    return outputString;
}

+ (NSString *)appVersionString {
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
