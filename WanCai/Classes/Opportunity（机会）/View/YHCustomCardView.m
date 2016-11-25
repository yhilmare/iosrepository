//
//  YHCustomCardView.m
//  WanCai
//
//  Created by CheungKnives on 16/8/03.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCustomCardView.h"
#import "YHJobs.h"
#import "Masonry.h"
#import "YHIndusToImageTool.h"
#import "YHDashLineView.h"

@interface YHCustomCardView ()

@property (strong, nonatomic) UIView *mainView;
@property (strong, nonatomic) UILabel *bootomLabel;
@property (strong, nonatomic) UILabel *companyNameLabel;
@property (strong, nonatomic) UIImageView *iconView;
@property (strong, nonatomic) NSString *jobId;

@end

@implementation YHCustomCardView

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (instancetype)init {
    if (self = [super init]) {
        [self loadComponent];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self loadComponent];
    }
    return self;
}

- (void)loadComponent {
    self.mainView = [[UIView alloc] init];
    self.bootomLabel = [[UILabel alloc] init];
    
    self.mainView.contentMode = UIViewContentModeScaleAspectFill;
    [self.mainView.layer setMasksToBounds:YES];
    
    self.bootomLabel.textColor = [UIColor blackColor];
    self.bootomLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.mainView];
    [self addSubview:self.bootomLabel];
    
//    self.backgroundColor = [UIColor colorWithRed:0.951 green:0.951 blue:0.951 alpha:1.00];
    self.backgroundColor = [UIColor whiteColor];
}

- (void)cc_layoutSubviews {
    
    self.mainView.frame   = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    self.bootomLabel.frame = CGRectMake(0, self.frame.size.height - 54, self.frame.size.width, 0);
}

