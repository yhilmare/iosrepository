//
//  YHJobInfoCell.m
//  WanCai
//
//  Created by CheungKnives on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHJobInfoCell.h"
#import "YHJobs.h"

@interface YHJobInfoCell()

@property (nonatomic, weak) IBOutlet UIImageView *jobImageView;
@property (nonatomic, weak) IBOutlet UILabel *jobNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *updateDataLabel;
@property (nonatomic, weak) IBOutlet UILabel *companyNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *CityNameLabel;
@property (nonatomic, weak) IBOutlet UILabel *salaryLabel;

@end

@implementation YHJobInfoCell

//创建自定义可重用的cell对象
+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *reuseId = @"knivesjobinfocell";
    YHJobInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseId];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"YHJobInfoCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

//重写属性的setter方法，给子控件赋值
- (void)setJob:(YHJobs *)job{
    _job = job;
    
    self.jobImageView.image = [UIImage imageNamed:@"company_holder"];
    self.jobNameLabel.text = job.JobName;
    self.updateDataLabel.text = job.PublishDate;
    self.companyNameLabel.text = job.CompanyName;
    self.CityNameLabel.text = job.CityName;
    if([job.SalaryName isEqualToString:@""]) {
        self.salaryLabel.text = @"工资面议";
    }else {
    self.salaryLabel.text = job.SalaryName;
    }
}

@end
