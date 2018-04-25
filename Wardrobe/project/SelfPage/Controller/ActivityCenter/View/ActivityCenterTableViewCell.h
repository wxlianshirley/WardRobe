//
//  ActivityCenterTableViewCell.h
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/17.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActivityCenterModel.h"

@interface ActivityCenterTableViewCell : UITableViewCell
@property(nonatomic,strong)ActivityCenterModel *model;
@property(nonatomic,strong)UILabel *timeLabel;
@end
