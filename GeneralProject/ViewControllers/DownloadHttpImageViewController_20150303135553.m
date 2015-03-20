//
//  DownloadHttpImageViewController.m
//  GeneralProject
//
//  Created by Chendi on 15/3/2.
//  Copyright (c) 2015年 Cindy. All rights reserved.
//

#import "DownloadHttpImageViewController.h"

@interface DownloadHttpImageViewController ()
{
    NSMutableData *receiveData;
}

@end

@implementation DownloadHttpImageViewController

- (IBAction)buttonPress:(id)sender
{
    NSString *str1 = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1311/18/c0/28737258_1384744611424_800x600.jpg";
    NSString *str2 = @"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1410/09/c0/39456102_1412865746220_800x600.jpg";
    [self saveTheHttpImageWith:str1];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSURL *url = [NSURL URLWithString:@"http://img.pconline.com.cn/images/upload/upc/tx/wallpaper/1311/18/c0/28737258_1384744611424_800x600.jpg"];
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
}

- (void)saveTheHttpImageWith:(NSString *)imageURLStr
{
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLStr]];
    
    NSString *filePathstr=[[NSString stringWithFormat:@"%@",[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]] stringByAppendingPathComponent:@"66666666.jpg"];
    NSLog(@"file save path : (%@)",filePathstr);
    
    BOOL isDir;
    NSLog(@"exit1 : %zi",[[NSFileManager defaultManager] fileExistsAtPath:filePathstr isDirectory:&isDir]);
    NSLog(@"isDir1 : %i",isDir);
    
    [data writeToFile:filePathstr atomically:YES];
    
    BOOL isDir2;
    NSLog(@"exit2 : %i",[[NSFileManager defaultManager] fileExistsAtPath:filePathstr isDirectory:&isDir2]);
    NSLog(@"isDir2 : %i",isDir2);
    self.imageView.image = [UIImage imageWithContentsOfFile:filePathstr];
    data = nil;
}

/*************** http ****************/
//1、     同步GET请求
//第一步，创建URL
//NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];


//第二步，通过URL创建网络请求
//NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];

//NSURLRequest初始化方法第一个参数：请求访问路径，第二个参数：缓存协议，第三个参数：网络请求超时时间（秒）
//其中缓存协议是个枚举类型包含：
//NSURLRequestUseProtocolCachePolicy（基础策略）
//NSURLRequestReloadIgnoringLocalCacheData（忽略本地缓存）
//NSURLRequestReturnCacheDataElseLoad（首先使用缓存，如果没有本地缓存，才从原地址下载）
//NSURLRequestReturnCacheDataDontLoad（使用本地缓存，从不下载，如果本地没有缓存，则请求失败，此策略多用于离线操作）
//NSURLRequestReloadIgnoringLocalAndRemoteCacheData（无视任何缓存策略，无论是本地的还是远程的，总是从原地址重新下载）
//NSURLRequestReloadRevalidatingCacheData（如果本地缓存是有效的则不下载，其他任何情况都从原地址重新下载）

//第三步，连接服务器
//NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//NSString *str = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//NSLog(@"%@",str);

//2、同步POST请求

//第一步，创建URL
//NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do"];

//第二步，创建请求
//NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//[request setHTTPMethod:@"POST"];//设置请求方式为POST，默认为GET
//NSString *str = @"type=focus-c";//设置参数
//NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//[request setHTTPBody:data];

//第三步，连接服务器
//NSData *received = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//NSString *str1 = [[NSString alloc]initWithData:received encoding:NSUTF8StringEncoding];
//NSLog(@"%@",str1);

//3、异步GET请求

//第一步，创建url
//NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do?type=focus-c"];

//第二步，创建请求
//NSURLRequest *request = [[NSURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];

//第三步，连接服务器
//NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];

//4、异步POST请求
//第一步，创建url
//NSURL *url = [NSURL URLWithString:@"http://api.hudong.com/iphonexml.do"];

//第二步，创建请求
//NSMutableURLRequest *request = [[NSMutableURLRequest alloc]initWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
//[request setHTTPMethod:@"POST"];
//NSString *str = @"type=focus-c";
//NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
//[request setHTTPBody:data];

//第三步，连接服务器
//NSURLConnection *connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];

//5、异步请求的代理方法
//接收到服务器回应的时候调用此方法
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
    NSLog(@"allHeaderFields : %@",[res allHeaderFields]);
    receiveData = [NSMutableData data];
}

//接收到服务器传输数据的时候调用，此方法根据数据大小执行若干次
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receiveData appendData:data];
}

//数据传完之后调用此方法
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSString *receiveStr = [[NSString alloc] initWithData:receiveData encoding:NSUTF8StringEncoding];
    NSLog(@"connectionDidFinishLoading : %@",receiveStr);
}

//网络请求过程中，出现任何错误（断网，连接超时等）会进入此方法
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"connection idFailWithError%@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
