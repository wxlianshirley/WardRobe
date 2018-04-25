//
//  ActivityCenterModel.h
//  LookEveryday
//
//  Created by milan on 2018/1/22.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ActivityCenterModel : NSObject
/*
 btnText = 2;
 classification = "\U6d3b\U52a8";
 createTime = "2018-01-01 09:27:44";
 createUser = 1;
 delFlag = 0;
 desc = "\U5206\U9694\U7b26";
 endTime = "2018-02-08 09:27:41";
 id = 4;
 imgUrl = "https://www.dzkandian.com/img_dazhong/Public/Home/images/group01.png";
 modifyTime = "2018-01-22 17:04:36";
 modifyUser = 1;
 startTime = "2018-01-23 09:27:36";
 tag = 0;
 title = "\U5566\U5566\U5566";
 */
@property(nonatomic,copy)NSString *classification;
@property(nonatomic,copy)NSString *imgUrl;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *desc;
@property(nonatomic,copy)NSString *startTime;
@property(nonatomic,copy)NSString *createTime;



@end
