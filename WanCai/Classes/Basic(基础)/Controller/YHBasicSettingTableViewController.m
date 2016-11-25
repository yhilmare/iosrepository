//
//  YHBasicSettingTableViewController.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHBasicSettingTableViewController.h"
#import "YHGroupItem.h"
#import "YHBasicSettingCell.h"
#import "YHSettingItem.h"


@interface YHBasicSettingTableViewController ()

@end

@implementation YHBasicSettingTableViewController

- (instancetype)init{
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.tableView.backgroundColor = YHGray;
    self.tableView.sectionHeaderHeight = 20;
    self.tableView.sectionFooterHeight = 0;
    self.tableView.contentInset = UIEdgeInsetsMake(-25, 0, 0, 0);
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - tableViewDateSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    YHGroupItem *groupItem = self.groups[section];
    return groupItem.headerTitle;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    YHGroupItem *groupItem = self.groups[section];
    return groupItem.footerTitle;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YHGroupItem *groupItem = self.groups[section];
    return groupItem.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YHBasicSettingCell *cell = [YHBasicSettingCell cellWithTableView:tableView];
    
    // 获取模型
    YHGroupItem *groupItem = self.groups[indexPath.section];
    YHSettingItem *item = groupItem.items[indexPath.row];
    
    // 设置模型
    cell.item = item;
    [cell setIndexPath:indexPath rowCount:groupItem.items.count];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 获取模型
    YHGroupItem *groupItem = self.groups[indexPath.section];
    YHSettingItem *item = groupItem.items[indexPath.row];
    
    if (item.option) {
        item.option();
        return;
    }
    
    
    if (item.descVc) {
        UIViewController *vc = [[item.descVc alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

@end
