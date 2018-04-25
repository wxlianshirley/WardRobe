//
//  AppDelegate.m
//  Wardrobe
//
//  Created by zhangwei Luo on 2018/4/25.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "BaseTabbarViewController.h"
@interface AppDelegate ()
{
    BaseTabbarViewController *tabController;//tabbarController
    
    LoginViewController *loginViewController;
}
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    //创建
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    // 读取账户
    NSString * telephone = [userDefaults objectForKey:@"telephone"];
    //读取密码
    NSString * password = [userDefaults objectForKey:@"password"];
    
//    if (telephone != nil && password != nil) {
//        //自动登录跳转到首页
        [self setupRootController];
//    }else{
        //创建登录Controller
//        [self setupLoginController];
//    }
    
    
    //注册登录成功后通知跳到首页
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(LoginCurrentToHomePageNotificationAction) name:@"LoginCurrentToHomePageNotification" object:nil];
    
    return YES;
}

//创建tabbarController
-(void)setupRootController{
    tabController = [[BaseTabbarViewController alloc]init];
    self.window.rootViewController = tabController;
}

//创建登录Controller
-(void)setupLoginController{
    loginViewController = [[LoginViewController alloc]init];
    UINavigationController *navLoginViewController = [[UINavigationController alloc]initWithRootViewController:loginViewController];
    
    self.window.rootViewController = navLoginViewController;
}

-(void)LoginCurrentToHomePageNotificationAction{
    //自动登录跳转到首页
    [self setupRootController];
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
