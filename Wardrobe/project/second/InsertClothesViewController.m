//
//  InsertClothesViewController.m
//  BaseProject
//
//  Created by zhangwei Luo on 2018/4/18.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "InsertClothesViewController.h"

@interface InsertClothesViewController ()

@end

@implementation InsertClothesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self _loadSubView];
}

-(void)_loadSubView{
    UIButton *but = [[UIButton alloc]init];
    
    but.backgroundColor = [UIColor redColor];
    [but setTitle:@"拍照" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(takePhotoButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    
    UIButton *but2 = [[UIButton alloc]init];
    but2.backgroundColor = [UIColor blueColor];
    [but2 setTitle:@"相册" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(openAlbumButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but2];
    
    CGFloat pading = 10.0f;
    [but2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(but.mas_right).offset(pading);
        make.right.equalTo(self.view).offset(-pading);
        make.centerY.equalTo(but);
        
        make.height.equalTo(but2.mas_width); /// 约束长度等于宽度
        make.width.equalTo(but.mas_width);
        
    }];
   
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(100);
        make.left.equalTo(self.view).offset(padding);
        make.height.equalTo(but2.mas_width);
    }];
}

//
-(void)takePhotoButtonAction{
    
}

//
-(void)openAlbumButtonAction{
    
}


@end
