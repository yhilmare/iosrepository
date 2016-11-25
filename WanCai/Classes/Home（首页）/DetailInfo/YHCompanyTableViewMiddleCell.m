//
//  YHCompanyTableViewMiddleCell.m
//  WanCai
//
//  Created by abing on 16/7/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHCompanyTableViewMiddleCell.h"
#import "YHCompanyDesc.h"

@interface YHCompanyTableViewMiddleCell ()

@property (nonatomic, strong) UILabel *descLabel;

@end

@implementation YHCompanyTableViewMiddleCell

- (void) setDesc:(YHCompanyDesc *)desc{
    _desc = desc;
    
    self.descLabel.text = _desc.companyDesc;
    
    self.descLabel.frame = _desc.descFrame;
}

- (UILabel *) descLabel{
    if(!_descLabel){
        _descLabel = [[UILabel alloc] init];
        _descLabel.numberOfLines = 0;
        _descLabel.font = [UIFont systemFontOfSize:15];
        [_descLabel setTextColor:[UIColor grayColor]];
    }
    return _descLabel;
}

+ (instancetype) cellFromTableView:(UITableView *)tableView
                    withIdentifier:(NSString *)identifier{
    YHCompanyTableViewMiddleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return  cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView addSubview:self.descLabel];
    }
    return self;
}




@end
