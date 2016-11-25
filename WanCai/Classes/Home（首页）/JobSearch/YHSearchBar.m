//
//  YHSearchBar.m
//  WanCai
//
//  Created by CheungKnives on 16/7/9.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSearchBar.h"

@implementation YHSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.placeholder =  @"可搜索职位/公司名称/职位";
        self.font = [UIFont systemFontOfSize:13];
        self.background =[UIImage imageWithStretchableName:@"searchbar_textfield_background"];
        
        UIImageView *leftV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 32)];
        leftV.contentMode = UIViewContentModeCenter;
        leftV.image = [UIImage imageNamed:@"searchbar_textfield_search_icon"];
        self.leftView = leftV;
        
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
