//
//  YHCompanyTableViewBottomCellTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyTableViewBottomCellTableViewCell.h"
#import "YHCompanyInfo.h"

@interface YHCompanyTableViewBottomCellTableViewCell()

@property (nonatomic, strong) UILabel *comName;

@property (nonatomic, strong) UILabel *companyName;

@property (nonatomic, strong) UILabel *email;

@property (nonatomic, strong) UILabel *emailLabel;

@property (nonatomic, strong) UILabel *URL;

@property (nonatomic, strong) UILabel *URLLabel;

@property (nonatomic, strong) UILabel *updateTime;

@property (nonatomic, strong) UILabel *updateLabel;

@end

@implementation YHCompanyTableViewBottomCellTableViewCell

- (CGSize) calculateStringSize:(CGSize )size
                       withStr:(NSString *) msg
                      withFont:(UIFont *)font{
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size;
}

- (UILabel *)comName{
    if(!_comName){
        _comName = [[UILabel alloc] init];
        _comName.font = [UIFont systemFontOfSize:15];
        [_comName setText:@"公司名称："];
        [_comName setTextColor:[UIColor grayColor]];
    }
    return _comName;
}

- (UILabel *) companyName{
    if(!_companyName){
        _companyName = [[UILabel alloc] init];
        _companyName.font = [UIFont systemFontOfSize:14];
        _companyName.textColor = [UIColor grayColor];
    }
    return _companyName;
}

- (UILabel *) emailLabel{
    if(!_emailLabel){
        _emailLabel = [[UILabel alloc] init];
        _emailLabel.font = [UIFont systemFontOfSize:14];
        _emailLabel.textColor = [UIColor grayColor];
    }
    return _emailLabel;
}

- (UILabel *) URLLabel{
    if(!_URLLabel){
        _URLLabel = [[UILabel alloc] init];
        _URLLabel.font = [UIFont systemFontOfSize:14];
        _URLLabel.textColor = [UIColor grayColor];
    }
    return _URLLabel;
}

- (UILabel *) email{
    if(!_email){
        _email = [[UILabel alloc] init];
        _email.font = [UIFont systemFontOfSize:15];
        [_email setText:@"电子邮件："];
        [_email setTextColor:[UIColor grayColor]];
    }
    return _email;
}

- (UILabel *) URL{
    if(!_URL){
        _URL = [[UILabel alloc] init];
        _URL.font = [UIFont systemFontOfSize:15];
        [_URL setText:@"公司网址："];
        [_URL setTextColor:[UIColor grayColor]];
    }
    return _URL;
}

- (UILabel *) updateTime{
    if(!_updateTime){
        _updateTime = [[UILabel alloc] init];
        _updateTime.font = [UIFont systemFontOfSize:15];
        [_updateTime setText:@"更新时间："];
        [_updateTime setTextColor:[UIColor grayColor]];
    }
    return _updateTime;
}

- (UILabel *) updateLabel{
    if(!_updateLabel){
        _updateLabel = [[UILabel alloc] init];
        _updateLabel.font = [UIFont systemFontOfSize:14];
        [_updateLabel setTextColor:[UIColor grayColor]];
    }
    return _updateLabel;
}


- (void) setComInfo:(YHCompanyInfo *)comInfo{
    _comInfo = comInfo;
    
    CGFloat marginX = 0;
    CGFloat marginY = 10;
    
    CGSize size1 = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:@"公司名称：" withFont:[UIFont systemFontOfSize:15]];
    self.comName.frame = CGRectMake(15, 15, size1.width, size1.height);
    
    self.companyName.text = _comInfo.CompanyName;
    CGFloat x = CGRectGetMaxX(self.comName.frame) + marginX;
    CGFloat y = self.comName.frame.origin.y;
    CGSize size  = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:_comInfo.CompanyName withFont:[UIFont systemFontOfSize:14]];
    self.companyName.frame = CGRectMake(x, y, size.width, size1.height);
    
    CGSize size2 = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:@"电子邮件：" withFont:[UIFont systemFontOfSize:15]];
    x = self.comName.frame.origin.x;
    y = CGRectGetMaxY(self.comName.frame) + marginY;
    self.email.frame = CGRectMake(x, y, size2.width, size2.height);
    
    self.emailLabel.text = _comInfo.Email.length == 0?@"企业暂不对外公开":_comInfo.Email;
    CGSize size3 = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.emailLabel.text withFont:[UIFont systemFontOfSize:14]];
    x = self.companyName.frame.origin.x;
    y = CGRectGetMaxY(self.companyName.frame) + marginY;
    self.emailLabel.frame = CGRectMake(x, y, size3.width, size2.height);
    
    CGSize size4 = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:@"公司网址：" withFont:[UIFont systemFontOfSize:15]];
    x = self.email.frame.origin.x;
    y = CGRectGetMaxY(self.email.frame) + marginY;
    self.URL.frame = CGRectMake(x, y, size4.width, size4.height);
    
    self.URLLabel.text = _comInfo.CompanyUrl.length == 0?@"企业暂不对外公开":_comInfo.CompanyUrl;
    CGSize size5 = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.URLLabel.text withFont:[UIFont systemFontOfSize:14]];
    x = self.emailLabel.frame.origin.x;
    y = CGRectGetMaxY(self.email.frame) + marginY;
    self.URLLabel.frame = CGRectMake(x, y, size5.width, size4.height);
    
    CGSize size6 = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:@"更新时间：" withFont:[UIFont systemFontOfSize:15]];
    x = self.URL.frame.origin.x;
    y = CGRectGetMaxY(self.URL.frame) + marginY;
    self.updateTime.frame = CGRectMake(x, y, size6.width, size6.height);
    
    self.updateLabel.text = [self timeUtils:_comInfo.UpdateDate];
    CGSize size7 = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:self.updateLabel.text withFont:[UIFont systemFontOfSize:14]];
    x = self.URLLabel.frame.origin.x;
    y = CGRectGetMaxY(self.URLLabel.frame) + marginY;
    self.updateLabel.frame = CGRectMake(x, y, size7.width, size6.height);
}

- (NSString *) timeUtils:(NSString *)updateTime{
    
    if(updateTime == nil || updateTime.length == 0){
        return @"暂无信息";
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = @"yyyy/MM/dd HH:mm:ss";
    NSDate *date = [format dateFromString:updateTime];
    
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:date];
    date = [date dateByAddingTimeInterval:interval];
    
    NSDate *today = [NSDate date];
    interval = [zone secondsFromGMTForDate:today];
    today = [today dateByAddingTimeInterval:interval];

    interval = [today timeIntervalSinceDate:date] / 86400;
    
    if(interval <= 5){
        if(interval == 0){
            return @"今天";
        }else{
            return [NSString stringWithFormat:@"%d天前", (int)interval];
        }
    }else{
        format.dateFormat = @"yyyy-MM-dd";
        return [format stringFromDate:date];
    }
}

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier{
    YHCompanyTableViewBottomCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return  cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.comName];
        [self.contentView addSubview:self.companyName];
        [self.contentView addSubview:self.email];
        [self.contentView addSubview:self.emailLabel];
        [self.contentView addSubview:self.URL];
        [self.contentView addSubview:self.URLLabel];
        [self.contentView addSubview:self.updateTime];
        [self.contentView addSubview:self.updateLabel];
    }
    return self;
}



@end
