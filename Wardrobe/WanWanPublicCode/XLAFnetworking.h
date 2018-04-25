//
//  XLAFnetworking.h
//  collectionViewDemo
//
//  Created by zhangwei Luo on 2017/11/30.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFNetworking;
/**
 *  网络状态
 */
typedef NS_ENUM(NSInteger, XLNetworkStatus) {
    /**
     *  未知网络
     */
    XLNetworkStatusUnknown             = 1 << 0,
    /**
     *  无法连接
     */
    XLNetworkStatusNotReachable        = 1 << 1,
    /**
     *  WWAN网络
     */
    XLNetworkStatusReachableViaWWAN    = 1 << 2,
    /**
     *  WiFi网络
     */
    XLNetworkStatusReachableViaWiFi    = 1 << 3
};


typedef void (^XLDownloadProgress)(int64_t bytesRead,//已下载的大小
                                   int64_t totalBytes);//下载进度  总下载大小
typedef void (^XLUploadProgress)(int64_t bytesRead,//已上传的大小
                                   int64_t totalBytes);//上传进度  总上传大小
typedef void(^XLResponseSuccessBlock) (NSDictionary* response);//请求成功的回调
typedef void(^XLResponseFailBlock)(NSError *error);//请求失败的回调
typedef NSURLSessionTask XLURLSessionTask;//请求任务
typedef XLDownloadProgress XLGetDownloadProgress;//下载进度
typedef XLUploadProgress   XLPostUploadProgress;//上传进度




@protocol AFNetWorkingLoginStatuDelegate <NSObject>

//-(void)AFNetWorkingLoginStatuDelegate:(NewsViewController*)newsViewController;//编辑按钮

@end


@interface XLAFnetworking : NSObject

@property(nonatomic,assign)BOOL isFirstSendNetWorkMassege;



+(AFHTTPSessionManager *)setupsSessionManager;

//get请求
+(XLURLSessionTask *)getWithURL:(NSString *)url
                         params:(NSDictionary *)params
                  progressBlock:(XLGetDownloadProgress)progressBlock
                   successBlock:(XLResponseSuccessBlock)successBlock
                      failBlock:(XLResponseFailBlock)failBlock;
//post请求
+(XLURLSessionTask *)postWithURL:(NSString *)url
                          params:(NSDictionary *)params
                   progressBlock:(XLPostUploadProgress)progressBlock
                    successBlock:(XLResponseSuccessBlock)successBlock
                       failBlock:(XLResponseFailBlock)failBlock;
//上传图片请求
+(XLURLSessionTask *)postWithImageArray:(NSArray *)ImageArray
                                WithURL:(NSString *)url
                                 params:(NSDictionary *)params
                          progressBlock:(XLPostUploadProgress)progressBlock
                           successBlock:(XLResponseSuccessBlock)successBlock
                              failBlock:(XLResponseFailBlock)failBlock;

+(NSString *)currentTimeStr;//获取当前时间戳

/**
 网络检测
 
 @param callBack 检测结果回调
 */
+ (void)checkNetworkStatus:(void(^)(XLNetworkStatus networkStatus))callBack;



@end
