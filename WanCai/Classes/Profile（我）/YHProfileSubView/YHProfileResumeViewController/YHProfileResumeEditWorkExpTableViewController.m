//
//  YHProfileResumeEditWorkExpTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeEditWorkExpTableViewController.h"
#import "YHWorkExperience.h"
#import "YHWorkExperienceTool.h"
#import "YHProfileResumeEditWorkExpTableViewCell.h"
#import "YHProfileResumeEditWorkSecondTableViewController.h"
#import "YHResultItem.h"
#import "YHProfileResumeEditWorkAddTableViewController.h"
#import "YHReturnMsg.h"

@interface YHProfileResumeEditWorkExpTableViewController ()

@property (nonatomic, strong)NSMutableArray<YHWorkExperience *> *netdata;
@property (nonatomic, strong) UIButton      *rightButton;

@end

@implementation YHProfileResumeEditWorkExpTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getNetdata];
}

- (void) getNetdata {
    [YHWorkExperienceTool getWorkExperienceList:^(YHResultItem *result) {
        NSLog(@"%@", self.profileResume.resumeId);
        self.netdata = [NSMutableArray array];
        for (YHWorkExperience *res in result.rows) {
            [self.netdata addObject:res];
        }
        [self.tableView reloadData];
    } withResumeId:self.profileResume.resumeId];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.netdata.count;;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (YHProfileResumeEditWorkExpTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHProfileResumeEditWorkExpTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHProfileResumeEditWorkExpTableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YHProfileResumeEditWorkExpTableViewCell alloc]init];
    }
    cell.time.text = self.netdata[indexPath.section].StartDate;
    cell.company.text = self.netdata[indexPath.section].CompanyName;
    cell.type.text = self.netdata[indexPath.section].Responsiblity;
    cell.pro.text = self.netdata[indexPath.section].SubFunction;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResumeWorkExp" bundle:nil];
    YHProfileResumeEditWorkSecondTableViewController *edit = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeEditWorkSecondTableViewController"];
    
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
        
        [YHWorkExperienceTool deleteWorkExperice:^(YHReturnMsg *result) {
            NSLog(@"%@", result.result);
            if ([result.result isEqualToString:@"true"]) {
                [self.netdata removeObjectAtIndex:indexPath.row];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                NSLog(@"删除失败");
            }
        } withWorkId:self.netdata[indexPath.row].WorkId resumeId:self.profileResume.resumeId];
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
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"ProfileResumeWorkExp" bundle:nil];
    YHProfileResumeEditWorkAddTableViewController *add = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeEditWorkAddTableViewController"];
    add.profileResume = self.profileResume;
    [self.navigationController pushViewController:add animated:YES];
}

@end
