//
//  ViewController.m
//  XHNetworkCacheExample
//
//  Created by xiaohui on 16/6/25.
//  Copyright © 2016年 qiantou. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import "ViewController.h"
#import "XHNetworkCache.h"

@interface ViewController ()

/**
 *  模拟数据请求URL
 */
@property (nonatomic, copy) NSString *URLString;
/**
 *  模拟服务器请求数据
 */
@property (nonatomic, strong) NSDictionary *responseObject;

@property (weak, nonatomic) IBOutlet UILabel *textLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XHNetworkCache";
    self.textLab.text = [NSString stringWithFormat:@"请看控制台打印\n 详情见:Github:https://github.com/CoderZhuXH/XHNetworkCache"];
    
    //数据模拟
    self.URLString = @"http://www.returnoc.com";
    self.responseObject = @{
                           @"time" : @"1444524177",
                           @"isauth" : @"0",
                           @"openid" : @"1728484287",
                           @"sex" : @"男",
                           @"city" : @"",
                           @"cover" : @"http://tp4.sinaimg.cn/1728484287/180/5736236738/1",
                           @"logintime" : @"1445267749",
                           @"name" : @"",
                           @"group" : @"3",
                           @"loginhit" : @"4",
                           @"id" : @"234328",
                           @"phone" : @"",
                           @"nicheng" : @"辉Allen",
                           @"apptoken" : @"bae4c30113151270174f724f450779bc",
                           @"face" : @"http://tp4.sinaimg.cn/1728484287/180/5736236738/1",
                           @"desc" : @"比你牛B的人都在努力,你还有什么理由偷懒!",
                           @"infoverify" : @"1"
                           };
    

}
#pragma mark-Action
/**
 *  (同步)写入/更新缓存数据
 */
- (IBAction)save:(UIButton *)sender {

    //(同步)写入/更新缓存数据
    //参数1:JSON数据,参数2:数据请求URL
    BOOL result = [XHNetworkCache saveJsonResponseToCacheFile:self.responseObject andURL:self.URLString];
    if(result)
    {
        NSLog(@"(同步)写入/更新缓存数据 成功");
    }
    else
    {
         NSLog(@"(同步)写入/更新缓存数据 失败");
    }
}
/**
 *  (异步)写入/更新缓存数据
 */
- (IBAction)save_async:(id)sender {

    //(异步步)写入/更新缓存数据
    //参数1:JSON数据,参数2:数据请求URL
    [XHNetworkCache save_asyncJsonResponseToCacheFile:self.responseObject andURL:self.URLString completed:^(BOOL result) {
        
        if(result)
        {
            NSLog(@"(异步)写入/更新缓存数据 成功");
        }
        else
        {
            NSLog(@"(异步)写入/更新缓存数据 失败");
        }
        
    }];
}
/**
 *  获取缓存数据
 */
- (IBAction)getCache:(id)sender{

    //获取缓存数据
    //参数:数据请求URL
    id cacheJson = [XHNetworkCache cacheJsonWithURL:self.URLString];
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
 *  缓存路径
 */
- (IBAction)cachePath:(id)sender {

    NSString *path = [XHNetworkCache cachePath];
    
    NSLog(@"path=%@",path);
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
