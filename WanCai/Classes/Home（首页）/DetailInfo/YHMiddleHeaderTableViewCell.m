//
//  YHMiddleHeaderTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHMiddleHeaderTableViewCell.h"
#import "YHMiddleHeaderView.h"
#import "YHJobs.h"

#define tableViewCellHeight 100;

@interface YHMiddleHeaderTableViewCell()

@property(nonatomic, strong) YHMiddleHeaderView *salaryView;

@property(nonatomic, strong) YHMiddleHeaderView *locationview;

@property(nonatomic, strong) YHMiddleHeaderView *companySizeView;

@property(nonatomic, strong) YHMiddleHeaderView *degreeView;

@property(nonatomic, strong) YHMiddleHeaderView *attrView;

@property(nonatomic, strong) YHMiddleHeaderView *DateView;

@property(nonatomic, strong) YHMiddleHeaderView *workYearView;

@end

@implementation YHMiddleHeaderTableViewCell

- (CGRect) calculateFrameWidthPercent: (CGFloat) itemWidthPer
                    itemHeightPercent: (CGFloat) itemHeightPer
                         itemxPercent: (CGFloat) itemXPer
                         itemYPercent: (CGFloat) itemYPer{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = tableViewCellHeight;
    
    CGFloat itemWidth = width * itemWidthPer;
    CGFloat itemHeight = height * itemHeightPer;
    CGFloat itemX = (width - itemWidth) * itemXPer;
    CGFloat itemY = itemYPer * height;
    
    return CGRectMake(itemX, itemY, itemWidth, itemHeight);
}


- (void) setJob:(YHJobs *)job{
    _job = job;
    CGFloat cellHeight = tableViewCellHeight;
    CGFloat viewHeight = 20;
    
    _salaryView.iconName = @"JobSalary.png";
    _salaryView.labelName = job.SalaryName.length == 0?@"薪资面议":job.SalaryName;
    _salaryView.frame = [self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:0.07 itemYPercent:0.10];
    
    _locationview.iconName = @"JobPalce.png";
    _locationview.labelName = job.CityName.length == 0?@"暂无数据":job.CityName;
    _locationview.frame = [self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:0.07 itemYPercent:0.38];
    
    _degreeView.iconName = @"JobEduInfo.png";
    _degreeView.labelName = job.DegreeName.length == 0?@"暂无数据":job.DegreeName;
    _degreeView.frame = [self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:0.59 itemYPercent:0.10];
    
    _attrView.iconName = @"gongzuoxingzhi.png";
    _attrView.labelName = job.NatureName.length == 0?@"暂无数据":job.NatureName;
    _attrView.frame = [self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:0.59 itemYPercent:0.38];
    
    
    
    _DateView.iconName = @"JobTime.png";
    
    _DateView.labelName = job.PublishDate.length == 0?@"暂无数据":[job.PublishDate substringToIndex:9];
    _DateView.frame = [self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:1.06 itemYPercent:0.38];//[self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:1.06 itemYPercent:0.05];
    
    _workYearView.iconName = @"experience.png";
    _workYearView.labelName = job.WorkYears.length == 0?@"暂无数据":job.WorkYears;
    _workYearView.frame = [self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:1.06 itemYPercent:0.10];//[self calculateFrameWidthPercent:0.31 itemHeightPercent: viewHeight / cellHeight itemxPercent:1.06 itemYPercent:0.38];
}

- (YHMiddleHeaderView *)salaryView{
    if(!_salaryView){
        _salaryView = [[YHMiddleHeaderView alloc] init];
    }
    return _salaryView;
}

- (YHMiddleHeaderView *)locationview{
    if(!_locationview){
        _locationview = [[YHMiddleHeaderView alloc] init];
    }
    return _locationview;
}

- (YHMiddleHeaderView *)companySizeView{
    if(!_companySizeView){
        _companySizeView = [[YHMiddleHeaderView alloc] init];
    }
    return _companySizeView;
}

- (YHMiddleHeaderView *)degreeView{
    if(!_degreeView){
        _degreeView = [[YHMiddleHeaderView alloc] init];
    }
    return _degreeView;
}

- (YHMiddleHeaderView *)attrView{
    if(!_attrView){
        _attrView = [[YHMiddleHeaderView alloc] init];
    }
    return _attrView;
}

- (YHMiddleHeaderView *)DateView{
    if(!_DateView){
        _DateView = [[YHMiddleHeaderView alloc] init];
    }
    return _DateView;
}

- (YHMiddleHeaderView *)workYearView{
    if(!_workYearView){
        _workYearView = [[YHMiddleHeaderView alloc] init];
    }
    return _workYearView;
}

+ (instancetype) cellWithIdentifier:(NSString *)identifier withTableView:(UITableView *)tableView{
    YHMiddleHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self.contentView addSubview:self.salaryView];
        [self.contentView addSubview:self.locationview];
        //[self.contentView addSubview:self.companySizeView];
        [self.contentView addSubview:self.degreeView];
        [self.contentView addSubview:self.attrView];
        [self.contentView addSubview:self.DateView];
        [self.contentView addSubview:self.workYearView];
    }
    return self;
}


@end
