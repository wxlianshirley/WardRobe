
//  XLAFnetworking.m
//  collectionViewDemo
//
//  Created by zhangwei Luo on 2017/11/30.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "XLAFnetworking.h"
#import "AFNetworking.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import<CommonCrypto/CommonDigest.h>
//#import <CommonCrypto/CommonCryptor.h>

static NSTimeInterval   requestTimeout = 15.f;//网络请求时长
static XLNetworkStatus  networkStatus; //网络状态

@interface XLAFnetworking()

@end

@implementation XLAFnetworking
#pragma mark -
#pragma mark - get请求
//get请求
+(XLURLSessionTask *)getWithURL:(NSString *)url
                         params:(NSDictionary *)params
                  progressBlock:(XLGetDownloadProgress)progressBlock
                   successBlock:(XLResponseSuccessBlock)successBlock
                      failBlock:(XLResponseFailBlock)failBlock{
    
    __block XLURLSessionTask *sessionTask = nil;
    AFHTTPSessionManager *manager = [self setupsSessionManager];
    
    NSURL *url1 = [NSURL URLWithString:url];
    NSString *host = url1.host;
    [manager.requestSerializer setValue:host  forHTTPHeaderField:@"host"];
    
    //判断网络状态
    if (networkStatus == XLNetworkStatusNotReachable) {
        NSLog(@"请求网络前是没网络！！！！");
    }
    sessionTask = [manager GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

        if (progressBlock) {progressBlock(downloadProgress.completedUnitCount,downloadProgress.totalUnitCount);}
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"get请求的数据:%@",responseObject);
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
        if (successBlock) {successBlock(dic);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"get请求失败：%@",error);
        if (failBlock) {failBlock(error);}
    }];
    return sessionTask;
}

