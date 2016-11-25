//
//  YHCompanyTableViewHeaderCell.m
//  WanCai
//
//  Created by abing on 16/7/18.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyTableViewHeaderCell.h"
#import "YHCompanyInfo.h"

#define tableViewCellHeight 100;

@interface YHCompanyTableViewHeaderCell ()

@property (nonatomic, strong) UIImageView *iconView;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *industoryLabel;

@property (nonatomic, strong) UIImageView *locationView;

@property (nonatomic, strong) UILabel *locationLabel;

@property (nonatomic, strong) UIImageView *sizeView;

@property (nonatomic, strong) UILabel *sizeLabel;

@end

@implementation YHCompanyTableViewHeaderCell

- (CGRect) calculateFrameWidthPercent: (CGFloat) itemWidthPer
                    itemHeightPercent: (CGFloat) itemHeightPer
                         itemxPercent: (CGFloat) itemXPer
                         itemYPercent: (CGFloat) itemYPer{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = tableViewCellHeight;
    
    CGFloat itemWidth = width * itemWidthPer;
    CGFloat itemHeight = height * itemHeightPer;
    CGFloat itemX = width * itemXPer;
    CGFloat itemY = itemYPer * (height - itemHeight);
    
    return CGRectMake(itemX, itemY, itemWidth, itemHeight);
}

- (CGSize) calculateStringSize:(CGSize )size
                       withStr:(NSString *) msg
                      withFont:(UIFont *)font{
    return [msg boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font, NSForegroundColorAttributeName:[UIColor blackColor]} context:nil].size;
}

- (void) setIconName:(NSString *)iconName{
    _iconName = iconName;
    
    [self.iconView setImage:[UIImage imageNamed:_iconName]];
    CGFloat widthAndHeight = 80;
    CGFloat itemWidth = widthAndHeight / [UIScreen mainScreen].bounds.size.width;
    CGFloat height = tableViewCellHeight;
    CGFloat itemHeight = widthAndHeight / height;
    self.iconView.frame = [self calculateFrameWidthPercent:itemWidth itemHeightPercent:itemHeight itemxPercent:0.04 itemYPercent:0.5];
}

- (void) setComInfo:(YHCompanyInfo *)comInfo{
    _comInfo = comInfo;
    
    CGFloat marginX = 10;
    CGFloat marginY = 2;
    
    self.typeLabel.text = _comInfo.CompanyName;
    CGSize size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 40) withStr:_comInfo.CompanyName withFont:[UIFont systemFontOfSize:15]];
    CGFloat temp = size.height;
    CGFloat x = CGRectGetMaxX(self.iconView.frame) + marginX;
    CGFloat y = self.iconView.frame.origin.y + marginY;
    CGFloat maxLabelWidth = YHScreenWidth - self.iconView.width - 4 * marginX;
    self.typeLabel.frame = CGRectMake(x, y, maxLabelWidth, size.height);
    self.typeLabel.adjustsFontSizeToFitWidth = YES;
    
    NSString *indStr = [NSString stringWithFormat:@"%@ | %@",_comInfo.CompanyNatureName,_comInfo.CompanyIndustryName];
    self.industoryLabel.text = indStr;
    x = self.typeLabel.frame.origin.x;
    CGFloat maxFloat = YHScreenWidth - x;
    size = [self calculateStringSize:CGSizeMake(maxFloat, 40) withStr:indStr withFont:[UIFont systemFontOfSize:12]];
    CGFloat offset = (self.iconView.frame.size.height - (marginY * 2) - 17.9 - size.height - temp) / 2.0;
    y = CGRectGetMaxY(self.typeLabel.frame) + offset;
    self.industoryLabel.frame = CGRectMake(x, y, size.width , size.height);
    self.industoryLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.locationView setImage:[UIImage imageNamed:@"JobPalce.png"]];
    x = self.industoryLabel.frame.origin.x;
    y = CGRectGetMaxY(self.industoryLabel.frame) + offset;
    self.locationView.frame = CGRectMake(x, y, 17.9, 17.9);
    
    self.locationLabel.text = _comInfo.CurrentCityName;
    size = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:_comInfo.CurrentCityName withFont:[UIFont systemFontOfSize:12]];
    x = CGRectGetMaxX(self.locationView.frame) + marginY;
    y = self.locationView.frame.origin.y;
    self.locationLabel.frame = CGRectMake(x, y, size.width, size.height);
    self.locationLabel.adjustsFontSizeToFitWidth = YES;
    
    [self.sizeView setImage:[UIImage imageNamed:@"zhaopinrenshu.png"]];
    x = CGRectGetMaxX(self.locationLabel.frame) + marginX;
    y = self.locationLabel.frame.origin.y;
    self.sizeView.frame = CGRectMake(x, y, 17.9, 17.9);
    
    self.sizeLabel.text = _comInfo.CompanySizeName;
    size  = [self calculateStringSize:CGSizeMake(MAXFLOAT, 20) withStr:_comInfo.CompanySizeName withFont:[UIFont systemFontOfSize:12]];
    x = CGRectGetMaxX(self.sizeView.frame) + marginY;
    y = self.sizeView.frame.origin.y;
    self.sizeLabel.frame = CGRectMake(x, y, size.width, size.height);
    self.sizeLabel.adjustsFontSizeToFitWidth = YES;
}

- (UILabel *) sizeLabel{
    if(!_sizeLabel){
        _sizeLabel = [[UILabel alloc] init];
        _sizeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _sizeLabel;
}

- (UILabel *) locationLabel{
    if(!_locationLabel){
        _locationLabel = [[UILabel alloc] init];
        _locationLabel.font = [UIFont systemFontOfSize:15];
    }
    return _locationLabel;
}

- (UILabel *) industoryLabel{
    if(!_industoryLabel){
        _industoryLabel = [[UILabel alloc] init];
        _industoryLabel.font = [UIFont systemFontOfSize:13];
        [_industoryLabel setTextColor:[UIColor grayColor]];
        _industoryLabel.numberOfLines = 0;
    }
    return _industoryLabel;
}

- (UILabel *) typeLabel{
    if(!_typeLabel){
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:15];
    }
    return _typeLabel;
}

- (UIImageView *)iconView{
    if(!_iconView){
        _iconView = [[UIImageView alloc] init];
    }
    return _iconView;
}

- (UIImageView *) sizeView{
    if(!_sizeView){
        _sizeView = [[UIImageView alloc] init];
    }
    return _sizeView;
}

-(UIImageView *)locationView{
    if(!_locationView){
        _locationView = [[UIImageView alloc] init];
    }
    return _locationView;
}


+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier{
    YHCompanyTableViewHeaderCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return  cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.typeLabel];
        [self.contentView addSubview:self.industoryLabel];
        [self.contentView addSubview:self.locationView];
        [self.contentView addSubview:self.locationLabel];
        [self.contentView addSubview:self.sizeView];
        [self.contentView addSubview:self.sizeLabel];
    }
    return self;
}

@end
