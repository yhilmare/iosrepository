//
//  YHDialogueTableViewCell.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/4.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDialogueTableViewCell.h"
#import "YHDialogue.h"

@interface YHDialogueTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *comLabel;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation YHDialogueTableViewCell

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *) timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [_timeLabel setTextColor:[UIColor grayColor]];
    }
    return _timeLabel;
}

- (UILabel *) comLabel{
    if(!_comLabel){
        _comLabel = [[UILabel alloc] init];
        _comLabel.font = [UIFont systemFontOfSize:17];
    }
    return _comLabel;
}

- (UILabel *) detailLabel{
    if(!_detailLabel){
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:14];
        [_detailLabel setTextColor:[UIColor grayColor]];
    }
    return _detailLabel;
}

- (void) setDialogue:(YHDialogue *)dialogue{
    _dialogue = dialogue;
    
    CGFloat width = 55;
    CGFloat height = 55;
    CGFloat x = 10;
    CGFloat y = (70 - height) / 2.0;
    [self.iconView setImage:[UIImage imageNamed:_dialogue.iconName]];
    self.iconView.frame = CGRectMake(x, y, width, height);
    self.iconView.layer.cornerRadius = width / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
    self.comLabel.text = _dialogue.comName;
    CGSize size = [self calculateStringSize:CGSizeMake(215, 22) withStr:self.comLabel.text withFont:[UIFont systemFontOfSize:17]];
    CGSize tempSize = CGSizeMake(size.width, size.height);
    CGFloat temp = size.height;

    self.detailLabel.text = _dialogue.detailMsg;
    size = [self calculateStringSize:CGSizeMake(290, 20) withStr:self.detailLabel.text withFont:[UIFont systemFontOfSize:14]];
    x = CGRectGetMaxX(self.iconView.frame) + 10;
    temp = (self.iconView.frame.size.height - temp - size.height - 10) / 2.0;
    y = self.iconView.frame.origin.y + temp;
    
    self.comLabel.frame = CGRectMake(x, y, tempSize.width, tempSize.height);
    y = CGRectGetMaxY(self.comLabel.frame) + 10;
    self.detailLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    self.timeLabel.text = [self getDateStr:_dialogue.date];
    size = [self calculateStringSize:CGSizeMake(80, 22) withStr:self.timeLabel.text withFont:[UIFont systemFontOfSize:12]];
    x = [UIScreen mainScreen].bounds.size.width - size.width - 15;
    y = self.comLabel.frame.origin.y;
    self.timeLabel.frame = CGRectMake(x, y, size.width, size.height);
}

- (CGSize) calculateStringSize:(CGSize )size
                       withStr:(NSString *) msg
                      withFont:(UIFont *)font{
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size;
}

+ (instancetype) cellFromTableView:(UITableView *) tabelview withIdentifier:(NSString *) identifier{
    
    YHDialogueTableViewCell *cell = [tabelview dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}


- (int) YearNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:2];
    
    int year = (int)[calendar ordinalityOfUnit:NSYearCalendarUnit inUnit:NSEraCalendarUnit forDate:date];
    return year;
}

- (int) MonthNumFromDate:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int month = (int)[calendar ordinalityOfUnit:NSMonthCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    return month;
}

- (int) DayNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int day = (int)[calendar ordinalityOfUnit:NSDayCalendarUnit inUnit:NSYearCalendarUnit forDate:date];
    return day;
}

- (NSString *) getDateStr:(NSString *)date{
    
    NSDateFormatter *formate = [[NSDateFormatter alloc] init];
    [formate setTimeZone:[NSTimeZone systemTimeZone]];
    formate.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *Date = [formate dateFromString:date];
    
    //获取当前时间
    NSDate *today = [NSDate date];
    int DateNum = [self YearNumFromDate:Date];
    int todayDateNum = [self YearNumFromDate:today];
    if(DateNum < todayDateNum){
        formate.dateFormat = @"yy-MM-dd";
        return [formate stringFromDate:Date];
    }
    DateNum = [self MonthNumFromDate:Date];
    todayDateNum = [self MonthNumFromDate:today];
    if(DateNum < todayDateNum){
        formate.dateFormat = @"MM-dd";
        return [formate stringFromDate:Date];
    }
    DateNum = [self DayNumFromDate:Date];
    todayDateNum = [self DayNumFromDate:today];
    if(DateNum < todayDateNum){
        if(todayDateNum == DateNum + 1){
            return @"昨天";
        }else{
            formate.dateFormat = @"MM-dd";
            return [formate stringFromDate:Date];
        }
    }
    formate.dateFormat = @"HH:mm";
    return [formate stringFromDate:Date];
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.comLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.timeLabel];
    }
    return self;
}

@end