#pragma mark -
#pragma mark - post请求
//post请求
+(XLURLSessionTask *)postWithURL:(NSString *)url
                          params:(NSDictionary *)params
                   progressBlock:(XLPostUploadProgress)progressBlock
                    successBlock:(XLResponseSuccessBlock)successBlock
                       failBlock:(XLResponseFailBlock)failBlock{
    __block XLURLSessionTask *sessionTask = nil;
    AFHTTPSessionManager *manager = [self setupsSessionManager];
    
    //host
    //    [dict setValue:@"app.v1.dzkandian.com" forKey:@"host"];
    
//    NSURL *url1 = [NSURL URLWithString:url];
//    //blog.csdn.net
//    NSString *host = url1.host;
//    //http://blog.csdn.net
//    NSLog(@"%@",host);
    
    //    if () {
//    [manager.requestSerializer setValue:host  forHTTPHeaderField:@"host"];
    //    }else{
    //
    //        [manager.requestSerializer setValue:[NSString  stringWithFormat:@"app.v1.dzkandian.com"]  forHTTPHeaderField:@"host"];
    //    }
    
    
    
    //判断网络状态
    if (networkStatus == XLNetworkStatusNotReachable) {
        NSLog(@"没网络！！！！");
        return sessionTask;
    }
//    params = [self dataSignature:[params mutableCopy]];
    
    
    sessionTask = [manager POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {progressBlock(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);}
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id _Nullable responseObjects) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:responseObjects options:kNilOptions error:nil];
        
        if ([responseObject[@"code"]  integerValue] ==  200 ) {
            if ([responseObject[@"status"]  boolValue]) {
                if (successBlock) {successBlock(responseObject);}
            }else{
                [[UIApplication sharedApplication].keyWindow makeToast:responseObject[@"msg"] duration:2.0 position:CSToastPositionCenter];
            }
        }
        else{
            //
            if ([responseObject[@"code"]  integerValue] ==  401 || [responseObject[@"code"]  integerValue] ==  412) {
                // Make toast
                [[UIApplication sharedApplication].keyWindow makeToast:@"请登录" duration:2.0 position:CSToastPositionCenter];
                NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                [userDefaults removeObjectForKey:@"telephone"];
                [userDefaults removeObjectForKey:@"password"];
                [userDefaults removeObjectForKey:@"expire"];
                [userDefaults removeObjectForKey:@"token"];
                
                //            //进入重新登录状态
                //            NSNotification *notification = [NSNotification notificationWithName:@"exitLoginNotification" object:nil];
                //            [[NSNotificationCenter defaultCenter]postNotification:notification];
            }
            else if ([responseObject[@"code"]  integerValue] ==  508) {//特殊错误。如领取金币失败，不给任何提示
                //            [[UIApplication sharedApplication].keyWindow makeToast:@"请将系统时间改为自动更新" duration:3.0 position:CSToastPositionCenter];
                
                UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:nil message:@"请将系统时间改为自动更新" preferredStyle:UIAlertControllerStyleAlert];
                [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
                
                return ;
            }
            else if ([responseObject[@"code"]  integerValue] ==  513) {//特殊错误。如领取金币失败，不给任何提示
                return ;
            }
            else {
                [[UIApplication sharedApplication].keyWindow makeToast:responseObject[@"msg"] duration:2.0 position:CSToastPositionCenter];
            }
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"error:%@",error);
        if (failBlock) {failBlock(error);}
    }];
    return sessionTask;
}
#pragma mark -
#pragma mark - 上传图片
//上传图片
+(XLURLSessionTask *)postWithImageArray:(NSArray *)ImageArray
                                WithURL:(NSString *)url
                                 params:(NSDictionary *)params
                          progressBlock:(XLPostUploadProgress)progressBlock
                           successBlock:(XLResponseSuccessBlock)successBlock
                              failBlock:(XLResponseFailBlock)failBlock{
    __block XLURLSessionTask *sessionTask = nil;
    AFHTTPSessionManager *manager = [self setupsSessionManager];
    //判断网络状态
    if (networkStatus == XLNetworkStatusNotReachable) {
//        NSLog(@"没网络！！！！");
        return sessionTask;
    }
    params = [self dataSignature:[params mutableCopy]];
//    NSLog(@"*****************最终请求的parmas数据%@**********************",params);
    sessionTask = [manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (UIImage *image in ImageArray) {
            NSDateFormatter *farmate = [[NSDateFormatter alloc]init];
            [farmate setDateFormat:@"yyyyMMddHHmmss"];
            NSString *nameString =[farmate stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png",nameString];
            NSData *imageData = UIImageJPEGRepresentation(image, 1);
            double scaleNum =(double)300*1024/imageData.length;
//            NSLog(@"图片压缩率：%f",scaleNum);
            if (scaleNum <1) imageData = UIImageJPEGRepresentation(image, scaleNum);
            else imageData = UIImageJPEGRepresentation(image, 0.1);
            [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/jpg/png/jpeg"];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressBlock) {progressBlock(uploadProgress.completedUnitCount,uploadProgress.totalUnitCount);}
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObjects) {
        NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:responseObjects options:kNilOptions error:nil];
        if (successBlock) {successBlock(responseObject);}
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failBlock) {failBlock(error);}
    }];
    return sessionTask;
}

#pragma mark -
#pragma mark -
//创建SessionManager
+(AFHTTPSessionManager *)setupsSessionManager{
    //    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
    static AFHTTPSessionManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
    manager = [AFHTTPSessionManager manager];
    //默认解析模式
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
//    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //配置请求序列化
    AFJSONResponseSerializer *serializer = [AFJSONResponseSerializer serializer];
    [serializer setRemovesKeysWithNullValues:YES];
    manager.requestSerializer.stringEncoding = NSUTF8StringEncoding;
    manager.requestSerializer.timeoutInterval = requestTimeout;
    //配置响应序列化
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithArray:@[@"application/json", @"text/html", @"text/json", @"text/plain", @"text/javascript",  @"text/xml", @"image/*", @"application/octet-stream", @"application/zip"]];
    [manager.requestSerializer setValue:[NSString  stringWithFormat:@"%@", AppId]  forHTTPHeaderField:@"Authorization"];

    //检查网络
