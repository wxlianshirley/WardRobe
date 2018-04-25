//
//  UserFeedBackViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/16.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "UserFeedBackViewController.h"
#import "ZLPhotoActionSheet.h"
#import "ZLDefine.h"


#import <Photos/Photos.h>
#import "ZLPhotoModel.h"
#import "ZLPhotoManager.h"
#import "ZLProgressHUD.h"
#import "ZLPhotoConfiguration.h"
#import "ImageCell.h"

@interface UserFeedBackViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UIImagePickerControllerDelegate,UITextViewDelegate,UITextFieldDelegate>
{
    ZLPhotoActionSheet *actionSheet;
    NSString *_inputContent;
}
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;//添加图片
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imageButton_X;//添加图片的X
@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *arrDataSources;//需要提交的image
@property (weak, nonatomic) IBOutlet UITextView *suggestionView;//需要提交的建议
@property (weak, nonatomic) IBOutlet UITextField *phomeLabel;//需要提交的电话号码

@property(nonatomic,copy)NSMutableArray *submitImageArray;//选择后转成URL的image图片（提交的前一步）

@property (nonatomic, assign) BOOL isOriginal;
@end

@implementation UserFeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    _arrDataSources = [NSMutableArray array];
    
    _suggestionView.delegate = self;
    _phomeLabel.delegate = self;
    [self _loadCollectionView];
    
    
    _phomeLabel.borderStyle = UITextBorderStyleNone;
    
}

-(void)_loadCollectionView{
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    layout.minimumInteritemSpacing = 2;
//    layout.minimumLineSpacing = 1;
//    layout.sectionInset = UIEdgeInsetsMake(3, 0, 3, 0);
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    self.collectionView.collectionViewLayout = layout;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:NSClassFromString(@"ImageCell") forCellWithReuseIdentifier:@"ImageCell"];
    
}

//点击添加按钮
- (IBAction)btnSelectPhotoPreview:(id)sender
{
    actionSheet = [[ZLPhotoActionSheet alloc] init];
    //设置照片最大选择数
    actionSheet.configuration.maxSelectCount = 5;
#pragma mark - required
    //如果调用的方法没有传sender，则该属性必须提前赋值
    actionSheet.sender = self;

    zl_weakify(self);
    [actionSheet setSelectImageBlock:^(NSArray<UIImage *> * _Nonnull images, NSArray<PHAsset *> * _Nonnull assets, BOOL isOriginal) {
        zl_strongify(weakSelf);
        

        [strongSelf.arrDataSources addObjectsFromArray:images];
        strongSelf.isOriginal = isOriginal;

        [strongSelf.collectionView reloadData];

        NSLog(@"image:%@", images);
    }];
    
    [actionSheet showPhotoLibrary];
    
}

#pragma mark - collection delegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _arrDataSources.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (_arrDataSources.count == 5) {
        _addImageButton.hidden = YES;
    }else if(_arrDataSources.count == 0){
        _imageButton_X.constant = 0;
    }else{
        _addImageButton.hidden = NO;
        _imageButton_X.constant = 52 * _arrDataSources.count;
    }
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageCell" forIndexPath:indexPath];
    cell.imageView.image = _arrDataSources[indexPath.row];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [_arrDataSources removeObjectAtIndex:indexPath.item];
    if ( ![_arrDataSources isKindOfClass:[NSArray class]] || _arrDataSources.count <= 0) {
        _imageButton_X.constant = 0;
    }
    [_collectionView reloadData];
}

#pragma mark - textfile delegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
    
    self.phomeLabel.text = [self.phomeLabel.text stringByReplacingCharactersInRange:range withString:string];//得到输入框的内容
    if ([self.phomeLabel.text length] > 11)  textField.text = [self.phomeLabel.text substringToIndex:10];
    return NO;
}

- (void)textViewDidChange:(UITextView *)textView
{
    if ([textView.text length] > 100) {
        textView.text = [textView.text substringWithRange:NSMakeRange(0,100)];
        [self.navigationController.view makeToast:@"最多输入100个字" duration:2.0 position:CSToastPositionCenter];
        [textView becomeFirstResponder];
        return;
    }
}


