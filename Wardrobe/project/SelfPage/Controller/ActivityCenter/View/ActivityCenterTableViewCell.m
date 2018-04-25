//
//  ActivityCenterTableViewCell.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2018/1/17.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "ActivityCenterTableViewCell.h"


@interface ActivityCenterTableViewCell()


@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UILabel *titleLabl;
@property(nonatomic,strong)UILabel *smallTimeLabel;
@property(nonatomic,strong)UIImageView *contentImgView;
@property(nonatomic,strong)UILabel *contentLabel;




@end

@implementation ActivityCenterTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setLayout];
    }
    
    return self;
}


-(void)setLayout{
    
    _timeLabel = [UILabel new];
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor lightGrayColor];
    _timeLabel.numberOfLines = 0;
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_timeLabel];

    
    
    UIView *contentBgView = [UIView new];
    contentBgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentBgView];
   
    
   
    
    
    _titleLabl = [UILabel new];
    _titleLabl.font = [UIFont systemFontOfSize:16];
    _titleLabl.numberOfLines = 0;
    [contentBgView addSubview:_titleLabl];
    
    
    _smallTimeLabel = [UILabel new];
    _smallTimeLabel.font = [UIFont systemFontOfSize:14];
    _smallTimeLabel.textColor = [UIColor lightGrayColor];
    [contentBgView addSubview:_smallTimeLabel];
    
    _contentImgView = [UIImageView new];
    [contentBgView addSubview:_contentImgView];
    
    _contentLabel = [UILabel new];
    _contentLabel.font = [UIFont systemFontOfSize:12];
    _contentLabel.textColor = [UIColor lightGrayColor];
    _contentLabel.numberOfLines = 0;
    [contentBgView addSubview:_contentLabel];
    
    UIView *lineView = [UIView new];

    lineView.backgroundColor = [UIColor colorWithRed:221/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    [contentBgView addSubview:lineView];

    

   

    
    UILabel *lookLabel = [UILabel new];
    lookLabel.text = @"立即查看";
    lookLabel.font = [UIFont systemFontOfSize:18];
    [contentBgView addSubview:lookLabel];
    
    UIImageView *rightImageView = [UIImageView new];
    rightImageView.image = [UIImage imageNamed:@"problemTip_close"];
    [contentBgView addSubview:rightImageView];
    
    
    
    
    
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.right.equalTo(self.contentView);
        
        
    }];
    
    [_titleLabl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentBgView).offset(10);
        make.left.equalTo(contentBgView).offset(10);
        make.right.equalTo(contentBgView).offset(-10);
    }];
    
    
    
    [_smallTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabl.mas_bottom).offset(10);
        make.left.right.equalTo(_titleLabl);
        
    }];
    
    [_contentImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_smallTimeLabel);
        make.top.equalTo(_smallTimeLabel.mas_bottom).offset(10);
        make.height.equalTo(@200);
    }];
    
    [_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentImgView);
        make.top.equalTo(_contentImgView.mas_bottom).offset(10);
      
    }];
    
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentLabel);
        make.height.equalTo(@1);
        make.top.equalTo(_contentLabel.mas_bottom).offset(10);
    }];
    
    [lookLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView);
        make.top.equalTo(lineView.mas_bottom).offset(10);
        make.bottom.equalTo(contentBgView).offset(-10);
    }];
    [rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(lookLabel.mas_centerY);
        make.right.equalTo(contentBgView).offset(-10);
        make.width.height.equalTo(@20);
        
    }];
    
    [contentBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_timeLabel.mas_bottom).offset(10);
        make.left.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
  
        
    }];
    
    
}

-(void)setModel:(ActivityCenterModel *)model{
    
    _timeLabel.text = [[model.createTime componentsSeparatedByString:@" "] firstObject];
    
    _smallTimeLabel.text = [[model.startTime componentsSeparatedByString:@" "] firstObject];
    [_contentImgView sd_setImageWithURL:[NSURL URLWithString:model.imgUrl] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        _contentImgView.contentMode =UIViewContentModeScaleAspectFill;
        
        _contentImgView.clipsToBounds = YES;
    }];
    
    UIColor *typeColor;
    if([model.classification isEqualToString:@"公告"]){
       // 172    213    141
        typeColor = [UIColor colorWithRed:172/255.0 green:213/255.0 blue:141/255.0 alpha:1];
    }else if([model.classification isEqualToString:@"活动"]){
        //247    198    118
        typeColor = [UIColor colorWithRed:247/255.0 green:198/255.0 blue:118/255.0 alpha:1];
    }else{
        typeColor = [UIColor blueColor];
    }
    
    NSMutableAttributedString *titleArrSrt = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@  %@",model.classification,model.title]];
    [titleArrSrt addAttributes:@{NSBackgroundColorAttributeName:typeColor,NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:12],NSBaselineOffsetAttributeName: @(1)} range:NSMakeRange(0, 4)];
    _titleLabl.attributedText = titleArrSrt;
    
  
    
    //调整内容文本行距
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:model.desc];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [model.desc length])];
    _contentLabel.attributedText = attributedString;
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