- (void)installData:(YHJobs *)job {
//    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"card_backImage"]];
    self.mainView.backgroundColor = [UIColor whiteColor];
    self.bootomLabel.font = [UIFont systemFontOfSize:18];
    // icon
    CGFloat iconViewH = 70;
    /**
     *  纵轴方向距离
     */
    CGFloat marginH = 15;
    /**
     *  横轴方向距离（左）
     */
    CGFloat marginXL = 30;
    /**
     *  横轴方向距离（右）
     */
    CGFloat marginXR = 20;
    /**
     *  文字和图标之间的距离
     */
    CGFloat margin = 3;
    /**
     *  首行文字新增距离，5s为0，以上为另一个值
     */
    CGFloat topMargin = (YHScreenWidth <= 320) ? 0 : 18;
    [self.mainView addSubview:self.iconView];
    // 工作名
    UILabel *jobNameLabel = [[UILabel alloc] init];
    jobNameLabel.font = [UIFont systemFontOfSize:18];
//    jobNameLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:jobNameLabel];
    // 公司名
    UILabel *companyLabel = [[UILabel alloc] init];
    companyLabel.font = [UIFont systemFontOfSize:15];
    companyLabel.textColor = [UIColor grayColor];
    [self.mainView addSubview:companyLabel];
    // 工作地点
    UILabel *placeLabel = [[UILabel alloc] init];
    placeLabel.font = [UIFont systemFontOfSize:15];
//    placeLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:placeLabel];
    UIImageView *placeImg = [[UIImageView alloc] init];
    placeImg.image = [UIImage imageNamed:@"JobPalce"];
    [self.mainView addSubview:placeImg];
    // 工作经验
    UILabel *workYearsLabel = [[UILabel alloc] init];
    workYearsLabel.font = [UIFont systemFontOfSize:15];
//    workYearsLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:workYearsLabel];
    UIImageView *workYearsImg = [[UIImageView alloc] init];
    workYearsImg.image = [UIImage imageNamed:@"JobExperience"];
    [self.mainView addSubview:workYearsImg];
    // 学历要求
    UILabel *degreeLabel = [[UILabel alloc] init];
    degreeLabel.font = [UIFont systemFontOfSize:15];
//    degreeLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:degreeLabel];
    UIImageView *degreeImg = [[UIImageView alloc] init];
    degreeImg.image = [UIImage imageNamed:@"JobEduInfo"];
    [self.mainView addSubview:degreeImg];
    // 工作性质
    UILabel *natureLabel = [[UILabel alloc] init];
    natureLabel.font = [UIFont systemFontOfSize:15];
//    natureLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:natureLabel];
    UIImageView *natureImg = [[UIImageView alloc] init];
    natureImg.image = [UIImage imageNamed:@"gongzuoxingzhi"];
    [self.mainView addSubview:natureImg];
    // 薪水范围
    UILabel *salaryLabel = [[UILabel alloc] init];
    salaryLabel.font = [UIFont systemFontOfSize:15];
//    salaryLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:salaryLabel];
    UIImageView *salaryImg = [[UIImageView alloc] init];
    salaryImg.image = [UIImage imageNamed:@"JobSalary"];
    [self.mainView addSubview:salaryImg];
    // 发布时间
    UILabel *dateLabel = [[UILabel alloc] init];
    dateLabel.font = [UIFont systemFontOfSize:15];
//    dateLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:dateLabel];
    UIImageView *dateImg = [[UIImageView alloc] init];
    dateImg.image = [UIImage imageNamed:@"JobTime"];
    [self.mainView addSubview:dateImg];
    // 公司名bottom
    UILabel *companyNameBottomLabel = [[UILabel alloc] init];
    companyNameBottomLabel.font = [UIFont systemFontOfSize:16];
//    companyNameBottomLabel.textColor = [UIColor whiteColor];
    [self.mainView addSubview:companyNameBottomLabel];
    // 公司性质 | 所属行业
    UILabel *natureAndIndustryLabel = [[UILabel alloc] init];
    natureAndIndustryLabel.font = [UIFont systemFontOfSize:14];
    natureAndIndustryLabel.textColor = [UIColor grayColor];
    [self.mainView addSubview:natureAndIndustryLabel];
    // topLine
    YHDashLineView *dashLineTop = [[YHDashLineView alloc] init];
    [dashLineTop setLineColor:[UIColor grayColor] LineWidth:0.5];
    dashLineTop.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:dashLineTop];
    // bottomLine
    YHDashLineView *dashLineBottom = [[YHDashLineView alloc] init];
    [dashLineBottom setLineColor:[UIColor grayColor] LineWidth:0.5];
    dashLineBottom.backgroundColor = [UIColor whiteColor];
    [self.mainView addSubview:dashLineBottom];

    // 赋值
