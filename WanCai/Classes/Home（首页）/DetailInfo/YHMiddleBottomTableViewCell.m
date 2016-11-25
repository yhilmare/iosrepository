//
//  YHMiddleBottomTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHMiddleBottomTableViewCell.h"
#import "YHJobs.h"

#define tableViewCellHeight 150;

@interface YHMiddleBottomTableViewCell()

@property (nonatomic, strong) UILabel *companyNameLabel;

@property (nonatomic, strong) UILabel *companyAttr;

@property (nonatomic, strong) UILabel *companySize;

@property (nonatomic, strong) UILabel *companyType;

@end

@implementation YHMiddleBottomTableViewCell


- (void) setJob:(YHJobs *)job{
    _job = job;
    
    CGFloat marginY = 15;
    
    CGSize size = [self calculateSize:CGSizeMake(MAXFLOAT, 20) withString:job.CompanyName withFont:[UIFont systemFontOfSize:16] withColor:[UIColor blackColor]];
    _companyNameLabel.font = [UIFont systemFontOfSize:16];
    [_companyNameLabel setTextColor:[UIColor blackColor]];
    _companyNameLabel.text = job.CompanyName;
    _companyNameLabel.frame = CGRectMake(19, 7.5, size.width, size.height);
    
    NSString *companyAttr = [NSString stringWithFormat:@"%@",job.IndustryName];
    size = [self calculateSize:CGSizeMake(200, 20) withString:companyAttr withFont:[UIFont systemFontOfSize:15] withColor:[UIColor grayColor]];
    _companyAttr.font = [UIFont systemFontOfSize:15];
    [_companyAttr setTextColor:[UIColor grayColor]];
    _companyAttr.text = companyAttr;
    CGFloat y = CGRectGetMaxY(_companyNameLabel.frame);
    _companyAttr.frame = CGRectMake(_companyNameLabel.frame.origin.x, y + marginY, size.width, size.height);
    
    NSString *companyNature = [NSString stringWithFormat:@" | %@", job.CompanyNatureName];
    size = [self calculateSize:CGSizeMake([UIScreen mainScreen].bounds.size.width - 238, 20) withString:companyNature withFont:[UIFont systemFontOfSize:15] withColor:[UIColor grayColor]];
    _companySize.font = [UIFont systemFontOfSize:15];
    [_companySize setTextColor:[UIColor grayColor]];
    _companySize.text = companyNature;
    CGFloat x = CGRectGetMaxX(_companyAttr.frame);
    self.companySize.frame = CGRectMake(x, y + marginY, size.width, size.height);
    
//    size = [self calculateSize:CGSizeMake(MAXFLOAT, 20) withString:job.CompanyNatureName withFont:[UIFont systemFontOfSize:15] withColor:[UIColor blackColor]];
//    _companyType.font = [UIFont systemFontOfSize:15];
//    [_companyType setTextColor:[UIColor grayColor]];
//    _companyType.text = job.CompanyNatureName;
//    CGFloat x = YHScreenWidth - 30 - size.width;
//    _companyType.frame = CGRectMake(x, _companyAttr.frame.origin.y, size.width, size.height);
}

- (CGSize) calculateSize:(CGSize)maxSize
              withString:(NSString *) string
                withFont:(UIFont *)font
               withColor:(UIColor *)color{
    return [string boundingRectWithSize:maxSize options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:color} context:nil].size;
}

- (UILabel *)companyNameLabel{
    if(!_companyNameLabel){
        _companyNameLabel = [[UILabel alloc] init];
    }
    return _companyNameLabel;
}

- (UILabel *)companyAttr{
    if(!_companyAttr){
        _companyAttr = [[UILabel alloc] init];
    }
    return _companyAttr;
}

- (UILabel *)companySize{
    if(!_companySize){
        _companySize = [[UILabel alloc] init];
    }
    return _companySize;
}

- (UILabel *)companyType{
    if(!_companyType){
        _companyType = [[UILabel alloc] init];
    }
    return _companyType;
}

+ (instancetype) cellFromTableView:(UITableView *)tableView withIdentifier:(NSString *)identifier{
    YHMiddleBottomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.companyAttr];
        [self.contentView addSubview:self.companyNameLabel];
        [self.contentView addSubview:self.companySize];
        //[self.contentView addSubview:self.companyType];
    }
    return self;
}


@end
