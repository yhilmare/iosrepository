//
//  YHSearchTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/20.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSearchTableViewCell.h"
#import "YHJobs.h"

#define tableViewCellHeight 90;

@interface YHSearchTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *jobNameLabel;

@property (nonatomic, strong) UIImageView *locationIconView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *publichMsg;

@property (nonatomic, strong) UILabel *compantNameLabel;

@property (nonatomic, strong) UILabel *salaryLabel;

@property (nonatomic, strong) UIImageView *salaryView;

@property (nonatomic, strong) UIImageView *natureView;

@property (nonatomic, strong) UILabel *natureLabel;

@end

@implementation YHSearchTableViewCell

- (CGRect) calculateFrameWidthPercent: (CGFloat) itemWidthPer
                    itemHeightPercent: (CGFloat) itemHeightPer
                         itemxPercent: (CGFloat) itemXPer
                         itemYPercent: (CGFloat) itemYPer{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = tableViewCellHeight;
    
    CGFloat itemWidth = width * itemWidthPer;
    CGFloat itemHeight = height * itemHeightPer;
    CGFloat itemX = width * itemXPer;
    CGFloat itemY = itemYPer * (height - itemHeight);
    
    return CGRectMake(itemX, itemY, itemWidth, itemHeight);
}

- (CGSize) calculateStringSize:(CGSize )size
                       withStr:(NSString *) msg
                      withFont:(UIFont *)font{
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size;
}



- (void) setJob:(YHJobs *)job{
    _job = job;
    
    CGFloat marginX = 10;
    CGFloat offset = 3;
    
    //设置工作名称Label的值以及他的frame
    self.jobNameLabel.text = self.job.JobName;
    CGSize size = [self calculateStringSize:CGSizeMake(190, 20) withStr:self.job.JobName withFont:[UIFont systemFontOfSize:15]];
    CGFloat x = CGRectGetMaxX(self.iconView.frame);
    CGFloat y = self.iconView.frame.origin.y;
    CGFloat NameHeight = size.height;
    self.jobNameLabel.frame = CGRectMake(x + marginX, y + offset, size.width, size.height);
    
    //公司名称
    size = [self calculateStringSize:CGSizeMake(190, 20) withStr:self.job.CompanyName withFont:[UIFont systemFontOfSize:13]];
    CGFloat offsetY = (self.iconView.frame.size.height - offset - NameHeight - size.height - 17) / 2.0;
    x = self.jobNameLabel.frame.origin.x;
    y = CGRectGetMaxY(self.jobNameLabel.frame) + offsetY;
    self.compantNameLabel.frame = CGRectMake(x, y, size.width, size.height);
    self.compantNameLabel.text = self.job.CompanyName;
    
    //设置定位图标的位置
    x = self.compantNameLabel.frame.origin.x;
    y = CGRectGetMaxY(self.compantNameLabel.frame);
    self.locationIconView.frame = CGRectMake(x, y + offsetY, 17, 17);
    
    x = CGRectGetMaxX(self.locationIconView.frame);
    y = self.locationIconView.frame.origin.y;
    self.locationLabel.text = self.job.CityName;
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.job.CityName withFont:[UIFont systemFontOfSize:13]];
    self.locationLabel.frame = CGRectMake(x + 2, y, size.width, size.height);
    
    //设定工作性质图标的位置
    x = CGRectGetMaxX(self.locationLabel.frame) + 26;
    y = self.locationLabel.frame.origin.y;
    self.natureView.frame = CGRectMake(x, y, 17, 17);
    
    x = CGRectGetMaxX(self.natureView.frame);
    y = self.natureView.frame.origin.y;
    self.natureLabel.text = self.job.NatureName;
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.natureLabel.text withFont:[UIFont systemFontOfSize:13]];
    self.natureLabel.frame = CGRectMake(x + 2, y, size.width, size.height);
    
    //发布日期
    NSString *msg = [self getPublishMsg:self.job.PublishDate];
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:msg withFont:[UIFont systemFontOfSize:11]];
    x = [UIScreen mainScreen].bounds.size.width - 20 - size.width;
    y = self.jobNameLabel.frame.origin.y;
    self.publichMsg.frame = CGRectMake(x, y, size.width, size.height);
    self.publichMsg.text = msg;
    
    //薪资
    self.salaryLabel.text = _job.SalaryName.length == 0?@"薪资面议":_job.SalaryName;
    if([self.salaryLabel.text isEqualToString:@"薪资面议"]){
        [self.salaryLabel setTextColor:[UIColor grayColor]];
    }else{
        [self.salaryLabel setTextColor:[UIColor colorWithRed:221 / 255.0 green:82 / 255.0 blue:69 / 255.0 alpha:1]];
    }
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.salaryLabel.text withFont:[UIFont systemFontOfSize:13]];
    x = [UIScreen mainScreen].bounds.size.width - 20 - size.width;
    y = self.locationIconView.frame.origin.y;
    self.salaryLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    x = CGRectGetMinX(self.salaryLabel.frame) - 17;
    y = self.salaryLabel.frame.origin.y;
    self.salaryView.frame = CGRectMake(x, y, 17, 17);
    
}

- (int) getYearNum:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    return (int)[calender ordinalityOfUnit:NSYearCalendarUnit inUnit:NSEraCalendarUnit forDate:date];
}
- (int) getMonthNum:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    return (int)[calender ordinalityOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
}
- (int) getDayNum:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    return (int)[calender ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
}

