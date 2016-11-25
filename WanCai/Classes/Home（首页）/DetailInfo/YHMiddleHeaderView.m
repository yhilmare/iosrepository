//
//  YHMiddleHeaderView.m
//  WanCai
//
//  Created by abing on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHMiddleHeaderView.h"

@interface YHMiddleHeaderView ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *infoLabel;


@end

@implementation YHMiddleHeaderView

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
        _iconView.frame = CGRectMake(0, 0, 20, 20);
        //[_iconView setBackgroundColor:[UIColor greenColor]];
    }
    return _iconView;
}

- (void) setIconName:(NSString *)iconName{
    _iconName = iconName;
    [_iconView setImage:[UIImage imageNamed:iconName]];
}

- (void)setLabelName:(NSString *)labelName{
    _labelName = labelName;
    [_infoLabel setText:labelName];
}

- (UILabel *) infoLabel{
    if(!_infoLabel){
        _infoLabel = [[UILabel alloc] init];
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _infoLabel.frame = CGRectMake(23, 0, 0.32 * width - 20 - 3, 20);
        _infoLabel.font = [UIFont systemFontOfSize:12];
        //[_infoLabel setBackgroundColor:[UIColor grayColor]];
    }
    return  _infoLabel;
}

- (instancetype) init{
    if(self = [super init]){
        [self addSubview:self.iconView];
        [self addSubview:self.infoLabel];
    }
    return self;
}

@end
