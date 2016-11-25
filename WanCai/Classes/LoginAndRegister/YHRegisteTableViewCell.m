//
//  YHRegisteTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHRegisteTableViewCell.h"

#define tableViewCellHeight 54;

@interface YHRegisteTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@end

@implementation YHRegisteTableViewCell

- (void) setIconName:(NSString *)iconName{
    _iconName = iconName;

    CGFloat x = 10;
    CGFloat heightAndWidth = 25;
    CGFloat rowHeight = tableViewCellHeight;
    CGFloat y = (rowHeight - heightAndWidth) / 2.0;
    [self.iconView setImage:[UIImage imageNamed:_iconName]];
    self.iconView.frame = CGRectMake(x, y, heightAndWidth, heightAndWidth);
    
}

- (void) setTextFieldName:(NSString *)textFieldName{
    _textFieldName = textFieldName;
    
    CGFloat offset = 10;
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + 8;
    CGFloat width = [UIScreen mainScreen].bounds.size.width - x - offset;
    CGFloat rowHeight = tableViewCellHeight;
    self.textField.placeholder = _textFieldName;
    self.textField.frame = CGRectMake(x, 0, width, rowHeight);
}

- (UITextField *) textField{
    if(!_textField){
        _textField = [[UITextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier{
    YHRegisteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.textField];
    }
    return self;
}


@end
