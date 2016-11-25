//
//  YHApplicationTableViewCell.m
//  WanCai
//
//  Created by CheungKnives on 16/8/1.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHApplyTableViewCell.h"
#import "YHMyJobApply.h"

#define tableViewCellHeight 90;

@interface YHApplyTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *jobNameLabel;

@property (nonatomic, strong) UIImageView *locationIconView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UILabel *publichMsg;

@property (nonatomic, strong) UILabel *compantNameLabel;

@property (nonatomic, strong) UILabel *applyDateLabel;

@property (nonatomic, strong) UIImageView *applyDateView;

@end

@implementation YHApplyTableViewCell

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



- (void) setMyJobApply:(YHMyJobApply *)myJobApply{
    _myJobApply = myJobApply;
    
    CGFloat marginX = 10;
    CGFloat offset = 3;
    
    //工作名称
    self.jobNameLabel.text = self.myJobApply.JobName;
    CGSize size = [self calculateStringSize:CGSizeMake(190, 20) withStr:self.myJobApply.JobName withFont:[UIFont systemFontOfSize:15]];
    CGFloat x = CGRectGetMaxX(self.iconView.frame);
    CGFloat y = self.iconView.frame.origin.y;
    CGFloat NameHeight = size.height;
    self.jobNameLabel.frame = CGRectMake(x + marginX, y + offset, size.width, size.height);
    
    //公司名称
    size = [self calculateStringSize:CGSizeMake(190, 20) withStr:self.myJobApply.CompanyName withFont:[UIFont systemFontOfSize:13]];
    CGFloat offsetY = (self.iconView.frame.size.height - offset - NameHeight - size.height - 17) / 2.0;
    x = self.jobNameLabel.frame.origin.x;
    y = CGRectGetMaxY(self.jobNameLabel.frame) + offsetY;
    self.compantNameLabel.frame = CGRectMake(x, y, size.width, size.height);
    self.compantNameLabel.text = self.myJobApply.CompanyName;
    
    //定位图标
    x = self.compantNameLabel.frame.origin.x;
    y = CGRectGetMaxY(self.compantNameLabel.frame);
    self.locationIconView.frame = CGRectMake(x, y + offsetY, 17, 17);
    
    x = CGRectGetMaxX(self.locationIconView.frame);
    y = self.locationIconView.frame.origin.y;
    self.locationLabel.text = self.myJobApply.CityName;
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.myJobApply.CityName withFont:[UIFont systemFontOfSize:13]];
    self.locationLabel.frame = CGRectMake(x + 2, y, size.width, size.height);
    

    
    
    self.applyDateLabel.text = [self getDate:_myJobApply.ApplyDate];
    [self.applyDateLabel setTextColor:[UIColor grayColor]];
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.applyDateLabel.text withFont:[UIFont systemFontOfSize:13]];
    x = CGRectGetMaxX(self.locationLabel.frame) + 26;
    y = self.locationLabel.frame.origin.y;
    self.applyDateView.frame = CGRectMake(x, y, 17, 17);
    x = CGRectGetMaxX(self.applyDateView.frame) + 2;
    y = self.applyDateView.frame.origin.y;
    self.applyDateLabel.frame = CGRectMake(x, y, size.width, size.height);
    //发布日期
    NSString *msg = [self getPublishMsg:self.myJobApply.CreateDate];
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:msg withFont:[UIFont systemFontOfSize:11]];
    x = [UIScreen mainScreen].bounds.size.width - 20 - size.width;
    y = self.jobNameLabel.frame.origin.y;
    self.publichMsg.frame = CGRectMake(x, y, size.width, size.height);
    self.publichMsg.text = msg;
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

- (NSString *) getDate:(NSString *) dates{
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setTimeZone:[NSTimeZone systemTimeZone]];
    formate.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    
    NSDate *date = [formate dateFromString:dates];
    formate.dateFormat = @"yy-MM-dd";
    return [formate stringFromDate:date];
}

- (NSString *)getPublishMsg:(NSString *) publishDate{
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    formate.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *date = [formate dateFromString:publishDate];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    
    NSDate *today = [NSDate date];
//    interval = [zone secondsFromGMTForDate:today];
//    today = [today dateByAddingTimeInterval:interval];
//    
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
            return [NSString stringWithFormat:@"%@创建", [formate stringFromDate:date]];
        }
        dateNum = [self getMonthNum:date];
        todayNum = [self getMonthNum:today];
        if(dateNum < todayNum){
            [self.publichMsg setBackgroundColor:[UIColor colorWithRed:255 / 255.0 green:206 / 255.0 blue:68 / 255.0 alpha:1]];
            formate.dateFormat = @"MM-dd";
            return [NSString stringWithFormat:@"%@创建", [formate stringFromDate:date]];
        }
        dateNum = [self getDayNum:date];
        todayNum = [self getDayNum:today];
        if(dateNum == todayNum){
            [self.publichMsg setBackgroundColor:[UIColor colorWithRed:0 green:187 / 255.0 blue:13 / 255.0 alpha:1]];
            return @"今天创建";
        }else if(dateNum > todayNum - 5){
            [self.publichMsg setBackgroundColor:[UIColor colorWithRed:0 green:187 / 255.0 blue:13 / 255.0 alpha:1]];
            return [NSString stringWithFormat:@"%d天前创建", todayNum - dateNum];
        }else{
            formate.dateFormat = @"MM-dd";
            return [NSString stringWithFormat:@"%@创建", [formate stringFromDate:date]];
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


- (UIImageView *) applyDateView{
    if(!_applyDateView){
        _applyDateView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"JobTime"]];
    }
    return _applyDateView;
}

- (UILabel *) locationLabel{
    if(!_locationLabel){
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont systemFontOfSize:13];
    }
    return _locationLabel;
}

- (UILabel *)applyDateLabel{
    if(!_applyDateLabel){
        _applyDateLabel = [[UILabel alloc] init];
        _applyDateLabel.font = [UIFont systemFontOfSize:13];
    }
    return _applyDateLabel;
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
    YHApplyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
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
        [self.contentView addSubview:self.applyDateLabel];
        [self.contentView addSubview:self.applyDateView];
    }
    return self;
}

@end
