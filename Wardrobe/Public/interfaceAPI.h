//
//  interfaceAPI.h
//  LookEveryday
//
//  Created by WXL on 2017/12/5.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#ifndef interfaceAPI_h
#define interfaceAPI_h

//static NSString * const SelfViewTableViewCell_Zero_identifier = @"SelfViewTableViewCell_Zero_identifier";

#define userToken [[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"];//用户token

#pragma mark -
#pragma mark - APPLE ID
#define apple_id  @"1335964536"


#pragma mark -
#pragma mark - 后台开发链接


//*******************************公网1******************************************
#define DevelopAddress @"http://192.168.1.161:8080" //公网测试地址  地址：1
#define DevelopApp_secret @"Njg0OWNhMDEtNGVlLWU4NzUyLTkzYWMwMDAwOC1jZDMzNDI3" //公网密钥

//*******************************内网******************************************
//#define DevelopAddress @"http://test.frp.dzkandian.com" //内网测试地址
//#define DevelopApp_secret @"M2QwYmZmYjAtNmYtNGZkMDk5NTBmYzc2LWFjNWM5YWM4LTE2" //开发密钥


//*******************************男程序员电脑******************************************
//#define DevelopAddress @"http://192.168.1.200:8080" //唐朝开发者地址
//#define DevelopApp_secret @"M2QwYmZmYjAtNmYtNGZkMDk5NTBmYzc2LWFjNWM5YWM4LTE2" //开发密钥

//*******************************女程序员电脑******************************************
//#define DevelopAddress @"http://192.168.1.201:8080" //仔仔开发者地址
//#define DevelopApp_secret @"M2QwYmZmYjAtNmYtNGZkMDk5NTBmYzc2LWFjNWM5YWM4LTE2" //开发密钥

//*******************************带眼镜程序员电脑******************************************
//#define DevelopAddress @"http://192.168.1.202:8080" //仔仔开发者地址
//#define DevelopApp_secret @"M2QwYmZmYjAtNmYtNGZkMDk5NTBmYzc2LWFjNWM5YWM4LTE2" //开发密钥




#pragma mark -
#pragma mark - 秘钥
//#define DevelopApp_secret @"6849ca01-4ee-e8752-93ac00008-cd33427" //公网密钥
//#define DevelopApp_secret @"3d0bffb0-6f-4fd09950fc76-ac5c9ac8-16" //开发密钥


#pragma mark -
#pragma mark - 应用市场APP ID
#define AppStore_ID  @"itms-apps://itunes.apple.com/app/id1111111?action=write-review"
#define Umeng_AppKey @"5a59966fa40fa33ada0001aa"
#define JPush_AppKey @"69f14f3171716b373f0987c7"


#pragma mark -
#pragma mark - 新闻页面
//*********************直接第三方接口************************
//#define AppId @"6e8b670927454b6098f049aa5098abb6"
//#define NewsListAPI @"http://jisunews.market.alicloudapi.com/news/get"//新闻页面

//*********************我们后台的接口************************
#define AppId @"Basic bHVhdXNlcjomKmpmbGthSA=="
#define NewsItemAPI @"https://lua.dzkandian.com/i/news.list"//资讯顶部分类列表
#define NewsListAPI @"https://lua.dzkandian.com/i/news.html"//新闻页面

#define NewsReadedGold @""DevelopAddress@"/api/task/read"//阅读获得金币
#define NewsDurationGold @""DevelopAddress@"/api/task/duration"//时段奖励
#define SubmitComments @""DevelopAddress@"/api/comment/save"//提交评论



#pragma mark -
#pragma mark - 视频页面
//#define VideoListAPI @""DevelopAddress@"/lua/video.html"//视频页面
#define VideoListAPI @"https://lua.dzkandian.com/i/video.html"//视频页面
#define VideoItemAPI @"https://lua.dzkandian.com/i/video.list"//视频顶部分类列表
#define VideoReadedGold @""DevelopAddress@"/api/task/watch"//视频获得金币

#define ObtainComments @""DevelopAddress@"/api/comment/getCommAndFabulous"//获取评论
#define SubmitCommentFabulos @""DevelopAddress@"/api/comment/saveCommentFabulos"



