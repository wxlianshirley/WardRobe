//
//  ProblemQuestionModel.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/21.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProblemQuestionModel : NSObject

@property(nonatomic,copy)NSString *question;
@property(nonatomic,copy)NSString *answer;

@property(nonatomic,assign)BOOL isSectionOpen;//是否收起
@end
