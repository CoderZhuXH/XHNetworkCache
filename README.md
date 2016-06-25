# XHNetworkCache
#### 一行代码将请求数据写入磁盘缓存-支持CocoaPods<br>
###技术交流群(群号:537476189)
## 使用方法:
### 1.写入
```objc
//将数据写入磁盘缓存(参数1:服务器返回的JSON数据, 参数2:数据请求URL)
[XHNetworkCache saveJsonResponseToCacheFile:responseObject andURL:URLString];

```
### 2.获取
```objc
//获取缓存数据(参数:请求URL,返回:JSON数据)
id JsonCache = [XHNetworkCache cacheJsonWithURL:URLString];

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