#pragma mark -
#pragma mark - 任务中心页面
#define TaskListAPI @""DevelopAddress@"/api/task/list"//任务中心页面--（任务列表：日常任务、新手任务）
#define TaskSignRecord @""DevelopAddress@"/api/task/signRecord"//任务中心页面--（签到列表）
#define TaskSign @""DevelopAddress@"/api/task/sign"//任务中心页面--（签到）
#define TaskWeChatBinding @""DevelopAddress@"/api/user/wxBinding"//任务中心页面--（绑定微信）
#define TaskAlipayBinding @""DevelopAddress@"/api/user/alipayBinding"//任务中心页面--（绑定支付宝）
#define Taskfinish @""DevelopAddress@"/api/task/finish"//任务中心页面--（完成任务）



#pragma mark -
#pragma mark - 我的页面
#define UserInfoApI  @""DevelopAddress@"/api/user/info" //我的页面
#define UserMineGold  @""DevelopAddress@"/api/gold/mine"//我的金币

#pragma mark - 我的页面（快速提现）
#define GoldExchangeList  @""DevelopAddress@"/api/gold/exchangeList"//快速提现页面列表
#define GoldNowToExchange  @""DevelopAddress@"/api/gold/withdrawals"//立即快速

#pragma mark - 我的页面（我的订单）
#define MyOrderWithDrawalsList  @""DevelopAddress@"/api/gold/withdrawalsList"//我的订单列表
#define ProfitDetailsList  @""DevelopAddress@"/api/task/record"//收益明细列表


#pragma mark - 我的页面（修改资料）
#define UploadFile   @""DevelopAddress@"/api/utils/upload"//上传文件
#define UploadMoreImages   @""DevelopAddress@"/api/utils/imgs_upload"//上传多个文件
#define UpdateInfo   @""DevelopAddress@"/api/user/updateInfo"//修改个人资料

#define ChangePhone   @""DevelopAddress@"/api/user/changePhone"//修改手机号
#define BindPhone   @""DevelopAddress@"/api/user/bindPhone"//绑定手机号

#define VerifySms   @""DevelopAddress@"/api/utils/verifySms"//验证手机号和验证码
#define VerifyPwd   @""DevelopAddress@"/api/user/verifyPwd"//验证旧密码

#define ChangePassword   @""DevelopAddress@"/api/user/changePassword"//修改密码




#define FeedbackSave   @""DevelopAddress@"/api/feedback/save"//用户反馈
#define ActivityCenter @""DevelopAddress@"/api/activitycenter/list"//活动中心

#pragma mark - 我的页面 （问题分类）
#define FAQ_list   @""DevelopAddress@"/api/faq/type"//问题分类
#define FAQ_question   @""DevelopAddress@"/api/faq/question"//问题答案

#pragma mark - 我的页面 （管理微信和支付宝钱包） 支付宝钱包绑定就是用的修改个人信息接口
#define weChatPayAuthorization @""DevelopAddress@"/api/user/weixinPayBind"//微信钱包页面--（微信钱包授权）




#pragma mark - 登录注册
#define registerAPI  @""DevelopAddress@"/renren-fast/api/user/reg"  //手机号注册
#define sendPhoneCode  @""DevelopAddress@"/api/utils/sendSmsCode"  //发送验证码
#define LoginByTelephone   @""DevelopAddress@"/renren-fast/api/user/login"//手机号登录
#define LoginByCode   @""DevelopAddress@"/api/user/smsLogin"//验证码登录
#define FindPassword   @""DevelopAddress@"/api/user/forgetPassword"//找回密码

//微信登录
#define WeChatLogin   @""DevelopAddress@"/api/user/wxLogin"//微信登录
#define AlipayLogin   @""DevelopAddress@"/api/user/alipayLogin"//支付宝登录
#define AlipayLogin_Sign   @""DevelopAddress@"/api/utils/alipayLoginParam" //支付宝登录取签


//分享
#define ShareUmeng   @""DevelopAddress@"/api/utils/dataDictionaries" //



#endif /* interfaceAPI_h */
