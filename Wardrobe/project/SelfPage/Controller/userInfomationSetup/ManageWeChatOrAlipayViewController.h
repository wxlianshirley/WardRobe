//
//  ManageWeChatOrAlipayViewController.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/16.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ManageWeChatOrAlipayChangeDelegate <NSObject>
@required
-(void)ChangeWeChatOrAlipayBack:(BOOL)isWeChatManager;
@end

@interface ManageWeChatOrAlipayViewController : UIViewController

@property(nonatomic,assign)BOOL isWeChatManager;

@property(nonatomic,weak)id<ManageWeChatOrAlipayChangeDelegate> delegate;

-(void)changeWeChatName:(NSString *)nickName WithUserImage:(NSString *)userImage;
@end
