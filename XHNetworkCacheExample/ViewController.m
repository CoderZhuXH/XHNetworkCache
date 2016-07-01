//
//  ViewController.m
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/6/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import "ViewController.h"
#import "XHNetworkCache.h"
#import "XHNetwork.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XHNetworkCache";
    
    //Example:
    NSString *URLString = @"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=1";
    
    //1.获取缓存数据(参数:请求URL,返回:JSON数据)
    id cacheJson = [XHNetworkCache cacheJsonWithURL:URLString];
    if(cacheJson) NSLog(@"缓存cacheJson=%@",cacheJson);
    
    [XHNetwork POST:URLString parameters:nil success:^(id responseObject) {
      
        NSLog(@"返回数据\n res=%@",responseObject);
        NSDictionary *response_dic = responseObject;
        NSInteger status = [response_dic[@"status"] integerValue];
        //判断数据合法性(此处根据自己服务器返回状态码,进行判断)
        if(status==200)
        {
            //2.将数据写入/更新缓存(参数1:JSON数据,参数2:数据请求URL)
            [XHNetworkCache saveJsonResponseToCacheFile:response_dic andURL:URLString];
            
            //3.获取缓存大小(M)
            float cacheSize = [XHNetworkCache cacheSize];
            NSLog(@"缓存大小:%fM",cacheSize);
            
            //4.清空缓存
            //[XHNetworkCache clearCache];
            
            //刷新UI
            //...
        }
    } failure:^(NSError *error) {
        
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
