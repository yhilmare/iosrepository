//
//  YHProfileResumeTrainTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/7.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeTrainTableViewController.h"
#import "YHTrainExperiencTool.h"
#import "YHResultItem.h"
#import "YHTrainExperience.h"
#import "YHProfileResumeTrainExpSecondTableViewController.h"
#import "YHProfileResumeTrainTableViewCell.h"
#import "YHProfileResumeTrainExpAddTableViewController.h"
#import "YHReturnMsg.h"

@interface YHProfileResumeTrainTableViewController ()

@property (nonatomic, strong)NSMutableArray<YHTrainExperience *> *netdata;
@property (nonatomic, strong) UIButton      *rightButton;
@end

@implementation YHProfileResumeTrainTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getNetdata];
}

- (void)getNetdata {
    [YHTrainExperiencTool getTrainExperienceList:^(YHResultItem *result) {
        self.netdata = [NSMutableArray array];
        for (YHTrainExperience *res in result.rows) {
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
    
    return self.netdata.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 70;
}

- (YHProfileResumeTrainTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YHProfileResumeTrainTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHProfileResumeTrainTableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YHProfileResumeTrainTableViewCell alloc] init];
    }
    cell.time.text = self.netdata[indexPath.row].StartDate;
    cell.org.text = self.netdata[indexPath.row].TrainedOrg;
    cell.cls.text = self.netdata[indexPath.row].TrainedName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"YHProfileResumeTrainExp" bundle:nil];
    YHProfileResumeTrainExpSecondTableViewController *edit = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeTrainExpSecondTableViewController"];
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
        
        [YHTrainExperiencTool deletetrainExperience:^(YHReturnMsg *result) {
            if ([result.result isEqualToString:@"true"]) {
                [self.netdata removeObjectAtIndex:indexPath.row];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                NSLog(@"删除失败");
            }
        } withResumeId:self.profileResume.resumeId trainId:self.netdata[indexPath.row].TrainId ];
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
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"YHProfileResumeTrainExp" bundle:nil];
    YHProfileResumeTrainExpAddTableViewController *add = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeTrainExpAddTableViewController"];
    add.profileResume = self.profileResume;
    [self.navigationController pushViewController:add animated:YES];
}

@end
