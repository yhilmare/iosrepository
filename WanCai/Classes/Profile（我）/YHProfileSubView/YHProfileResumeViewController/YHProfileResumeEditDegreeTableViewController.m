//
//  YHProfileResumeEditDegreeTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/31.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeEditDegreeTableViewController.h"
#import "YHReturnMsg.h"


@interface YHProfileResumeEditDegreeTableViewController ()
@property (nonatomic, strong)NSMutableArray<YHEducation *> *netdata;
@property (nonatomic, strong) UIButton      *rightButton;


@end

@implementation YHProfileResumeEditDegreeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getNetdata];
}

- (void)getNetdata {
    [YHEducationTool getEducationList:^(YHResultItem *result) {
        NSLog(@"%@", self.profileResume.resumeId);
        self.netdata = [NSMutableArray array];
        for (YHEducation *res in result.rows) {
            [self.netdata addObject:res];
        }
        [self.tableView reloadData];
    } withResumeId:self.profileResume.resumeId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _netdata.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 70;
}


- (YHProfileResumeEditDegreeTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHProfileResumeEditDegreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHProfileResumeEditDegreeTableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YHProfileResumeEditDegreeTableViewCell alloc]init];
    }
    NSString *time = self.netdata[indexPath.row].StartDate;
    cell.time.text = time;
    cell.school.text = self.netdata[indexPath.row].SchoolName;
    cell.major.text = self.netdata[indexPath.row].Major;
    cell.degree.text = self.netdata[indexPath.row].ChineseName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResumeEdit" bundle:nil];
    YHProfileResumeEditDegreeSecondTableViewController *edit = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeEditDegreeSecondTableViewController"];
    edit.item = self.netdata[indexPath.section];
    [self.navigationController pushViewController:edit animated:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [YHEducationTool deleteEducation:^(YHReturnMsg *result) {
            NSLog(@"%@", result.result);
            if ([result.result isEqualToString:@"true"]) {
                [self.netdata removeObjectAtIndex:indexPath.row];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                NSLog(@"删除失败");
            }
        } withEduId:self.netdata[indexPath.row].EduId resumeId:self.profileResume.resumeId];
        
    }
}


- (UIBarButtonItem *) rightButtonItem {
    if (!_rightButton) {
        _rightButton = [[UIButton alloc] initWithFrame: CGRectMake(0, 0, 40, 30)];
        [_rightButton setTitle: @"增加" forState: UIControlStateNormal];
        [_rightButton setTitleColor: YHWhite forState: UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(addEduExp) forControlEvents:UIControlEventTouchUpInside];
        
    }
    UIBarButtonItem *res = [[UIBarButtonItem alloc] initWithCustomView: _rightButton];
    return res;
}

- (void) addEduExp {
    NSLog(@"添加教育经历") ;
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResumeEdit" bundle:nil];
    YHProfileResumeEditDegreeAddTableViewController *add = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeEditDegreeAddTableViewController"];
    add.profileResume = self.profileResume;
    [self.navigationController pushViewController:add animated:YES];
}


@end
