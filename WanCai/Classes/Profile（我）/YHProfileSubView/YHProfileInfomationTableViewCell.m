//
//  YHProfileInfomationTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/9.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileInfomationTableViewCell.h"

@interface YHProfileInfomationTableViewCell ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *nameLabel;



@end

@implementation YHProfileInfomationTableViewCell

- (CGRect) calculateFrameWidthPercent: (CGFloat) itemWidthPer
                    itemHeightPercent: (CGFloat) itemHeightPer
                         itemxPercent: (CGFloat) itemXPer
                         itemYPercent: (CGFloat) itemYPer{
    CGFloat width = self.contentView.frame.size.width;
    CGFloat height = self.contentView.frame.size.height;
    
    CGFloat itemWidth = width * itemWidthPer;
    CGFloat itemHeight = height * itemHeightPer;
    CGFloat itemX = itemXPer * width;
    CGFloat itemY = (height - itemHeight) * itemYPer;
    
    return CGRectMake(itemX, itemY, itemWidth, itemHeight);
}

- (void) setIconName:(NSString *)iconName{
    _iconName = iconName;
    
    [self.iconView setImage:[UIImage imageNamed:_iconName]];
    CGFloat x = 10;
    CGFloat rowHeight = 44;
    CGFloat heightAndWidth = 20;
    CGFloat y = (rowHeight - heightAndWidth) / 2.0;
    self.iconView.frame = CGRectMake(x, y, heightAndWidth, heightAndWidth);
}

- (void) setLabelMsg:(NSString *)labelMsg{
    _labelMsg = labelMsg;
    
    self.nameLabel.text = _labelMsg;
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + 7;
    CGFloat rowHeight = 44;
    CGFloat width = [@"受教育程度" boundingRectWithSize:CGSizeMake(MAXFLOAT, 44) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17]} context:nil].size.width;
    CGFloat height = 44;
    CGFloat y = (rowHeight - height) / 2.0;
    self.nameLabel.frame = CGRectMake(x, y, width, height);
    
    x = CGRectGetMaxX(self.nameLabel.frame) + 5;
    CGFloat offset = 15;
    width = [UIScreen mainScreen].bounds.size.width - x - offset;
    height = 44;
    y = (rowHeight - height) / 2.0;
    self.detailInfo.frame = CGRectMake(x, y, width, height);
}

- (UITextField *) detailInfo{
    if(!_detailInfo){
        _detailInfo = [[UITextField alloc] init];
        _detailInfo.placeholder = @"请填写";
        _detailInfo.textAlignment = NSTextAlignmentRight;
    }
    return _detailInfo;
}

- (UILabel *)nameLabel{
    if(!_nameLabel){
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont systemFontOfSize:17];
        _nameLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _nameLabel;
}

- (UIImageView *) iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

+ (instancetype) getTableViewCell:(UITableView *)tableView
                 reusableIdentifier:(NSString *) identifier
                     arrayPointer:(NSMutableArray *) array{
    YHProfileInfomationTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
        [array addObject:cell];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.detailInfo];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview: self.nameLabel];
    }
    return self;
}
@end
