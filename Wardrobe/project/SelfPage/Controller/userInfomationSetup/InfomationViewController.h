//
//  InfomationViewController.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/14.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfomationViewController : UIViewController


@property(nonatomic,copy) void(^exitLoginBlock)(void);//退出登录的回调

@end
