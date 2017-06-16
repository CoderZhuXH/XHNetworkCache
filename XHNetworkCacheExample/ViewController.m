//
//  ViewController.m
//  XHNetworkCacheExample
//
//  Created by  zhuxiaohui on 16/6/25.
//  Copyright © 2016年 it7090. All rights reserved.
//  代码地址:https://github.com/CoderZhuXH/XHNetworkCache

#import "ViewController.h"
#import "XHNetworkCache.h"
#import "Network.h"

@interface ViewController ()

/**
 *  模拟数据请求URL
 */
@property (nonatomic, copy) NSString *URL;

/**
 请求参数
 */
@property(nonatomic,strong)NSDictionary *params;

/**
 *  服务器返回数据
 */
@property (nonatomic, strong) id responseObject;

@property (weak, nonatomic) IBOutlet UILabel *textLab;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"XHNetworkCache";
    self.textLab.text = [NSString stringWithFormat:@"请看控制台打印\n 详情见:Github:https://github.com/CoderZhuXH/XHNetworkCache"];
    
    self.URL = @"http://www.it7090.com/Api/getUserInfo";
    self.params =@{@"userId":@"10001"};
    [Network getWithURL:self.URL params:self.params success:^(id response) {
        
        self.responseObject = response;
        
    } failure:^(NSError *error) {
        
    }];

}
#pragma mark-Action
/**
 *  (同步)写入/更新缓存数据
 */
- (IBAction)save:(UIButton *)sender {

    //(同步)写入/更新缓存数据
    //参数1:JSON数据,参数2:数据请求URL,参数3:数据请求参数(没有传nil)
    BOOL result = [XHNetworkCache saveJsonResponseToCacheFile:self.responseObject andURL:self.URL params:self.params];
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
    //参数1:JSON数据,参数2:数据请求URL,参数3:数据请求参数(没有传nil)
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
}
/**
 *  获取缓存数据
 */
- (IBAction)getCache:(id)sender{

    //获取缓存数据
    //参数1:数据请求URL,参数2:数据请求参数(没有传nil)
    id cacheJson = [XHNetworkCache cacheJsonWithURL:self.URL params:self.params];
    NSLog(@"缓存数据:%@",cacheJson);
}
/**
 *  缓存数据大小(M)
 */
- (IBAction)cacheSize:(id)sender {
    
    float size = [XHNetworkCache cacheSize];
    NSLog(@"type1,缓存大小:%fM",size);
    
    //或者(以..kb/..M)形式获取
    NSString *sizeFormat = [XHNetworkCache cacheSizeFormat];
    NSLog(@"type2,缓存大小:%@",sizeFormat);

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