- (NSString *)getPublishMsg:(NSString *) publishDate{
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *date = [formate dateFromString:publishDate];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    
    NSDate *today = [NSDate date];
    interval = [zone secondsFromGMTForDate:today];
    today = [today dateByAddingTimeInterval:interval];
    
    NSComparisonResult result = [date compare:today];
    if(result == NSOrderedAscending){
        [self.publichMsg setBackgroundColor:[UIColor colorWithRed:0 green:187 / 255.0 blue:13 / 255.0 alpha:1]];
        int dateNum = [self getYearNum:date];
        int todayNum = [self getYearNum:today];
        if(dateNum < todayNum){
            [self.publichMsg setBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:206 / 255.0 blue:68 / 255.0 alpha:1]];
            formate.dateFormat = @"yy-MM-dd";
            return [NSString stringWithFormat:@"%@发布", [formate stringFromDate:date]];
        }
        dateNum = [self getMonthNum:date];
        todayNum = [self getMonthNum:today];
        if(dateNum < todayNum){
            [self.publichMsg setBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:206 / 255.0 blue:68 / 255.0 alpha:1]];
            formate.dateFormat = @"MM-dd";
            return [NSString stringWithFormat:@"%@发布", [formate stringFromDate:date]];
        }
        dateNum = [self getDayNum:date];
        todayNum = [self getDayNum:today];
        if(dateNum == todayNum){
            [self.publichMsg setBackgroundColor:[UIColor colorWithRed:0 green:187 / 255.0 blue:13 / 255.0 alpha:1]];
            return @"今天发布";
        }else if(dateNum > todayNum - 5){
            [self.publichMsg setBackgroundColor:[UIColor colorWithRed:0 green:187 / 255.0 blue:13 / 255.0 alpha:1]];
            return [NSString stringWithFormat:@"%d天前发布", todayNum - dateNum];
        }else{
            formate.dateFormat = @"MM-dd";
            return [NSString stringWithFormat:@"%@发布", [formate stringFromDate:date]];
        }
    }else{
        [self.publichMsg setBackgroundColor:[UIColor colorWithRed:0 green:187 / 255.0 blue:13 / 255.0 alpha:1]];
        return @"系统出错了";
    }
}


- (void) setIconName:(NSString *)iconName{
    _iconName = iconName;
    [self.iconView setImage:[UIImage imageNamed:_iconName]];
}

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        CGFloat height = tableViewCellHeight;
        CGFloat widthAndHeight = 63;
        _iconView.frame = [self calculateFrameWidthPercent:widthAndHeight / width itemHeightPercent:widthAndHeight / height itemxPercent:0.03 itemYPercent:0.5];
        _iconView.layer.cornerRadius = 5;
        _iconView.layer.masksToBounds = YES;
    }
    return _iconView;
}

- (UILabel *) jobNameLabel{
    if(!_jobNameLabel){
        _jobNameLabel = [[UILabel alloc] init];
        _jobNameLabel.font = [UIFont systemFontOfSize:15];
    }
    return _jobNameLabel;
}

- (UIImageView *)locationIconView{
    if(!_locationIconView){
        _locationIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"JobPalce.png"]];
    }
    return _locationIconView;
}

- (UIImageView *) natureView{
    if(!_natureView){
        _natureView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"gongzuoxingzhi"]];
    }
    return _natureView;
}

- (UIImageView *) salaryView{
    if(!_salaryView){
        _salaryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"salary"]];
    }
    return _salaryView;
}

- (UILabel *) locationLabel{
    if(!_locationLabel){
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont systemFontOfSize:13];
    }
    return _locationLabel;
}

- (UILabel *) natureLabel{
    if(!_natureLabel){
        _natureLabel = [[UILabel alloc] init];
        _natureLabel.font = [UIFont systemFontOfSize:13];
    }
    return _natureLabel;
}

- (UILabel *)salaryLabel{
    if(!_salaryLabel){
        _salaryLabel = [[UILabel alloc] init];
        _salaryLabel.font = [UIFont systemFontOfSize:13];
    }
    return _salaryLabel;
}

- (UILabel *) publichMsg{
    if(!_publichMsg){
        _publichMsg = [[UILabel alloc] init];
        _publichMsg.font = [UIFont systemFontOfSize:11];
        [_publichMsg setTextColor:[UIColor whiteColor]];
    }
    return _publichMsg;
}

- (UILabel *) compantNameLabel{
    if(!_compantNameLabel){
        _compantNameLabel = [[UILabel alloc ]init];
        _compantNameLabel.font = [UIFont systemFontOfSize:13];
        [_compantNameLabel setTextColor:[UIColor grayColor]];
    }
    return _compantNameLabel;
}

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier{
    YHSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.jobNameLabel];
        [self.contentView addSubview:self.locationIconView];
        [self.contentView addSubview:self.locationLabel];
        [self.contentView addSubview:self.publichMsg];
        [self.contentView addSubview:self.compantNameLabel];
        [self.contentView addSubview:self.salaryLabel];
        [self.contentView addSubview:self.salaryView];
        [self.contentView addSubview:self.natureView];
        [self.contentView addSubview:self.natureLabel];
    }
    return self;
}

@end
