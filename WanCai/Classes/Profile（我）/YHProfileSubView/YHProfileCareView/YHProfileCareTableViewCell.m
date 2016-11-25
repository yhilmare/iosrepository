//
//  YHProfileCareTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/22.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileCareTableViewCell.h"
#import "YHAttentionToMeCompany.h"


#define tableViewCellHeight 60;

@interface YHProfileCareTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *comName;

@property (nonatomic,strong) UILabel *timeLabel;

@property (nonatomic, strong) UILabel *resumeLabel;

@end

@implementation YHProfileCareTableViewCell

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *) comName{
    if(!_comName){
        _comName = [[UILabel alloc] init];
        _comName.font = [UIFont systemFontOfSize:15];
        //[_comName setBackgroundColor:[UIColor redColor]];
    }
    return _comName;
}

- (UILabel *) timeLabel{
    if(!_timeLabel){
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.font = [UIFont systemFontOfSize:12];
        [_timeLabel setTextColor:[UIColor grayColor]];
    }
    return _timeLabel;
}

- (UILabel *) resumeLabel{
    if(!_resumeLabel){
        _resumeLabel = [[UILabel alloc] init];
        _resumeLabel.font = [UIFont systemFontOfSize:12];
        [_resumeLabel setTextColor:[UIColor grayColor]];
    }
    return _resumeLabel;
}



- (void) setAttCom:(YHAttentionToMeCompany *)attCom{
    _attCom = attCom;
    
    CGFloat cellHeight = tableViewCellHeight;
    CGFloat imgHeightandWidth = 40;
    if(_attCom.IsDelete){
        [self.iconView setImage:[UIImage imageNamed:@"opp_nope"]];
    }else{
        [self.iconView setImage:[UIImage imageNamed:@"opp_liked"]];
    }
    self.iconView.frame = CGRectMake(10, (cellHeight - imgHeightandWidth) / 2.0, imgHeightandWidth, imgHeightandWidth);
    self.iconView.layer.cornerRadius = (imgHeightandWidth) / 2.0;
    self.iconView.layer.masksToBounds = YES;
    
    self.comName.text = _attCom.CompanyName.length == 0?@"企业暂时不公开":_attCom.CompanyName;
    CGSize size = [self calculateSizeByString:self.comName.text withFont:[UIFont systemFontOfSize:15] constraintSize:CGSizeMake(250, 20)];
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + 10;
    CGFloat y = self.iconView.frame.origin.y;
    self.comName.frame = CGRectMake(x, y, size.width, size.height);
    
    self.timeLabel.text = _attCom.ViewDate.length == 0?@"企业暂时不对外公开":[self getTimeWithFormat:_attCom.ViewDate];
    size = [self calculateSizeByString:self.timeLabel.text withFont:[UIFont systemFontOfSize:12] constraintSize:CGSizeMake(MAXFLOAT, 20)];
    x = self.comName.frame.origin.x;
    y = CGRectGetMaxY(self.iconView.frame) - size.height;
    self.timeLabel.frame = CGRectMake(x, y, size.width, size.height);
    
    
    self.resumeLabel.text = _attCom.ResumeName.length == 0?@"企业暂时保密":[NSString stringWithFormat:@"查看了您的%@简历", _attCom.ResumeName];
    size = [self calculateSizeByString:self.resumeLabel.text withFont:[UIFont systemFontOfSize:12] constraintSize:CGSizeMake(MAXFLOAT , 20)];
    x = CGRectGetMaxX(self.timeLabel.frame) + 5;
    y = self.timeLabel.frame.origin.y;
    self.resumeLabel.frame = CGRectMake(x, y, size.width, size.height);
}

- (CGSize) calculateSizeByString:(NSString *) msg withFont:(UIFont *)font constraintSize:(CGSize) size{
    
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil].size;
}

+ (instancetype) cellFromTableView:(UITableView *)tableView withIdentifier:(NSString *) identifier{
    
    YHProfileCareTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.comName];
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.resumeLabel];
    }
    return self;
}

- (NSString *) getTimeWithFormat:(NSString *)date{
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    [format setTimeZone:[NSTimeZone systemTimeZone]];
    NSDate *dest = [format dateFromString:date];
    
    format.dateFormat = @"HH:mm";
    return [format stringFromDate:dest];
}


@end
