# XHNetworkCache
* 一行代码将请求数据写入磁盘缓存-支持CocoaPods<br>

###技术交流群(群号:537476189)

### 版本记录(持续更新)

#### 2016.07.06  Version 1.2(更新)
* 1.增加异步写入/更新缓存接口<br>

#### 2016.07.01  Version 1.1(更新)
* 1.增加手动清除缓存接口
* 2.增加获取缓存大小接口<br>

#### 2016.06.24  Version 1.0(发布)

## 使用方法:
### 1.(同步)写入
```objc
//将数据(同步)写入磁盘缓存(参数1:服务器返回的JSON数据, 参数2:数据请求URL)
//[按APP版本号缓存,不同版本APP,同一接口缓存数据互不干扰]
[XHNetworkCache saveJsonResponseToCacheFile:responseObject andURL:URLString];

```
### 2.(异步)写入
```objc
//将数据(异步)写入磁盘缓存(参数1:服务器返回的JSON数据, 参数2:数据请求URL)
 [XHNetworkCache save_asyncJsonResponseToCacheFile:responseObject andURL:URLString completed:^(BOOL result) {
               
  if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
               
  }];

```
### 3.获取
```objc
//获取缓存数据(参数:请求URL,返回:JSON数据)
id JsonCache = [XHNetworkCache cacheJsonWithURL:URLString];

```
### 4.清除缓存
```objc
//清除缓存
[XHNetworkCache clearCache];

```

### 5.获取缓存总大小(M)
```objc
//获取缓存总大小(M)
float cacheSize = [XHNetworkCache cacheSize];
```
##  安装
### 手动添加:<br>
*   1.将 XHNetworkCache 文件夹添加到工程目录中<br>
*   2.导入 XHNetworkCache.h

### CocoaPods:<br>
*   1.在 Podfile 中添加 pod 'XHNetworkCache'<br>
*   2.执行 pod install 或 pod update<br>
*   3.导入 XHNetworkCache.h

##  系统要求
*   该项目最低支持 iOS 7.0 和 Xcode 7.0

##  许可证
    XHNetworkCache 使用 MIT 许可证，详情见 LICENSE 文件