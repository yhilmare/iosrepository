//
//  YHProfileResumeLanAbiTableViewController.m
//  WanCai
//
//  Created by 段昊宇 on 16/8/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeLanAbiTableViewController.h"
#import "YHLanguageAbilityInfo.h"
#import "YHLanguageAbilityTool.h"
#import "YHResultItem.h"
#import "YHReturnMsg.h"
#import "YHProfileResumeLanAbiTableViewCell.h"
#import "YHProfileResumeLanAbiSecondTableViewController.h"
#import "MBProgressHUD.h"


@interface YHProfileResumeLanAbiTableViewController ()

@property (nonatomic, strong)NSMutableArray<YHLanguageAbilityInfo *> *netdata;
@property (nonatomic, strong) UIButton      *rightButton;

@end

@implementation YHProfileResumeLanAbiTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationItem setRightBarButtonItem: self.rightButtonItem];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self getNetdata];
}


- (void)getNetdata {
    [YHLanguageAbilityTool getLanguageAbilityList:^(YHResultItem *result) {
        self.netdata = [NSMutableArray array];
        for (YHLanguageAbilityInfo *res in result.rows) {
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

- (YHProfileResumeLanAbiTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHProfileResumeLanAbiTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"YHProfileResumeLanAbiTableViewCell" forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[YHProfileResumeLanAbiTableViewCell alloc] init];
    }
    cell.languageType.text = self.netdata[indexPath.row].LanguageType;
    cell.languageMaster.text = self.netdata[indexPath.row].LanguageMaster;
    cell.rwAbility.text = self.netdata[indexPath.row].RWAbility;
    cell.lsAbility.text = self.netdata[indexPath.row].LSAbility;
    
    return cell;
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
        [YHLanguageAbilityTool deletLanguageAbility:^(YHReturnMsg *result) {
            if ([result.result isEqualToString:@"true"]) {
                [self.netdata removeObjectAtIndex:indexPath.row];
                [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:indexPath.section] withRowAnimation:UITableViewRowAnimationNone];
            } else {
                NSLog(@"删除失败");
            }
        }
                                     withLanguageId:self.netdata[indexPath.row].LanguageId
                                           resumeId:self.profileResume.resumeId];
        
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
    UIStoryboard* mainStoryboard = [UIStoryboard storyboardWithName:@"YHProfileResumeLanAbi" bundle:nil];
    YHProfileResumeLanAbiSecondTableViewController *add = [mainStoryboard instantiateViewControllerWithIdentifier:@"YHProfileResumeLanAbiSecondTableViewController"];
    add.profileResume = self.profileResume;
    [self.navigationController pushViewController:add animated:YES];
}

@end
