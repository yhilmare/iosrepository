//
//  YHQATableViewCell.m
//  WanCai
//
//  Created by abing on 16/9/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHQATableViewCell.h"
#import "YHAnswerModel.h"

@interface YHQATableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *detailLable;

@property (nonatomic, strong) UILabel *commentLabel;

@property (nonatomic, strong) UIImageView *commentIcon;

@end

@implementation YHQATableViewCell

- (UILabel *) commentLabel{
    if(!_commentLabel){
        _commentLabel = [[UILabel alloc] init];
        _commentLabel.font = [UIFont systemFontOfSize:13];
        _commentLabel.textColor = [UIColor grayColor];
    }
    return _commentLabel;
}

- (UIImageView *) commentIcon{
    if(!_commentIcon){
        _commentIcon = [[UIImageView alloc] init];
        [_commentIcon setImage:[UIImage imageNamed:@"timeline_icon_comment"]];
    }
    return _commentIcon;
}

- (UILabel *) timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.textColor = [UIColor grayColor];
    }
    return _timeLabel;
}

- (UILabel *) titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc] init];
        
    }
    return _titleLabel;
}

- (UILabel *) detailLable{
    if(!_detailLable){
        _detailLable = [[UILabel alloc] init];
        _detailLable.font = [UIFont systemFontOfSize:11];
        _detailLable.textColor = [UIColor grayColor];
        _detailLable.numberOfLines = 0;
    }
    return _detailLable;
}

- (UILabel *) nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:15];
        [_nameLabel setTextColor:[UIColor orangeColor]];
    }
    return _nameLabel;
}
- (UIImageView *) iconView{
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}


- (void) setModel:(YHAnswerModel *)model{
    _model = model;
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat width = 50;
    CGFloat height = 50;
    [self.iconView setImage:[UIImage imageNamed:_model.iconName]];
    self.iconView.frame = CGRectMake(x, y, width, height);
    self.iconView.layer.cornerRadius = width / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
    self.nameLabel.text = _model.userName;
    x = CGRectGetMaxX(self.iconView.frame) + 10;
    CGSize size = [self getMsg:self.nameLabel.text constraintSize:CGSizeMake(220, 20) withFont:[UIFont systemFontOfSize:15]];
    width = size.width;
    height = size.height;
    self.nameLabel.frame = CGRectMake(x, y, width, height);
    
    self.titleLabel.text = _model.title;
    y = CGRectGetMaxY(self.nameLabel.frame) + 5;
    size = [self getMsg:self.titleLabel.text constraintSize:CGSizeMake(250, 20) withFont:[UIFont systemFontOfSize:17]];
    width = size.width;
    height = size.height;
    self.titleLabel.frame = CGRectMake(x, y, width, height);
    
    self.timeLabel.text = [self getDate:_model.date];
    size = [self getMsg:self.timeLabel.text constraintSize:CGSizeMake(MAXFLOAT, 20) withFont:[UIFont systemFontOfSize:13]];
    width = size.width;
    height = size.height;
    x = [UIScreen mainScreen].bounds.size.width - width - 15;
    y = self.nameLabel.frame.origin.y;
    self.timeLabel.frame = CGRectMake(x, y, width, height);
    
    if(model.answers.count != 0){
        NSMutableString *msg = [NSMutableString string];
        if(model.answers.count > 3){
            for(int i = 0; i < 3; i ++){
                NSString *str = model.answers[i];
                [msg appendString:[NSString stringWithFormat:@"%@ ", str]];
            }
            self.detailLable.text = [NSString stringWithFormat:@"%@等回答了该问题",msg];
        }else{
            for(NSString *str in model.answers){
                [msg appendString:[NSString stringWithFormat:@"%@ ", str]];
            }
            self.detailLable.text = [NSString stringWithFormat:@"%@回答了该问题",msg];
        }
    }else{
        self.detailLable.text = @"还没有人回答该问题";
    }
    size = [self getMsg:self.detailLable.text constraintSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 80, 60) withFont:[UIFont systemFontOfSize:11]];
    x = self.titleLabel.frame.origin.x;
    y = CGRectGetMaxY(self.titleLabel.frame) + 5;
    self.detailLable.frame = CGRectMake(x, y, size.width, size.height);
    
    self.commentLabel.text = _model.comment;
    
}

- (void) layoutSubviews{
    [super layoutSubviews];
    
    CGFloat rowHeight = self.contentView.frame.size.height;
    
    CGSize size = [self getMsg:self.commentLabel.text constraintSize:CGSizeMake(50, 20) withFont:[UIFont systemFontOfSize:13]];
    CGFloat x = [UIScreen mainScreen].bounds.size.width - 15 - size.width;
    CGFloat y = rowHeight - size.height - 10;
    self.commentLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    x = CGRectGetMinX(self.commentLabel.frame) - size.height - 3 - 3;
    self.commentIcon.frame = CGRectMake(x, y - 1.5, size.height + 3, size.height + 3);
    
}


+ (instancetype) cellFromTableView:(UITableView *) tableView withReuseIdentifier:(NSString *) identifier{
    YHQATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.detailLable];
        [self.contentView addSubview:self.commentLabel];
        [self.contentView addSubview:self.commentIcon];
    }
    return self;
}

- (CGSize) getMsg:(NSString *)msg constraintSize:(CGSize) size withFont:(UIFont *) font{
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

- (NSString *) getDate:(NSString *) date{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *time = [format dateFromString:date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:time];
    time = [time dateByAddingTimeInterval:interval];
    
    NSDate *today = [NSDate date];
    interval = [zone secondsFromGMTForDate:today];
    today = [today dateByAddingTimeInterval:interval];
    if([self getYearNum:time] == [self getYearNum:today]){
        format.dateFormat = @"MM-dd";
    }else{
        format.dateFormat = @"yy-MM-dd";
    }
    return [format stringFromDate:time];
}

- (int) getYearNum:(NSDate *)date{
    NSCalendar *calender = [NSCalendar currentCalendar];
    
    return (int)[calender ordinalityOfUnit:NSYearCalendarUnit inUnit:NSEraCalendarUnit forDate:date];
}

@end