#pragma mark - textview delegate
//判断是否超出最大限额 140
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
//
//    if ([text isEqualToString:@""] && range.length > 0) {
//        //删除字符肯定是安全的
//        return YES;
//    }
//    else {
//        if (textView.text.length - range.length + text.length > 140) {
//            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:nil message:@"长度最多为200" preferredStyle:UIAlertControllerStyleAlert];
//            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alertVC animated:YES completion:nil];
//            return NO;
//        }
//        else {
////            NSLog(@"8888888888888%@",textView.text);
//            return YES;
//        }
//    }
//}


-(void)XLImageAfnetworking:(NSArray *)imageName WithCorrectBack:(void (^)(bool isCorrect))currectBlock{
    NSDictionary *parmas = @{@"type":@"FEEDBACK"};
    [XLAFnetworking postWithImageArray:/*@[imageName[0],imageName[1]]*/imageName WithURL:UploadMoreImages params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
        NSLog(@"response:%@",response);
        if (!response[@"status"]) {
            //弹出上传失败
            UIAlertController *alertVC   = [UIAlertController alertControllerWithTitle:nil message:response[@"msg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertVC animated:YES completion:nil];
            
            
        }else{
            if ([response[@"code"] integerValue] == 200) {
                NSLog(@"**************************上传文件成功，拿到头像URL******************%@",response);
                NSArray *photoURL = response[@"url"];
                currectBlock(YES);
                NSString *imgURL;
                if (photoURL.count > 1) {
                    imgURL = [photoURL componentsJoinedByString:@","];
                }else{
                    imgURL = [photoURL firstObject];
                }
                
                NSDictionary *parmas = @{@"phone":_phomeLabel.text,@"imgurl":imgURL,@"opinion":_suggestionView.text};
                //已获取图片URL，上传图片、意见、电话
                [XLAFnetworking postWithURL:FeedbackSave params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
                [self.view makeToast:@"提交成功" duration:1.0 position:CSToastPositionBottom];
                } failBlock:^(NSError *error) {
                    
                }];
            }else{
                //非200
            }
        }
    } failBlock:^(NSError *error) {
        NSLog(@"**************************上传文件失败******************%@",error);
    }];
    
}




- (IBAction)submitButtonAction:(id)sender {
    [_phomeLabel resignFirstResponder];
    [_suggestionView resignFirstResponder];
    
    if (_phomeLabel.text.length != 11 ) {
        [self presentViewController:[XLAlertController alertWithTitle:@"信息错误" WithMessage:@"请输入正确的11位手机号"] animated:YES completion:nil];
        return;
    }
    NSLog(@"_phomeLabel.text:%@,_suggestionView.text:%@,_arrDataSources:%@",_phomeLabel.text,_suggestionView.text,_arrDataSources);
    
    if (_suggestionView.text.length <10) {
        [[UIApplication sharedApplication].keyWindow makeToast:@"最少输入10个字" duration:3.0 position:CSToastPositionCenter];
        return;
    }
    
    if (_arrDataSources.count != 0) {//如果有图片，走这个网络请求
        [self XLImageAfnetworking:_arrDataSources WithCorrectBack:^(bool isCorrect) {
            if (isCorrect) {
                [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1.5];
            }
        }];
    }else{//如果没图片，走这个网络请求
        NSDictionary *parmas = @{@"phone":_phomeLabel.text,@"opinion":_suggestionView.text};
        //已获取图片URL，上传图片、意见、电话
        [XLAFnetworking postWithURL:FeedbackSave params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
            [self.view makeToast:@"提交成功" duration:1.0 position:CSToastPositionBottom];
            [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1.5];
        } failBlock:^(NSError *error) {
            
        }];
    }
    
}
-(void)delayMethod{
    [self.navigationController popViewControllerAnimated:YES];
}

//取消第一响应者
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [_phomeLabel resignFirstResponder];
    [_suggestionView resignFirstResponder];
}


@end
