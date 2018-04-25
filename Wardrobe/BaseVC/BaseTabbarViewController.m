//
//  BaseTabbarViewController.m
//  BaseProject
//
//  Created by zhangwei Luo on 2018/4/17.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "BaseTabbarViewController.h"
#import "BaseNavViewController.h"

#import "HomeViewController.h"
#import "InsertClothesViewController.h"
#import "SelfViewController.h"


#import <objc/runtime.h>

@interface BaseTabbarViewController ()

@end

@implementation BaseTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpNavigationController];
}

- (void)setUpNavigationController{
    
    
    
    UIViewController*homeVC = [self controllerWithVC:[HomeViewController class] title:@"首页" name:@"首页" imageNamed:@"kandian" selectedImage:@"kandian_select" inNvc:YES tag:0];
    UIViewController*secondVC = [self controllerWithVC:[InsertClothesViewController class] title:@"添加" name:@"添加" imageNamed:@"kandian" selectedImage:@"kandian_select" inNvc:YES tag:1];
    UIViewController*selfVC = [self controllerWithVC:[SelfViewController class] title:@"个人中心" name:@"个人中心" imageNamed:@"kandian" selectedImage:@"kandian_select" inNvc:NO tag:2];
    
    [self setViewControllers:@[homeVC,secondVC,selfVC]];
}

-(UIViewController *)controllerWithVC:(id)vc title:(NSString*)title name:(NSString *)name  imageNamed:(NSString *)imageName selectedImage:(NSString *)selectImageName inNvc:(BOOL)inNvc tag:(int)tag {
    UIImage *image ;
    if (imageName.length > 0) {
        image = [UIImage imageNamed:imageName];
        image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    UITabBarItem *item = [[UITabBarItem alloc]initWithTitle:name image:image tag:tag];
    item.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [[UITabBarItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:BaseRedColor} forState:UIControlStateSelected];
    
    UIViewController *_vc;
    if (object_isClass(vc)) {
        Class vcCls = vc;
        _vc = [[vcCls alloc] init];
        _vc.title = title;
        if (inNvc) {
            _vc = [[BaseNavViewController alloc]initWithRootViewController:_vc];
        }
    }else {
        _vc = vc;
        BOOL isNvc = [_vc isKindOfClass:[UINavigationController class]];
        if (isNvc) {
            UINavigationController *nvc = (UINavigationController*)_vc;
            nvc.viewControllers.firstObject.title = title;
        }else {
            _vc.title = title;
            if (inNvc) {
                _vc = [[BaseNavViewController alloc]initWithRootViewController:_vc];
            }
        }
    }
    _vc.tabBarItem = item;
    return _vc;
}




@end
