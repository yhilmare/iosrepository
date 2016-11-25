//
//  YHProfileResumeEditCatTableViewCell.m
//  WanCai
//
//  Created by 段昊宇 on 16/7/31.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHProfileResumeEditCatTableViewCell.h"

@interface YHProfileResumeEditCatTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *img_1;
@property (weak, nonatomic) IBOutlet UIImageView *img_2;
@property (weak, nonatomic) IBOutlet UIImageView *img_3;
@property (weak, nonatomic) IBOutlet UIImageView *img_4;

@property (weak, nonatomic) IBOutlet UILabel *lab_1;
@property (weak, nonatomic) IBOutlet UILabel *lab_2;
@property (weak, nonatomic) IBOutlet UILabel *lab_3;
@property (weak, nonatomic) IBOutlet UILabel *lab_4;

@end


@implementation YHProfileResumeEditCatTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
