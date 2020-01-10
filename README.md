# XHNetworkCache
#### 一行代码持久化网络数据<br>

[![AppVeyor](https://img.shields.io/appveyor/ci/gruntjs/grunt.svg?maxAge=2592000)](https://github.com/CoderZhuXH/XHNetworkCache)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/CoderZhuXH/XHNetworkCache)
[![Version Status](https://img.shields.io/cocoapods/v/XHNetworkCache.svg?style=flat)](http://cocoadocs.org/docsets/XHNetworkCache)
[![Support](https://img.shields.io/badge/support-iOS%207%2B-brightgreen.svg)](https://github.com/CoderZhuXH/XHNetworkCache)
[![Pod Platform](https://img.shields.io/cocoapods/p/XHNetworkCache.svg?style=flat)](http://cocoadocs.org/docsets/XHNetworkCache)
[![Pod License](https://img.shields.io/cocoapods/l/XHNetworkCache.svg?style=flat)](https://github.com/CoderZhuXH/XHNetworkCache/blob/master/LICENSE)

==============

#### Swift版本请戳这里>>> https://github.com/CoderZhuXH/XHNetworkCacheSwift

### 技术交流群(群号:537476189)


### 更新记录:

*   2020.01.10 -- v1.5.0 -->增加检测该数据是否已缓存接口...
*   2017.09.30 -- v1.4.0 -->已知问题修复及优化...
*	2017.06.16 -- v1.3.0 -->缓存及获取缓存接口增加请求参数(可选)...
*	2016.09.04 -- v1.2.3 -->增加+(NSString *)cacheSizeFormat方法...
*	2016.08.12 -- v1.2.1 -->增加获取缓存路径接口...<br>
*	2016.07.06 -- v1.2   -->增加异步写入/更新缓存接口...<br>
*	2016.07.01 -- v1.1   -->1.增加手动清除缓存接口;2.增加获取缓存大小接口...<br>
*	2016.06.24 -- v1.0

## 使用方法:
### 1.(同步)写入/更新
```objc
//将数据(同步)写入磁盘缓存(参数1:服务器返回的JSON数据, 参数2:数据请求URL,参数3:数据请求参数(没有传nil)
//[按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
    BOOL result = [XHNetworkCache saveJsonResponseToCacheFile:self.responseObject andURL:self.URL params:self.params];
    if(result)
    {
        NSLog(@"(同步)写入/更新缓存数据 成功");
    }
    else
    {
         NSLog(@"(同步)写入/更新缓存数据 失败");
    }

```
### 2.(异步)写入/更新
```objc
//将数据(异步)写入磁盘缓存(参数1:服务器返回的JSON数据, 参数2:数据请求URL,参数3:数据请求参数(没有传nil)
//[按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
    [XHNetworkCache save_asyncJsonResponseToCacheFile:self.responseObject andURL:self.URL params:self.params completed:^(BOOL result) {
        
        if(result)
        {
            NSLog(@"(异步)写入/更新缓存数据 成功");
        }
        else
        {
            NSLog(@"(异步)写入/更新缓存数据 失败");
        }
        
    }];

```

### 3.该数据是否已缓存
```objc
//获取缓存数据(参数1:请求URL,参数2:请求参数,返回:YES已缓存,NO未缓存)
 BOOL result = [XHNetworkCache checkCacheWithURL:self.URL params:self.params];

```

### 4.获取缓存数据
```objc
//获取缓存数据(参数1:请求URL,参数2:请求参数,返回:JSON数据)
id JsonCache = [XHNetworkCache cacheJsonWithURL:self.URL params:self.params];

```
### 5.获取缓存路径
```objc
//获取缓存路径
 NSString *path = [XHNetworkCache cachePath];

```
### 6.清除缓存
```objc
//清除缓存
[XHNetworkCache clearCache];

```

### 7.获取缓存总大小(M)
```objc
//获取缓存大小(M)
float cacheSize = [XHNetworkCache cacheSize];
//或者(以..kb/..M)形式获取
NSString *cacheSizeFormat = [XHNetworkCache cacheSizeFormat];
```
##  安装
### 1.手动添加:<br>
*   1.将 XHNetworkCache 文件夹添加到工程目录中<br>
*   2.导入 XHNetworkCache.h

### 2.CocoaPods:<br>
*   1.在 Podfile 中添加 pod 'XHNetworkCache'<br>
*   2.执行 pod install 或 pod update<br>
*   3.导入 XHNetworkCache.h

### 3.Tips
*   1.如果发现pod search XHLaunchAd 搜索出来的不是最新版本，需要在终端执行pod repo update命令更新本地spec缓存（需要几分钟），然后再搜索就可以了
*   2.如果你发现你执行pod install后,导入的不是最新版本,请删除Podfile.lock文件,在执行一次 pod install

##  系统要求
*   该项目最低支持 iOS 7.0 和 Xcode 7.0

##  许可证
    XHNetworkCache 使用 MIT 许可证，详情见 LICENSE 文件