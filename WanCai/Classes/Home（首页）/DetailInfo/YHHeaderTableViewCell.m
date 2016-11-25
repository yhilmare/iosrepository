//
//  YHHeaderTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/16.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHHeaderTableViewCell.h"
#define tableViewCellHeight 150;

@interface YHHeaderTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *jobNamelabel;

@property (nonatomic, strong) UILabel *compantNamelabel;

@end

@implementation YHHeaderTableViewCell

- (CGRect) calculateFrameWidthPercent: (CGFloat) itemWidthPer
                    itemHeightPercent: (CGFloat) itemHeightPer
                         itemxPercent: (CGFloat) itemXPer
                         itemYPercent: (CGFloat) itemYPer{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = tableViewCellHeight;
    
    CGFloat itemWidth = width * itemWidthPer;
    CGFloat itemHeight = height * itemHeightPer;
    CGFloat itemX = (width - itemWidth) * itemXPer;
    CGFloat itemY = itemYPer * height;
    
    return CGRectMake(itemX, itemY, itemWidth, itemHeight);
}

- (UILabel *)jobNamelabel{
    if(!_jobNamelabel){
        _jobNamelabel = [[UILabel alloc] init];
        _jobNamelabel.textAlignment = NSTextAlignmentCenter;
        [_jobNamelabel setTextColor:[UIColor colorWithRed:0 green:173 / 255.0 blue:142 / 255.0 alpha:1]];
        _jobNamelabel.font = [UIFont systemFontOfSize:17];
    }
    return _jobNamelabel;
}

- (UILabel *)compantNamelabel{
    if(!_compantNamelabel){
        _compantNamelabel = [[UILabel alloc] init];
        _compantNamelabel.textAlignment = NSTextAlignmentCenter;
        _compantNamelabel.font = [UIFont systemFontOfSize:13];
    }
    return _compantNamelabel;
}

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (void) setIconName:(NSString *)iconName{
    _iconName = iconName;
    [_iconView setImage:[UIImage imageNamed:_iconName]];
    
    CGFloat widthandHeight = 70;
    CGFloat widthPer = widthandHeight / [UIScreen mainScreen].bounds.size.width;
    CGFloat heightPer = widthandHeight / tableViewCellHeight;
    _iconView.frame = [self calculateFrameWidthPercent:widthPer itemHeightPercent:heightPer itemxPercent:0.5 itemYPercent:0.1];
}

- (void) setJobName:(NSString *)jobName{
    _jobName = jobName;
    _jobNamelabel.text = jobName;
    CGFloat heightPer = 20.0 / tableViewCellHeight;
    _jobNamelabel.frame = [self calculateFrameWidthPercent:1 itemHeightPercent:heightPer itemxPercent:0 itemYPercent:0.63];
}

- (void) setCompanyName:(NSString *)companyName{
    _companyName = companyName;
    _compantNamelabel.text = companyName;
    CGFloat heightPer = 20.0 / tableViewCellHeight;
    _compantNamelabel.frame = [self calculateFrameWidthPercent:1 itemHeightPercent:heightPer itemxPercent:0 itemYPercent:0.8];
}


+ (instancetype) cellWithIdentifier:(NSString *)identifier tableView:(UITableView *) tableView{
    
    YHHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.jobNamelabel];
        [self.contentView addSubview:self.compantNamelabel];
    }
    return self;
}




@end
