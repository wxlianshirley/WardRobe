//
//  ProblemDetailViewController.m
//  LookEveryday
//
//  Created by zhangwei Luo on 2017/12/20.
//  Copyright © 2017年 wxLian. All rights reserved.
//

#import "ProblemDetailViewController.h"
#import "ProblemQuestionModel.h"
#import "ProblemDetailCell.h"

#define ProblemDetailtableViewQuestionCell_identifier @"ProblemDetailtableViewQuestionCell_identifier"
#define ProblemDetailtableViewAnswerCell_identifier @"ProblemDetailtableViewAnswerCell_identifier"

@interface ProblemDetailViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,copy)NSArray *dataArr;//总数据

@end

@implementation ProblemDetailViewController
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.topItem.title = @"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"具体问题";
    [self _loadData];
    [self _loadTableView];
}
-(void)_loadData{
    
    NSInteger page = 1;
    NSInteger limit = 10;
    NSString *currentVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    NSDictionary *parmas = @{@"page":[NSNumber numberWithInteger:page],
                             @"limit":[NSNumber numberWithInteger:limit],
                             @"type": [NSNumber numberWithInteger:self.listId],
                             @"version":[NSNumber numberWithInteger:[currentVersion intValue]]
                             };
    
    /*
    [XLAFnetworking postWithURL:FAQ_question params:parmas progressBlock:nil successBlock:^(NSDictionary *response) {
        if (response[@"status"]) {
            NSLog(@"%@",response);
            NSArray *listArray = response[@"list"];
            NSMutableArray *arr = [NSMutableArray array];//答案
            
            for (NSDictionary *dic in listArray) {
                
                ProblemQuestionModel *model = [ProblemQuestionModel new];
                model.question = dic[@"question"];
                model.answer = dic[@"answer"];
                model.isSectionOpen = NO;
                [arr addObject:model];
                
            }
            self.dataArr = arr;
            [_tableView reloadData];
        }
    } failBlock:^(NSError *error) {
        
    }];
     */
}


-(void)_loadTableView{
    _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerNib:[UINib nibWithNibName:@"ProblemDetailCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ProblemDetailtableViewQuestionCell_identifier];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ProblemDetailtableViewAnswerCell_identifier];
}

#pragma mark - tableView delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return self.dataArr.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    ProblemQuestionModel *model = [ProblemQuestionModel new];
    model = [self.dataArr objectAtIndex:section];
    return  model.isSectionOpen ? 2 : 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ProblemDetailCell *questionCell = [tableView dequeueReusableCellWithIdentifier:ProblemDetailtableViewQuestionCell_identifier];
    UITableViewCell *answerCell = [tableView dequeueReusableCellWithIdentifier:ProblemDetailtableViewAnswerCell_identifier];
    questionCell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    ProblemQuestionModel *model = [ProblemQuestionModel new];
    model = [self.dataArr objectAtIndex:indexPath.section];

    if (indexPath.row == 0) {
        questionCell.questionLabel.text = model.question;
        questionCell.questionLabel.font = [UIFont systemFontOfSize:14];
        questionCell.questionLabel.textColor = [UIColor blackColor];
        questionCell.imgView.image = model.isSectionOpen ? [UIImage imageNamed:@"problemTip_open"]:[UIImage imageNamed:@"problemTip_close"];
        return questionCell;
    }else{
        answerCell.textLabel.text = model.answer;
        answerCell.textLabel.font = [UIFont systemFontOfSize:12];
        answerCell.textLabel.textColor = [UIColor grayColor];
        answerCell.textLabel.numberOfLines = 0;
        return answerCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ProblemQuestionModel *model = [ProblemQuestionModel new];
    model = [self.dataArr objectAtIndex:indexPath.section];
    if (indexPath.row == 0) {
        model.isSectionOpen = model.isSectionOpen ? NO:YES;
    }
    //重新加载当前区
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationAutomatic];   
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return nil;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

@end
