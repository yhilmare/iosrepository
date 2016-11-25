//
//  YHFuncTableViewCell.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHFuncTableViewCell.h"

@interface YHFuncTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView1;

@property (nonatomic, strong) UIImageView *iconView2;

@end

@implementation YHFuncTableViewCell

- (UIImageView *) iconView1{
    if(!_iconView1){
        _iconView1 = [[UIImageView alloc] init];
        _iconView1.layer.borderWidth = 1;
        _iconView1.layer.borderColor = [YHGray CGColor];
    }
    return _iconView1;
}

- (UIImageView *) iconView2{
    if(!_iconView2){
        _iconView2 = [[UIImageView alloc] init];
        _iconView2.layer.borderWidth = 1;
        _iconView2.layer.borderColor = [YHGray CGColor];
    }
    return _iconView2;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.contentView.frame.size.height - 15;
    CGSize size = [UIScreen mainScreen].bounds.size;
    CGFloat rate = size.width / size.height;
    CGFloat width = height * rate;
    CGFloat offset = 20;
    CGFloat x = (size.width - width * 2 - offset) / 2.0;
    self.iconView1.frame = CGRectMake(x, 0, width, height);
    x = CGRectGetMaxX(self.iconView1.frame) + offset;
    self.iconView2.frame = CGRectMake(x, 0, width, height);
}

- (void) setIconName1:(NSString *)iconName1{
    _iconName1 = iconName1;
    [self.iconView1 setImage:[UIImage imageNamed:_iconName1]];
}

- (void) setIconName2:(NSString *)iconName2{
    _iconName2 = iconName2;
    [self.iconView2 setImage:[UIImage imageNamed:_iconName2]];
}

+ (instancetype) cellFromTableView:(UITableView *) tableView withIdentifier:(NSString *) identifier{
    YHFuncTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView1];
        [self.contentView addSubview:self.iconView2];
    }
    return self;
}

@end
