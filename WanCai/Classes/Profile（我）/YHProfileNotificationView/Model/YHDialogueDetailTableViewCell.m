//
//  YHDialogueDetailTableViewCell.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/5.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDialogueDetailTableViewCell.h"
#import "YHDialogue.h"

@interface YHDialogueDetailTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UIButton *detailButton;

@property (nonatomic, strong) UILabel *detailLabels;

@end

@implementation YHDialogueDetailTableViewCell

- (UILabel *) timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [_timeLabel setTextColor:[UIColor grayColor]];
        _timeLabel.userInteractionEnabled = NO;
    }
    return _timeLabel;
}

- (UIButton *) detailButton{
    if(!_detailButton){
        _detailButton = [[UIButton alloc] init];
        _detailButton.userInteractionEnabled = NO;
    }
    return _detailButton;
}

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = NO;
    }
    return _iconView;
}

- (UILabel *) detailLabels{
    if(!_detailLabels){
        _detailLabels = [[UILabel alloc] init];
        _detailLabels.userInteractionEnabled = NO;
    }
    return _detailLabels;
}

- (void) setDia:(YHDialogue *)dia{
    _dia = dia;
        
    CGFloat widthAndHeight = 50;
    CGFloat x;
    if(_dia.viewTag == 0){
        x = 10;
    }else{
        x = [UIScreen mainScreen].bounds.size.width - 10 - widthAndHeight;
    }
    CGFloat y;
    if(!dia.isShowTime){
        y = 10;
    }else{
        y = 35;
    }
    
    [self.iconView setImage:[UIImage imageNamed:_dia.iconName]];
    self.iconView.frame = CGRectMake(x, y, widthAndHeight, widthAndHeight);
    self.iconView.layer.cornerRadius = widthAndHeight / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
    
    CGSize size;
    if(dia.isShowTime){
        self.timeLabel.text = [self getDateStr:_dia.date];
        size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.timeLabel.text withFont:[UIFont systemFontOfSize:12]];
        x = ([UIScreen mainScreen].bounds.size.width - size.width) / 2.0;
        y = self.iconView.frame.origin.y - size.height - 10;
        self.timeLabel.frame = CGRectMake(x, y, size.width, size.height);
    }else{
        self.timeLabel.text = @"";
    }
    
    self.detailLabels.text = _dia.detailMsg;
    self.detailLabels.font = [UIFont systemFontOfSize:16];
    self.detailLabels.numberOfLines = 0;
    [self.detailLabels setTextColor:[UIColor whiteColor]];
    y = self.iconView.frame.origin.y;
    size = [self calculateStringSize:CGSizeMake(220, MAXFLOAT) withStr:self.detailLabels.text withFont:[UIFont systemFontOfSize:16]];
    UIImage *image;
    if(_dia.viewTag == 0){
        [self.detailLabels setTextColor:[UIColor blackColor]];
        x = CGRectGetMaxX(self.iconView.frame) + 5;
        image = [UIImage imageNamed:@"chat_recive_nor"];
    }else{
        [self.detailLabels setTextColor:[UIColor whiteColor]];
        image = [UIImage imageNamed:@"chat_send_nor"];
        x = CGRectGetMinX(self.iconView.frame) - 5 - size.width - 46;
    }
    image = [image stretchableImageWithLeftCapWidth:image.size.width / 2.0 topCapHeight:image.size.height / 2.0];
    [self.detailButton setBackgroundImage:image forState:UIControlStateNormal];
    
    self.detailButton.frame = CGRectMake(x, y, size.width + 46, size.height + 36);
    [self.detailButton addSubview:self.detailLabels];
    self.detailLabels.frame = CGRectMake(23, 18, size.width, size.height);

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

- (int) HourNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int hour = (int)[calendar ordinalityOfUnit:NSHourCalendarUnit inUnit:NSDayCalendarUnit forDate:date];
    return hour;
}

- (int) MinNumFromDate:(NSDate *) date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar setFirstWeekday:2];
    int hour = (int)[calendar ordinalityOfUnit:NSMinuteCalendarUnit inUnit:NSHourCalendarUnit forDate:date];
    return hour;
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
            formate.dateFormat = @"HH:mm";
            return [NSString stringWithFormat:@"昨天%@", [formate stringFromDate:Date]];
        }else{
            formate.dateFormat = @"MM-dd";
            return [formate stringFromDate:Date];
        }
    }
    DateNum = [self HourNumFromDate:Date];
    todayDateNum = [self HourNumFromDate:today];
    if(DateNum < todayDateNum){
        formate.dateFormat = @"HH:mm";
        return [formate stringFromDate:Date];
    }
    
    formate.dateFormat = @"HH:mm";
    return [formate stringFromDate:Date];
}


- (CGSize) calculateStringSize:(CGSize )size
                       withStr:(NSString *) msg
                      withFont:(UIFont *)font{
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size;
}


+ (instancetype) cellFromTableView:(UITableView *) tabelview withIdentifier:(NSString *) identifier{
    
    YHDialogueDetailTableViewCell *cell = [tabelview dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.detailButton];
    }
    return self;
}


@end
