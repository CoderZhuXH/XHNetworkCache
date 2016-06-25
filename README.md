# XHNetworking
* 基于AFNNetworking 3.x 的轻量级数据请求框架,支持数据自动/手动缓存--支持CocoaPods

## 写在最前:
*  默认使用: <br>
   `请求数据类型` 为:`HTTP` <br>
   `返回结果类型`为:`JSON` <br>
*  若需修改:<br>
   请在`XHNetworking.m` 文件,`+(AFHTTPSessionManager *)createManager` 中进行配置
   
## 使用方法:
### 1.数据请求+自动缓存
```objc

/**
*  POST请求,自动缓存
*
*  @param URL       URL String
*  @param dic       参数
*  @param jsonCache 缓存回调
*  @param success   成功回调
*  @param failure   失败回调
*/
+(void)POST:(NSString *)URL parameters:(NSDictionary *)dic jsonCache:(httpRequestCache)jsonCache  success:(httpRequestSucess)success failure:(httpRequestFailed)failure;

/**
*  GET请求,自动缓存
*
*  @param URL           URL String
*  @param dic           参数
*  @param jsonCache 缓存回调
*  @param success       成功回调
*  @param failure       失败回调
*/
+(void)GET:(NSString *)URL parameters:(NSDictionary *)dic  jsonCache:(httpRequestCache)jsonCache success:(httpRequestSucess)success failure:(httpRequestFailed)failure;

```
### 栗子:
```objc

 NSString *URL = @"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=1";

[XHNetworking POST:RequestURL parameters:nil jsonCache:^(id cache) {

//缓存
NSLog(@"缓存:\n%@",cache);
//To Do...

} success:^(id responseObject) {

//成功
NSLog(@"success:%@\n",responseObject);
//刷新数据
//To Do...

} failure:^(NSError *error) {

//失败
NSLog(@"error:%@\n",error);

}];

```

### 2.普通数据请求+手动缓存
```objc

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

/**
*  手动写入/更新缓存
*
*  @param jsonResponse 要写入的数据
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

```
### 栗子:
```objc

NSString *URL =@"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=2";

//手动获取缓存
NSDictionary *cache = [XHNetworkCache cacheJsonWithURL:URL];
//To Do...

NSLog(@"缓存:\n%@",cache);

[XHNetworking POST:URL parameters:nil success:^(id responseObject) {

//成功
NSLog(@"success:%@\n",responseObject);

//刷新数据
//To Do...

//手动写入/更新缓存
[XHNetworkCache saveJsonResponseToCacheFile:responseObject andURL:URL];


} failure:^(NSError *error) {

//失败
NSLog(@"error:%@\n",error);

}];

```

##  安装
### 手动添加:<br>
*   1.将 XHNetworking 文件夹添加到工程目录中<br>
*   2.添加 AFNNetworking 3.x 到工程目录中<br>
*   3.导入 XHNetworking.h

### CocoaPods:<br>
*   1.在 Podfile 中添加 pod 'XHNetworking'<br>
*   2.执行 pod install 或 pod update<br>
*   3.导入 XHNetworking.h

##  系统要求
*   该项目最低支持 iOS 7.0 和 Xcode 7.0

##  许可证
    XHNetworking 使用 MIT 许可证，详情见 LICENSE 文件


