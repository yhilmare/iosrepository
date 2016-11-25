//
//  YHCompanyDetailInfoViewController.m
//  WanCai
//
//  Created by abing on 16/7/18.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyDetailInfoViewController.h"
#import "YHCompanyInfoTool.h"
#import "YHResultItem.h"
#import "YHCompanyInfo.h"
#import "YHCompanyTableViewHeaderCell.h"
#import "YHCompanyDesc.h"
#import "YHCompanyTableViewMiddleCell.h"
#import "YHCompanyTableViewBottomCellTableViewCell.h"
#import "YHIndusToImageTool.h"
#import "YHStringTools.h"

@interface YHCompanyDetailInfoViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, copy) NSString *companyID;

@property (nonatomic, copy) YHCompanyInfo *comInfo;

@property (nonatomic, strong)UIActivityIndicatorView *flower;

@property (nonatomic, strong) YHCompanyDesc *desc;


@end

@implementation YHCompanyDetailInfoViewController

- (YHCompanyDesc *)desc{
    if(!_desc){
        _desc = [[YHCompanyDesc alloc] init];
    }
    return _desc;
}

- (UIActivityIndicatorView *) flower{
    if(!_flower){
        _flower = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _flower.hidesWhenStopped = YES;
        CGFloat x = [UIScreen mainScreen].bounds.size.width / 2.0;
        CGFloat y = [UIScreen mainScreen].bounds.size.height / 2.0;
        _flower.center = CGPointMake(x, y);
        
    }
    return _flower;
}

- (UITableView *) tableView{
    if(!_tableView){
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 12);
    }
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.title = @"公司简介";
    self.navigationItem.rightBarButtonItem = nil;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.flower];
    self.tableView.hidden = YES;
    [self.flower startAnimating];
    
    [YHCompanyInfoTool getCompanyInfo:^(YHResultItem *result) {
        YHCompanyInfo *info = [result.rows firstObject];
        _comInfo = info;
        self.tableView.hidden = NO;
        self.desc.companyDesc = [YHStringTools htmlEntityDecode:_comInfo.CompanyIntroduce];
        [self.tableView reloadData];
        [self.flower stopAnimating];
    } withCompanyId:self.companyID];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(section == 0){
        return 0.1;
    }
    return 10;
}

- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(section == 2){
        return 25;
    }
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0){
        return 105;
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            return 50;
        }else{
            return self.desc.rowHeight;
        }
    }else{
        if(indexPath.row == 0){
            return 50;
        }else{
            return 140;
        }
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        return 1;
    }
    return 2;
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *identifier = @"companyInfo_idntifier1";//用过
    NSString *identifier1 = @"companyInfo_idntifier2";//用过;
    NSString *identifier2 = @"companyInfo_idntifier3";
    NSString *identifier3 = @"companyInfo_idntifier4";

    if (indexPath.section == 0) {
        
        YHCompanyTableViewHeaderCell *headerCell = [YHCompanyTableViewHeaderCell cellFromTableView:tableView withIdentifier:identifier1];
        headerCell.iconName = [YHIndusToImageTool getIconWithIndustry:self.comInfo.CompanyIndustryName];
        if(self.comInfo != nil){
            headerCell.comInfo = self.comInfo;
        }
        [headerCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return headerCell;
        
    }else if(indexPath.section == 1){
        if(indexPath.row == 0){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"test"];
            }
            cell.textLabel.text = @"公司介绍";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else{
            YHCompanyTableViewMiddleCell *middleCell = [YHCompanyTableViewMiddleCell cellFromTableView:tableView withIdentifier:identifier2];
            middleCell.desc = self.desc;
            middleCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return middleCell;
        }
        
    }else{
        if(indexPath.row == 0){
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if(cell == nil){
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"test"];
            }
            cell.textLabel.text = @"公司资料";
            cell.textLabel.font = [UIFont systemFontOfSize:15];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            return cell;
        }else{
            
            YHCompanyTableViewBottomCellTableViewCell *bottomCell = [YHCompanyTableViewBottomCellTableViewCell cellFromTableView:tableView withIdentifier:identifier3];
            if(self.comInfo != nil){
                bottomCell.comInfo = self.comInfo;
            }
            bottomCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return bottomCell;
        }
        
    }
}

- (instancetype) initWithCompanyID:(NSString *)companyID{
    
    if(self = [super init]){
        _companyID = companyID;
    }
    return self;
}
@end