//    [self checkNetworkStatus:NO];
    });
    return manager;
}
+ (AFSecurityPolicy *)securityPolicy
{
    AFSecurityPolicy *policy = [AFSecurityPolicy defaultPolicy];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) {
        policy.validatesDomainName = NO;
        policy.allowInvalidCertificates = YES;
    }
    return policy;
}
#pragma mark -
#pragma mark - 检查网络
+ (void)checkNetworkStatus:(void(^)(XLNetworkStatus))callBack {
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager startMonitoring];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable:{
                callBack(XLNetworkStatusNotReachable);
                NSLog(@"没网络。。。。。");
//                [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:[XLAlertController alertWithTitle:nil WithMessage:@"网络不可用，请检查后尝试"] animated:YES completion:nil];
                    [[UIApplication sharedApplication].keyWindow makeToast:@"网络不可用，请检查后尝试" duration:3.0 position:CSToastPositionBottom];
                //退出登录--通知跳到登录页面
//                NSNotification *notification = [NSNotification notificationWithName:@"exitLoginNotification" object:nil];
//                [[NSNotificationCenter defaultCenter]postNotification:notification];
            }
                break;
            case AFNetworkReachabilityStatusUnknown:{
                callBack(XLNetworkStatusUnknown);
                NSLog(@"请求网络前是不知道网络状态。。。");
                [[UIApplication sharedApplication].keyWindow makeToast:@"网络不可用，请检查后尝试" duration:3.0 position:CSToastPositionBottom];}
                break;
     case AFNetworkReachabilityStatusReachableViaWWAN:{
                callBack(XLNetworkStatusReachableViaWWAN);
                NSLog(@"请求网络前是移动数据。。。。。");
         }
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                callBack(XLNetworkStatusReachableViaWiFi);
                NSLog(@"请求网络前是Wi-Fi。。。。。");
                break;
            default:
                callBack(XLNetworkStatusUnknown);
                break;
        }
        
    }];
    
}

#pragma mark -
#pragma mark - 数据签名
+(NSDictionary *)dataSignature:(NSMutableDictionary *)dict{
    
    //timestamp 时间戳(毫秒)如果该时间戳与服务器时间戳相差超过一定时间(默认5分钟)，将视为无效时间戳
    //++++++++++++++++++++++++++++++时间戳(毫秒)+++++++++++++++++++++++++++++++++++++++
    NSString *timestamp = [self currentTimeStr];
    [dict setValue:timestamp forKey:@"timestamp"];
    
    //++++++++++++++++++++++++++++++用户token+++++++++++++++++++++++++++++++++++++++
    NSString *useToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"token"];
    if (useToken != nil   ) {
        [dict setValue:useToken forKey:@"token"];
    }
    // +++++++++++++++++++++++++++++++++++app版本+++++++++++++++++++++++++++++++++++++++++++
    NSString *app_Version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [dict setValue:app_Version forKey:@"version"];
    
    // +++++++++++++++++++++++++++++++++++系统版本+++++++++++++++++++++++++++++++++++++++++++
//    [UIDevice currentDevice].systemVersion
    
    // +++++++++++++++++++++++++++++++++++物理尺寸+++++++++++++++++++++++++++++++++++++++++++
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
//    CGFloat width = size.width;
//    CGFloat height = size.height;
//    NSLog(@"物理尺寸:%.0f × %.0f",width,height);
    
    // +++++++++++++++++++++++++++++++++++分辨率+++++++++++++++++++++++++++++++++++++++++++
//    CGFloat scale_screen = [UIScreen mainScreen].scale;
//    NSLog(@"分辨率是:%.0f × %.0f",width*scale_screen ,height*scale_screen); 
    
    //+++++++++++++++++++++++++++++++++++设备唯一标识符+++++++++++++++++++++++++++++++++++
