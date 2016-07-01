//
//  ViewController.m
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/6/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
#import "XHNetworkCache.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XHNetworkCache";
        
    //将数据写入缓存(参数1:JSON数据,参数2:数据请求URL)
    //[XHNetworkCache saveJsonResponseToCacheFile:response_dic andURL:URLString];
    
    //获取缓存数据(参数:请求URL,返回:JSON数据)
    //id cache = [XHNetworkCache cacheJsonWithURL:URLString];
    
    
    //Example:
    NSString *URLString = @"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=1";
    //数据请求(实际项目中请封装数据请求,此处不做封装)
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];//请求类型:HTTP
    manager.responseSerializer = [AFJSONResponseSerializer serializer];//返回的结果:JSON
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];

    [manager POST:URLString parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSLog(@"返回数据\n res=%@",responseObject);
        NSDictionary *response_dic = responseObject;
        NSInteger status = [responseObject[@"status"] integerValue];
        //判断数据合法性(此处根据自己服务器返回状态码,进行判断)
        if(status==200)
        {
            //写入缓存
            [XHNetworkCache saveJsonResponseToCacheFile:response_dic andURL:URLString];
            
            //获取缓存
            //id cache = [XHNetworkCache cacheJsonWithURL:URLString];
            //NSLog(@"缓存\n cache=%@",cache);
            
            //其他操作
            //TO DO...
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"error=%@",error);
        
    }];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
