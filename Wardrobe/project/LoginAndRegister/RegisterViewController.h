//
//  RegisterViewController.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/9.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef void(^registCurrentBlock)(void);

@interface RegisterViewController : UIViewController

@property(nonatomic,assign)BOOL isToFindPassword;

//@property(nonatomic,copy)registCurrentBlock returnRegistToLoginCurrent;

@property(nonatomic,copy)void(^returnRegistToLoginCurrent)(void);                               
@end