//    self.bootomLabel.text = @"java程序员";
    //self.iconView.image = [UIImage imageNamed:@"ind_25"];
    jobNameLabel.text = job.JobName;//@"java工程师";
    companyLabel.text = job.CompanyName;//@"中国人寿";
    placeLabel.text = job.CityName;// @"无锡市";
    workYearsLabel.text = job.WorkYears;// @"2年";
    degreeLabel.text = job.DegreeName;// @"大专";
    natureLabel.text = job.NatureName;// @"全职";
    salaryLabel.text = job.SalaryName.length == 0?@"薪资面议":job.SalaryName;// @"4000";
    dateLabel.text = [self dateParse:job.PublishDate];// @"2016-5-10";
    companyNameBottomLabel.text = job.CompanyName;// @"中国人寿";
    natureAndIndustryLabel.text = [NSString stringWithFormat:@"%@ | %@",job.CompanyNatureName, job.IndustryName];// @"国企 | 互联网电子商务";
    _jobId = job.JobId;
    self.iconView.image = [UIImage imageNamed:[YHIndusToImageTool getIconWithIndustry:job.IndustryName]];
        //placeLabel.text = [NSString stringWithFormat:@"工作地点：%@",job.CityName];
     //布局
    if (YHScreenWidth <= 320) {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mainView.centerX);
            make.size.mas_equalTo(CGSizeMake(iconViewH, iconViewH));
            make.top.mas_equalTo(marginH);
        }];
    }else {
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.mainView.centerX);
            make.size.mas_equalTo(CGSizeMake(95, 95));
            make.top.mas_equalTo(marginH);
        }];
    }
    // 工作名，公司名
    [jobNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
        make.top.mas_equalTo(self.iconView.mas_bottom).with.offset(margin);
    }];
    [companyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mainView.mas_centerX);
        make.top.mas_equalTo(jobNameLabel.mas_bottom).with.offset(margin);
    }];
    // 1
    [salaryImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainView).with.offset(marginXL);
        make.top.mas_equalTo(companyLabel.mas_bottom).with.offset(marginH+topMargin);
    }];
    [salaryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(salaryImg.mas_right).with.offset(margin);
        make.centerY.mas_equalTo(salaryImg.mas_centerY);
    }];
    [degreeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainView.mas_centerX).with.offset(marginXR);
        make.centerY.mas_equalTo(salaryImg);
    }];
    [degreeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(degreeImg.mas_right).with.offset(margin);
        make.centerY.mas_equalTo(salaryImg);
    }];
    // 2
    [workYearsImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(salaryImg.mas_left);
        make.top.mas_equalTo(salaryImg.mas_bottom).with.offset(marginH);
    }];
    [workYearsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(workYearsImg.mas_right).with.offset(margin);
        make.centerY.mas_equalTo(workYearsImg.mas_centerY);
    }];
    [placeImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(degreeImg.mas_left);
        make.centerY.mas_equalTo(workYearsImg.mas_centerY);
    }];
    [placeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(placeImg.mas_right).with.offset(margin);
        make.centerY.mas_equalTo(workYearsImg.mas_centerY);
    }];
    // 3
    [natureImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(salaryImg.mas_left);
        make.top.mas_equalTo(workYearsImg.mas_bottom).with.offset(marginH);
    }];
    [natureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(natureImg.mas_right).with.offset(margin);
        make.centerY.mas_equalTo(natureImg.mas_centerY);
    }];
    [dateImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(placeImg.mas_left);
        make.centerY.mas_equalTo(natureImg.mas_centerY);
    }];
    [dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dateImg.mas_right).with.offset(margin);
        make.centerY.mas_equalTo(natureImg.mas_centerY);
    }];
    CGFloat comOffset = (YHScreenWidth <= 320) ? -8 : -5;
    CGFloat mar = (YHScreenWidth <= 320) ? 200 : 250;
    // bottom
    
    [companyNameBottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(salaryImg.mas_left);
        make.bottom.mas_equalTo(natureAndIndustryLabel.mas_top).with.offset(-margin);
        make.width.mas_equalTo(mar);
    }];
    
    [natureAndIndustryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(250);
        make.left.mas_equalTo(companyNameBottomLabel.mas_left);
        make.bottom.mas_equalTo(self.mainView.mas_bottom).with.offset(comOffset);
    }];
    // dashLine
    [dashLineTop mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mainView.left);
        make.width.mas_equalTo(self.mainView.mas_width);
        make.height.mas_equalTo(10);
        make.centerY.mas_equalTo(companyLabel.mas_bottom).with.offset(7.5);
    }];
    [dashLineBottom mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(dashLineTop.mas_left);
        make.width.mas_equalTo(dashLineTop.mas_width);
        make.height.mas_equalTo(dashLineTop.mas_height);
        make.centerY.mas_equalTo(companyNameBottomLabel.mas_top).with.offset(-4);
    }];
}

- (NSString *) dateParse:(NSString *)msg{
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *date = [format dateFromString:msg];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    format.dateFormat = @"yyyy-MM-dd";
    return [format stringFromDate:date];
}

@end

