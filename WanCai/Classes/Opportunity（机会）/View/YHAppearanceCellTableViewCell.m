//
//  YHAppearanceCellTableViewCell.m
//  WanCai
//
//  Created by yh_swjtu on 16/8/2.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHAppearanceCellTableViewCell.h"

@interface YHAppearanceCellTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation YHAppearanceCellTableViewCell

- (void) setIconName:(NSString *)iconName{
    _iconName = iconName;
    
    [self.iconView setImage:[UIImage imageNamed:_iconName]];
}

- (void) setName:(NSString *)name{
    _name = name;
    
    self.iconView.frame = CGRectMake(10, 10, 24, 24);
    
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + 10;
    
    self.nameLabel.text = _name;
    self.nameLabel.frame = CGRectMake(x, 10, self.contentView.frame.size.width - x, 24);
}

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UILabel *) nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
    }
    return _nameLabel;
}


+ (instancetype) cellFromTableview:(UITableView *) tabelview withIdentifier:(NSString *) identifier{
    
    YHAppearanceCellTableViewCell *cell = [tabelview dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}



@end
