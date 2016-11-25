//
//  YHBasicSettingCell.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHBasicSettingCell.h"
#import "YHBadgeItem.h"
#import "YHBadgeView.h"
#import "YHSwitchItem.h"
#import "YHArrowItem.h"
#import "YHCheckItem.h"
#import "YHGroupItem.h"
#import "YHLabelItem.h"


@interface YHBasicSettingCell()

@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UISwitch *switchView;
@property (nonatomic, strong) UIImageView *checkView;
@property (nonatomic, strong) YHBadgeView *badgeView;
@property (nonatomic, weak) UILabel *labelView;

@end

@implementation YHBasicSettingCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *ID = @"cell";
    
    YHBasicSettingCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
        // 设置背景view
        self.backgroundView = [[UIImageView alloc] init];
        self.selectedBackgroundView = [[UIImageView alloc] init];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UILabel *)labelView {
    if (_labelView == nil) {
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        _labelView = label;
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
        [self addSubview:_labelView];
    }
    return _labelView;
}
- (YHBadgeView *)badgeView {
    if (_badgeView == nil) {
        _badgeView = [[YHBadgeView alloc] init];
    }
    return _badgeView;
}

- (UIImageView *)arrowView {
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (UISwitch *)switchView {
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
        [_switchView addTarget:self action:@selector(switchChange:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _switchView;
}

- (UIImageView *)cheakView {
    if (_checkView == nil) {
        _checkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"chat_group_selected"]];
    }
    return _checkView;
}

- (void)setItem:(YHSettingItem *)item {
    _item = item;
    
    // 设置数据
    [self setUpData];
    // 设置模型
    [self setUpRightView];
}

- (void)setUpData {//设置数据
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.subTitle;
    self.imageView.image = _item.image;
}

- (void)setUpRightView {//设置模型
    if ([_item isKindOfClass:[YHArrowItem class]]) { // 箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[YHSwitchItem class]]){ // 开关
        self.accessoryView = self.switchView;
        YHSwitchItem *switchItem = (YHSwitchItem *)_item;
        self.switchView.on = switchItem.on;
        
    }else if ([_item isKindOfClass:[YHCheckItem class]]){ // 打钩
        YHCheckItem *checkItem = (YHCheckItem *)_item;
        if (checkItem.check) {
            self.accessoryView = self.cheakView;
        }else{
            self.accessoryView = nil;
        }
    }else if ([_item isKindOfClass:[YHBadgeItem class]]){
        YHBadgeItem *badgeItem = (YHBadgeItem *)_item;
        YHBadgeView *badge = self.badgeView;
        self.accessoryView = badge;
        badge.badgeValue = badgeItem.badgeValue;
    }else if ([_item isKindOfClass:[YHLabelItem class]]){
        YHLabelItem *labelItem = (YHLabelItem *)_item;
        UILabel *label = self.labelView;
        label.text = labelItem.text;
    }else{ // 没有
        self.accessoryView = nil;
        [_labelView removeFromSuperview];
        _labelView = nil;
    }
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath rowCount:(NSInteger)count {
    UIImageView *bgView = (UIImageView *)self.backgroundView;
    UIImageView *selBgView = (UIImageView *)self.selectedBackgroundView;
    if (count == 1) { // 只有一行
        bgView.image = [UIImage imageWithStretchableName:@"common_card_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_background_highlighted"];
        
    }else if(indexPath.row == 0){ // 顶部cell
        bgView.image = [UIImage imageWithStretchableName:@"common_card_top_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_top_background_highlighted"];
        
    }else if (indexPath.row == count - 1){ // 底部
        bgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_bottom_background_highlighted"];
        
    }else{ // 中间
        bgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background"];
        selBgView.image = [UIImage imageWithStretchableName:@"common_card_middle_background_highlighted"];
    }
    
}

- (void)switchChange:(UISwitch *)switchView {
    
    YHSwitchItem *switchItem = (YHSwitchItem *)_item;
    switchItem.on = switchView.on;
    
}


@end
