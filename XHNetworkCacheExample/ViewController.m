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

#define URLString @"http://www.qinto.com/wap/index.php?ctl=article_cate&act=api_app_getarticle_cate&num=1&p=1"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XHNetworkCache";
}
/**
 *  (同步)写入/更新缓存数据
 */
- (IBAction)save:(UIButton *)sender {

    [XHNetwork POST:URLString parameters:nil success:^(id responseObject) {
        
        NSDictionary *response_dic = responseObject;
        NSInteger status = [response_dic[@"status"] integerValue];
        //判断数据合法性(此处根据自己服务器返回状态码,进行判断)
        if(status==200)
        {
            //(同步)写入/更新缓存数据
            //参数1:JSON数据,参数2:数据请求URL
            BOOL result = [XHNetworkCache saveJsonResponseToCacheFile:response_dic andURL:URLString];
            if(result) NSLog(@"(同步)写入/更新缓存数据 成功");
            
            //TO DO...
        }
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  (异步)写入/更新缓存数据
 */
- (IBAction)save_async:(id)sender {

    [XHNetwork POST:URLString parameters:nil success:^(id responseObject) {
        
        NSDictionary *response_dic = responseObject;
        NSInteger status = [response_dic[@"status"] integerValue];
        //判断数据合法性(此处根据自己服务器返回状态码,进行判断)
        if(status==200)
        {
            //(异步步)写入/更新缓存数据
            //参数1:JSON数据,参数2:数据请求URL
            [XHNetworkCache save_asyncJsonResponseToCacheFile:response_dic andURL:URLString completed:^(BOOL result) {
               
                if(result)  NSLog(@"(异步)写入/更新缓存数据 成功");
                
            }];
            
            //TO DO...
        }
    } failure:^(NSError *error) {
        
    }];
}
/**
 *  获取缓存数据
 */
- (IBAction)getCache:(id)sender{

    //获取缓存数据
    //参数:数据请求URL
    id cacheJson = [XHNetworkCache cacheJsonWithURL:URLString];
    NSLog(@"缓存数据:%@",cacheJson);
}
/**
 *  缓存数据大小(M)
 */
- (IBAction)cacheSize:(id)sender {
    
    float size = [XHNetworkCache cacheSize];
    NSLog(@"缓存大小:%f M",size);
}
/**
 *  清除缓存
 */
- (IBAction)clearCache:(id)sender {
    
    BOOL result = [XHNetworkCache clearCache];
    if(result) NSLog(@"缓存清除成功");
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
