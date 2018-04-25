//
//  XLDatePickerView.m
//  qqqq
//
//  Created by WXL on 2018/1/1.
//  Copyright © 2018年 wxLian. All rights reserved.
//

#import "XLDatePickerView.h"
@interface XLDatePickerView()<UIPickerViewDelegate,UIPickerViewDataSource>
{
    UIPickerView *_pickerView;
    NSArray *_nowDateArray;//当前日期
    
    NSString *_selectYear;//选择的年
    NSString *_selectMonth;//选择的月
    NSString *_selectDay;//选择的日
    
}
@property(nonatomic,copy)NSMutableArray *yearArray;
@property(nonatomic,copy)NSMutableArray *monthArray;
@property(nonatomic,copy)NSMutableArray *dayArray;




@end

@implementation XLDatePickerView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0/255.f green:0/255.f blue:0/255.f alpha:0.25];
        [self _loadData];
        [self _loadView];
    }
    return self;
}

-(void)_loadData{
    _nowDateArray = [self getSystemYearMonthDay];
    NSString *yearStr = _nowDateArray[0];
    NSString *monthStr = _nowDateArray[1];
    
    _yearArray = [NSMutableArray array];
    _monthArray = [NSMutableArray array];
    _dayArray = [NSMutableArray array];
    //年
    for (int i = 1950; i<[yearStr intValue]; i++) {
        [_yearArray addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    //月
    for (int i = 1; i<=12; i++) {
        [_monthArray addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    //日
    _dayArray = [[self getDaysFromMonth: [monthStr intValue]] mutableCopy];
    
}

-(void)_loadView{
    //加载pickerView
//    _pickerView = [[UIPickerView alloc]initWithFrame: CGRectMake(0, [UIScreen mainScreen].bounds.size.height-260, [UIScreen mainScreen].bounds.size.width, 200)];
    _pickerView = [[UIPickerView alloc]initWithFrame: CGRectZero];
    [self addSubview:_pickerView];
    [_pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self).offset(10);
        make.right.equalTo(self).offset(-10);
        make.bottom.equalTo(self.mas_bottom).with.offset(-80);
        make.height.mas_equalTo(@200);
    }];
    _pickerView.backgroundColor = [UIColor whiteColor];
    _pickerView.layer.cornerRadius = 13.0;
    _pickerView.layer.masksToBounds = YES;
    _pickerView.delegate = self;
    _pickerView.dataSource = self;

    [_pickerView selectRow:[_nowDateArray[0] integerValue]-1951 inComponent:0 animated:YES];
    [_pickerView selectRow:[_nowDateArray[1] integerValue]-1 inComponent:1 animated:YES];
    [_pickerView selectRow:[_nowDateArray[2] integerValue]-1 inComponent:2 animated:YES];
    
    if (_selectYear == NULL || _selectMonth == NULL || _selectDay == NULL) {
        _selectYear = _yearArray[[_nowDateArray[0] integerValue]-1951];
        _selectMonth = _monthArray[[_nowDateArray[1] integerValue]-1];
        _selectDay = _dayArray[[_nowDateArray[2] integerValue]-1];
    }
    
    //加载确认按钮
//    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_pickerView.frame)+10, [UIScreen mainScreen].bounds.size.width-20, 40)];
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectZero];
    [self addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).with.offset(10);
        make.right.equalTo(self.mas_right).with.offset(-10);
        make.top.equalTo(_pickerView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(@57);
    }];
    button.backgroundColor = [UIColor whiteColor];
    button.layer.cornerRadius = 13.0;
    [button.titleLabel   setFont :[ UIFont   fontWithName : @"Helvetica-Bold"  size : 25.0 ]];
//    button.titleLabel.font = [UIFont boldSystemFontOfSize:25.0];
    button.titleLabel.font = [UIFont systemFontOfSize:20.0];
    [button setTitle:@"确定" forState:0];
    [button setTitleColor:[UIColor colorWithRed:21/255.0 green:126/255.0 blue:251/255.0 alpha:1] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(CurrentButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma maek - delegate datasource
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 3;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (component == 0) return _yearArray.count;
    else if (component == 1) return _monthArray.count;
    else return _dayArray.count;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) return _yearArray[row];
    else if (component == 1) return _monthArray[row];
    else return _dayArray[row];
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    //可以通过自定义label达到自定义pickerview展示数据的方式
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel)
    {
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
//        [pickerLabel setBackgroundColor:[UIColor lightGrayColor]];
        pickerLabel.textColor = Color_222;
        [pickerLabel setFont:[UIFont boldSystemFontOfSize:17.0]];
    }
    
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];//调用上一个委托方法，获得要展示的title
    return pickerLabel;
}




-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if (component == 0) _selectYear = _yearArray[row];
    else if (component == 1) {
       _dayArray = [[self getDaysFromMonth:[_monthArray[row]integerValue]]mutableCopy];
        [_pickerView reloadComponent:2];
        
        _selectMonth = _monthArray[row];
        
    }
    else _selectDay = _dayArray[row];
}


-(CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return 48;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self removeFromSuperview];
}

#pragma mark - buttonAction
-(void)CurrentButtonAction{
    NSString *selectDate = [NSString stringWithFormat:@"%@-%@-%@",_selectYear,_selectMonth,_selectDay];
    NSLog(@"selectDate:%@",selectDate);
    self.SelectBirthDayDateBlock(selectDate);
    [self removeFromSuperview];
}





#pragma mark -
//根据月份算日
-(NSArray *)getDaysFromMonth :(NSInteger)month{
    int temp = 0;
    if (month == 2) temp = 29;
    else if (month == 1||month == 3||month == 5|| month == 7||month == 8||month == 10||month == 12) temp = 31;
    else temp = 30;
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 1; i<=temp; i++) {
        [array addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    return array;
}

//获取系统时间
-(NSArray*)getSystemYearMonthDay{
    NSDate *currentDate = [[NSDate alloc]initWithTimeIntervalSinceNow:[[NSDate date] timeIntervalSinceNow]];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    formatter.dateFormat = @"yyyy-MM-dd";
    NSString *date = [formatter stringFromDate:currentDate];
    
    return [date componentsSeparatedByString:@"-"];
}


@end
