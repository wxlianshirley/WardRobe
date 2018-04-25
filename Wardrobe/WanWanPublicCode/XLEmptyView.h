//
//  XLEmptyView.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/23.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^EmptyButtonBlock) (void);//点击按钮的回调

@interface XLEmptyView : UIView

-(void)initWithEmptyImage:(UIImage *)emptyImg withEmptyTitle:(NSString *)emptyString withEmptyButtonTitle:(NSString *)buttonString  withEmptyButton:(EmptyButtonBlock)buttonBlock;


@end
