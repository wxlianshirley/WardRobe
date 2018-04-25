//
//  SelfViewTableViewCell_Zero.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/14.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "SelfViewTableViewCell_Zero.h"

@implementation SelfViewTableViewCell_Zero
- (IBAction)systemSetupButtonAction:(id)sender {
    
    self.SystemSetupButtonClickBlock();
}
- (IBAction)selfButtonAction:(id)sender {
    self.InfomationSetupButtonClickBlock();
}

- (IBAction)LoginButtonAction:(id)sender {
    self.LoginButtonClickBlock();
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setIshideLoginBtn:(BOOL)ishideLoginBtn{
//    if (ishideLoginBtn) {
//        _loginButton.hidden = true;
//    }else{
//        
//    }
//    
    _loginButton.hidden = ishideLoginBtn;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
}

@end
