//
//  YHTableViewCell.m
//  WanCai
//
//  Created by abing on 16/7/11.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTableViewCell.h"
#import "YHButtonModelFrame.h"
#import "YHButtonModel.h"

@interface YHTableViewCell ()

@property (nonatomic, strong) UIButton *hotCity1;
@property (nonatomic, strong) UIButton *hotCity2;
@property (nonatomic, strong) UIButton *hotCity3;
@property (nonatomic, strong) UIButton *hotCity4;
@property (nonatomic, strong) UIButton *hotCity5;
@property (nonatomic, strong) UIButton *hotCity6;
@property (nonatomic, strong) UIButton *hotCity7;
@property (nonatomic, strong) UIButton *hotCity8;
@property (nonatomic, strong) UIButton *hotCity9;

@end


@implementation YHTableViewCell



- (void) setModelFrame:(YHButtonModelFrame *)modelFrame{
    _modelFrame = modelFrame;
    
    [self setFrames:modelFrame];
    [self setButtonValue:modelFrame];
    
}

- (void) setFrames:(YHButtonModelFrame *)modelFrame{
    
    _hotCity1.frame = modelFrame.hotcity1;
    _hotCity2.frame = modelFrame.hotcity2;
    _hotCity3.frame = modelFrame.hotcity3;
    _hotCity4.frame = modelFrame.hotcity4;
    _hotCity5.frame = modelFrame.hotcity5;
    _hotCity6.frame = modelFrame.hotcity6;
    _hotCity7.frame = modelFrame.hotcity7;
    _hotCity8.frame = modelFrame.hotcity8;
    _hotCity9.frame = modelFrame.hotcity9;
}

- (void) setButtonValue:(YHButtonModelFrame *)modelFrame{
    
    YHButtonModel *model = modelFrame.model;
    [_hotCity1 setTitle:model.hotcity1 forState:UIControlStateNormal];
    
    [_hotCity2 setTitle:model.hotcity2 forState:UIControlStateNormal];

    [_hotCity3 setTitle:model.hotcity3 forState:UIControlStateNormal];

    [_hotCity4 setTitle:model.hotcity4 forState:UIControlStateNormal];

    [_hotCity5 setTitle:model.hotcity5 forState:UIControlStateNormal];

    [_hotCity6 setTitle:model.hotcity6 forState:UIControlStateNormal];

    [_hotCity7 setTitle:model.hotcity7 forState:UIControlStateNormal];

    [_hotCity8 setTitle:model.hotcity8 forState:UIControlStateNormal];
    [_hotCity9 setTitle:model.hotcity9 forState:UIControlStateNormal];
}

