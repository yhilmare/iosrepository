//
//  YHSettingTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/22.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSettingTableViewCell.h"

@interface YHSettingTableViewCell ()

@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation YHSettingTableViewCell

- (void) setName:(NSString *)name{
    _name = name;
    
    [self.nameLabel setText:_name];
    CGSize size = [_name boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19]} context:nil].size;
    CGFloat x = ([UIScreen mainScreen].bounds.size.width - size.width) / 2.0;
    CGFloat y = (44 - size.height) / 2.0;
    self.nameLabel.frame = CGRectMake(x, y, size.width, size.height);
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        [_nameLabel setTextColor:[UIColor colorWithRed:221 / 255.0 green:82 / 255.0 blue:69 / 255.0 alpha:1]];
        _nameLabel.font = [UIFont systemFontOfSize:19];
    }
    return _nameLabel;
}


+ (instancetype) cellFromTableView:(UITableView *) tableView withIdentifier:(NSString *) identifier{
    YHSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(!cell){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}


@end
