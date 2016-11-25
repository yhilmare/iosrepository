//
//  YHFunctionViewController.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHFunctionViewController.h"
#import "YHFuncTableViewCell.h"


@interface YHFunctionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableview;

@end

@implementation YHFunctionViewController

- (UITableView *) tableview{
    if(!_tableview){
        _tableview = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableview.delegate = self;
        _tableview.dataSource = self;
        _tableview.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableview.separatorInset = UIEdgeInsetsMake(0, 0, 0, 15);
    }
    return _tableview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = nil;
    [self.view addSubview:self.tableview];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.row % 2 != 0){
        return 300;
    }
    return 44;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *identifier1 = @"Function_identifier1";
    static NSString *identifier2 = @"Function_identifier2";
    
    if(indexPath.row % 2 == 0){
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
        if(cell == nil){
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier1];
        }
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 0){
            cell.textLabel.text = @"海量工作，精准推荐，让您更容易找到满意的工作！";
        }else if(indexPath.row == 2){
            cell.textLabel.text = @"了解工作详情，一键投递简历";
        }else if(indexPath.row == 4){
            cell.textLabel.text = @"心有灵犀，查看关注您的人，收藏心仪的工作";
        }else if(indexPath.row == 6){
            cell.textLabel.text = @"企业直约面试，美好未来触手可及";
        }else{
            cell.textLabel.text = @"发现好文章，提升自己，了解公司详情，祝您更快找到工作";
        }
        return cell;
    }else{
        YHFuncTableViewCell *cell = [YHFuncTableViewCell cellFromTableView:tableView withIdentifier:identifier2];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if(indexPath.row == 1){
            cell.iconName1 = @"IMG_4138";
            cell.iconName2 = @"IMG_4139";
        }else if(indexPath.row == 3){
            cell.iconName1 = @"IMG_4144";
            cell.iconName2 = @"IMG_4145";
        }else if(indexPath.row == 5){
            cell.iconName1 = @"IMG_4147";
            cell.iconName2 = @"IMG_4143";
        }else if(indexPath.row == 7){
            cell.iconName1 = @"IMG_4141";
            cell.iconName2 = @"IMG_4142";
        }else{
            cell.iconName1 = @"IMG_4140";
            cell.iconName2 = @"IMG_4146";
        }
        return cell;
    }
}

@end