- (UIButton *) hotCity1{
    if(!_hotCity1){
        _hotCity1 = [[UIButton alloc] init];
        _hotCity1.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity1.layer.cornerRadius = 2;
        _hotCity1.layer.masksToBounds = YES;
        _hotCity1.layer.borderWidth = 1;
        _hotCity1.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity1 setBackgroundColor:[UIColor whiteColor]];
        [_hotCity1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity1 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity1 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _hotCity1;
}

- (UIButton *) hotCity2{
    if(!_hotCity2){
        _hotCity2 = [[UIButton alloc] init];
        _hotCity2.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity2.layer.cornerRadius = 2;
        _hotCity2.layer.masksToBounds = YES;
        _hotCity2.layer.borderWidth = 1;
        _hotCity2.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity2 setBackgroundColor:[UIColor whiteColor]];
        [_hotCity2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity2 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity2 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _hotCity2;
}

- (UIButton *) hotCity3{
    if(!_hotCity3){
        _hotCity3 = [[UIButton alloc] init];
        _hotCity3.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity3.layer.cornerRadius = 2;
        _hotCity3.layer.masksToBounds = YES;
        _hotCity3.layer.borderWidth = 1;
        _hotCity3.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity3 setBackgroundColor:[UIColor whiteColor]];
        [_hotCity3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity3 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity3 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _hotCity3;
}

- (UIButton *) hotCity4{
    if(!_hotCity4){
        _hotCity4 = [[UIButton alloc] init];
        _hotCity4.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity4.layer.cornerRadius = 2;
        _hotCity4.layer.masksToBounds = YES;
        _hotCity4.layer.borderWidth = 1;
        _hotCity4.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity4 setBackgroundColor:[UIColor whiteColor]];
        [_hotCity4 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity4 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity4 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _hotCity4;
}


- (UIButton *) hotCity5{
    if(!_hotCity5){
        _hotCity5 = [[UIButton alloc] init];
        _hotCity5.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity5.layer.cornerRadius = 2;
        _hotCity5.layer.masksToBounds = YES;
        _hotCity5.layer.borderWidth = 1;
        _hotCity5.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity5 setBackgroundColor:[UIColor whiteColor]];
        [_hotCity5 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity5 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity5 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _hotCity5;
}

- (UIButton *) hotCity6{
    if(!_hotCity6){
        _hotCity6 = [[UIButton alloc] init];
        _hotCity6.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity6.layer.cornerRadius = 2;
        _hotCity6.layer.masksToBounds = YES;
        _hotCity6.layer.borderWidth = 1;
        [_hotCity6 setBackgroundColor:[UIColor whiteColor]];
        _hotCity6.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity6 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity6 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity6 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _hotCity6;
}

- (UIButton *) hotCity7{
    if(!_hotCity7){
        _hotCity7 = [[UIButton alloc] init];
        _hotCity7.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity7.layer.cornerRadius = 2;
        _hotCity7.layer.masksToBounds = YES;
        _hotCity7.layer.borderWidth = 1;
        _hotCity7.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity7 setBackgroundColor:[UIColor whiteColor]];

        [_hotCity7 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity7 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity7 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _hotCity7;
}

- (UIButton *) hotCity8{
    if(!_hotCity8){
        _hotCity8 = [[UIButton alloc] init];
        _hotCity8.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity8.layer.cornerRadius = 2;
        _hotCity8.layer.masksToBounds = YES;
        _hotCity8.layer.borderWidth = 1;
        _hotCity8.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity8 setBackgroundColor:[UIColor whiteColor]];
        [_hotCity8 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity8 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity8 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _hotCity8;
}

- (UIButton *) hotCity9{
    if(!_hotCity9){
        _hotCity9 = [[UIButton alloc] init];
        _hotCity9.titleLabel.font = [UIFont systemFontOfSize:14];
        _hotCity9.layer.cornerRadius = 2;
        _hotCity9.layer.masksToBounds = YES;
        _hotCity9.layer.borderWidth = 1;
        _hotCity9.layer.borderColor = [[UIColor colorWithRed:234/255.0 green:234/255.0 blue:234/255.0 alpha:1] CGColor];
        [_hotCity9 setBackgroundColor:[UIColor whiteColor]];
        [_hotCity9 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_hotCity9 setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
        [_hotCity9 addTarget:self action:@selector(func:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _hotCity9;
}



+ (instancetype) getTableViewCellWithIdentifier:(NSString *) identifier
                                      tableView: (UITableView *) tableView
                                      inSection: (NSIndexPath *) index{
    YHTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier inSection:index];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier inSection:(NSIndexPath *)index{
    
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self.contentView setBackgroundColor:[UIColor colorWithRed:247 / 255.0 green:247 / 255.0 blue:247 / 255.0 alpha:1]];
        [self.contentView addSubview:self.hotCity1];
        [self.contentView addSubview:self.hotCity2];
        [self.contentView addSubview:self.hotCity3];
        [self.contentView addSubview:self.hotCity4];
        [self.contentView addSubview:self.hotCity5];
        [self.contentView addSubview:self.hotCity6];
        [self.contentView addSubview:self.hotCity7];
        [self.contentView addSubview:self.hotCity8];
        [self.contentView addSubview:self.hotCity9];
    }
    return self;
}


- (void) func:(UIButton *)button{
    [self.delgate didClickButton:button];
}


@end
