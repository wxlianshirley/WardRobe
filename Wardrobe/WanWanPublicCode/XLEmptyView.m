//
//  XLEmptyView.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/23.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "XLEmptyView.h"
@interface XLEmptyView ()
{
    UIImage *_emptyImg;
    NSString *_emptyString;
    NSString *_buttonString;
    void(^_buttonBlock) (void);
}
@property (weak, nonatomic) IBOutlet UILabel *emptyTitleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *emptyImageView;
@property (weak, nonatomic) IBOutlet UIButton *reloadButton;


@end

@implementation XLEmptyView

//+(instancetype)initWithEmptyImage:(UIImage *)emptyImg withEmptyTitle:(NSString *)emptyString withEmptyButtonTitle:(NSString *)buttonString withEmptyButton:(EmptyButtonBlock)buttonBlock{
//    
//    XLEmptyView *emptyView = [[XLEmptyView alloc]initWithEmptyImage:emptyImg withEmptyTitle:(NSString *)emptyString withEmptyButtonTitle:buttonString withEmptyButton:buttonBlock];
//    return emptyView;
//}

-(void)initWithEmptyImage:(UIImage *)emptyImg withEmptyTitle:(NSString *)emptyString withEmptyButtonTitle:(NSString *)buttonString withEmptyButton:(EmptyButtonBlock)buttonBlock{
    
//    self = [super init];
//    if (self) {
        _emptyImageView.image  = emptyImg;
        _emptyTitleLabel.text = emptyString;
        [_reloadButton setTitle:buttonString forState:UIControlStateNormal]  ;
        _reloadButton.layer.borderColor = Color_222.CGColor;
        _buttonBlock = buttonBlock;
//    }
//    return self;
}

- (IBAction)reloadButtonAction:(id)sender {
    
    _buttonBlock();
    
}

@end
