//
//  ProblemListModel.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/21.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProblemListModel : NSObject
/*"list": [
 {
 "id": 3,
 "title": "常见问题",//只需关心此字段
 "sort": 1,
 "relevantUrl": null,
 "createUser": 1,
 "createTime": "2017-12-20 18:31:54",
 "modifyUser": null,
 "modifyTime": "2017-12-20 18:31:54",
 "delFlag": 0
 }
 ]*/

@property(nonatomic,copy)NSString *title;
@property(nonatomic,assign)NSInteger listId;

@end
