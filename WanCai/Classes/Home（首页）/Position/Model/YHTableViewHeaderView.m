//
//  YHTableViewHeaderView.m
//  WanCai
//
//  Created by abing on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTableViewHeaderView.h"
#import "YHSearchTextField.h"

@interface YHTableViewHeaderView ()<UITextFieldDelegate>

@property (nonatomic, strong) YHSearchTextField *searchField;


@end

@implementation YHTableViewHeaderView

- (YHSearchTextField *) searchField{
    if (!_searchField) {
        _searchField = [[YHSearchTextField alloc] init];
        _searchField.placeholder = @"输入要查询的城市/地区";
        CGFloat widthPer = 0.9;
        CGFloat height = 30;
        CGFloat width = [UIScreen mainScreen].bounds.size.width * widthPer;
        CGFloat itemX = ([UIScreen mainScreen].bounds.size.width - width) / 2.0;
        _searchField.frame = CGRectMake(itemX, (40 - height) / 2.0, width, height);
        _searchField.layer.cornerRadius = height / 2.0;
        _searchField.layer.masksToBounds = YES;
        _searchField.delegate = self;
        _searchField.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"分类_搜索.png"]];
        _searchField.leftViewMode = UITextFieldViewModeAlways;
        _searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _searchField.returnKeyType = UIReturnKeySearch;
        _searchField.font = [UIFont systemFontOfSize:15];
        [_searchField setBackgroundColor:[UIColor colorWithRed:235 / 255.0 green:236 / 255.0 blue:237 / 255.0 alpha:1]];
    }
    return _searchField;
}

- (UILabel *)textLabel{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        CGFloat widthPer = 0.9;
        CGFloat height = 25;
        CGFloat width = [UIScreen mainScreen].bounds.size.width * widthPer;
        CGFloat itemX = ([UIScreen mainScreen].bounds.size.width - width) / 2.0;
        _textLabel.frame = CGRectMake(itemX, 80 - height - 5, width, height);
        _textLabel.font = [UIFont systemFontOfSize:15];
        NSString *location = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentLocation"];
        if (location == nil || location.length == 0){
            _textLabel.text = @"当前城市:请选择";
        }else{
            _textLabel.text = [NSString stringWithFormat:@"当前城市:%@", location];
        }
        
    }
    return _textLabel;
}

- (instancetype) init{
    if(self = [super init]){
        [self setBackgroundColor:[UIColor whiteColor]];
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 80);
        [self addSubview:self.searchField];
        [self addSubview:self.textLabel];
    }
    return self;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    //textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = @"";
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    //textField.leftViewMode = UITextFieldViewModeNever;
    textField.placeholder = @"请输入要查询的城市";
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if(textField.text.length != 0){
        [self.delgate didClickSearchButton:textField];
    }
    return YES;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 0.1);
    
    CGContextMoveToPoint(context, 0, self.frame.size.height / 2.0);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height / 2.0);
    
    CGContextMoveToPoint(context, 0, self.frame.size.height - 0.2);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height - 0.2);

    
    [[UIColor blackColor] setStroke];
    CGContextStrokePath(context);
}


@end