//    NSString *identifierStr = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
//    NSLog(@"设备唯一标识符:%@",identifierStr);
    
    
    // app名称
    //    NSString *app_Name = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    // app build版本
    //    NSString *app_build = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    //    NSLog(@"当前时间戳为：%@",timestamp);
    
    
    //++++++++++++++++++++++++++++++++++密码进行MD5+++++++++++++++++++++++++++++++++++++++++
    if (dict[@"password"]) {  //新密码
        [dict setValue:[self md5:dict[@"password"]] forKey:@"password"];
    }
    if (dict[@"oldPassword"]) { //旧密码
        [dict setValue:[self md5:dict[@"oldPassword"]] forKey:@"oldPassword"];
    }
    //=====================================================================================================
    //=====================================================================================================
    
    //+++++++++++++++++++++++++将所有的key放进数组+++++++++++++++++++
    NSArray *allKeyArray = [dict allKeys];
    
    //序列化器对数组进行排序的block 返回值为排序后的数组
    NSArray *afterSortKeyArray = [allKeyArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        NSComparisonResult resuest = [obj1 compare:obj2];
        return resuest;
    }];
    //将key与value串联为字符串
    NSString *connectString = [NSString string];
    for (NSString *sortsing in afterSortKeyArray) {
        NSString *valueString = [dict objectForKey:sortsing];
        //如果value为空，则跳过这个参数。
        if ([valueString isKindOfClass:[NSString class]] && ![valueString isKindOfClass:[NSNull class]] && ![valueString isEqualToString:@""] && valueString != nil ) {
            connectString = [NSString stringWithFormat:@"%@%@=%@&",connectString,sortsing,valueString];
        }else if (![valueString isKindOfClass:[NSNull class]] && ![valueString isKindOfClass:[NSString class]] && valueString != nil){
            connectString = [NSString stringWithFormat:@"%@%@=%@&",connectString,sortsing,valueString];
        }
    }
    
    //+++++++++++++++++++++++++++++解密app_sercret+++++++++++++++++++++++++++++++++++++
    NSData *data = [[NSData alloc]initWithBase64EncodedString:DevelopApp_secret options:0];
    NSString *app_secret = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    //将串联后的字符串后添加app_secret
    connectString = [NSString stringWithFormat:@"%@app_secret=%@",connectString,app_secret];
    //+++++++++++++++++++++++++++++++将sign MD5后得到最终签名+++++++++++++++++++++++++++++++++++++++++++=
    connectString = [self md5:connectString];
    [dict setValue:connectString forKey:@"sign"];
    
    return dict;
}


//获取当前时间戳
+(NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

//MD5加密
+(NSString *) md5:(NSString *) input {
    const char *cStr = [input UTF8String];
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
}

#pragma mark-

/**
 并发测试用例，超时时间请根据并发量预估，当前线程和主线程将参与测试直到并发结束。
 
 @param threadCount 并发数量 > 1
 @param runCount  执行次数 > 0
 @param block 测试代码
 @return 总执行次数 > threadCount * threadCount
 */

NSUInteger concurrent_test(NSUInteger threadCount, NSUInteger runCount, dispatch_block_t block)
{
    if (!block) return 0;
    if (threadCount == 0) threadCount = 1;
    if (runCount == 0) runCount = 1;
    
    dispatch_queue_t queue = dispatch_queue_create("com.test.concurrent", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_t group = dispatch_group_create();
    dispatch_suspend(queue);
    __block BOOL jam = YES;
    
    for (int i = 0; i < threadCount; i++) {
        dispatch_group_async(group, queue, ^{
            NSUInteger i = 0;
            while (i++ < runCount) {
                block();
            }
        });
    }
    dispatch_group_notify(group, queue, ^{
        jam = YES;
    });
    jam = NO;
    dispatch_resume(queue);
    NSLog(@"The concurrency test is ready to complete and start concurrency.");
    
    __block NSUInteger n = 0;
    if(![[NSThread currentThread] isMainThread]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            while (!jam) {
                n++;
                block();
            }
        });
    }
    
    NSUInteger m = 0;
    while (!jam) {
        m++;
        block();
    }
    
    NSLog(@"The concurrency test ended.");
    return m + n + threadCount * runCount;
}


@end
