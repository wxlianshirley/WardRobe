//
//  SelfViewTableViewCell_one.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/14.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "SelfViewTableViewCell_one.h"

@implementation SelfViewTableViewCell_one
- (IBAction)withDrawMoneyButtonAction:(id)sender {

    self.QuickCachButtonClickBlock();
}
- (IBAction)friendRequestButtonAction:(id)sender {
    self.FriendInvitationButtonClickBlock();
}
- (IBAction)MyOrderButtonAction:(id)sender {
    self.MyOrderButtonClickBlock();
}
- (IBAction)PrifiltDetailButtonAction:(id)sender {
    self.ProfitDetailsButtonClickBlock();
}


-(void)SetUpAlertController{
    UIAlertController *alertController1 = [UIAlertController alertControllerWithTitle:nil message:@"账号异常，请联系客服" preferredStyle:UIAlertControllerStyleAlert];
    [alertController1 addAction:  [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil]];
    [self.window.rootViewController presentViewController:alertController1 animated:YES completion:nil];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
