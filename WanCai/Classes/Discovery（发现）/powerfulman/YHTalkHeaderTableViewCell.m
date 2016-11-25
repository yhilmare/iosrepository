//
//  YHTalkHeaderTableViewCell.m
//  WanCai
//
//  Created by abing on 16/9/15.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHTalkHeaderTableViewCell.h"
#import "YHHomeButton.h"

@interface YHTalkHeaderTableViewCell ()

@property (nonatomic, strong) NSMutableArray *buttonArray;

@end

@implementation YHTalkHeaderTableViewCell

- (NSMutableArray *) buttonArray{
    if(!_buttonArray){
        _buttonArray = [NSMutableArray array];
        for(NSDictionary *dic in self.array){
            NSString *iconName = dic[@"iconName"];
            NSString *titleName = dic[@"titleName"];
            YHHomeButton *button = [[YHHomeButton alloc] init];
            [button.imageView setImage:[UIImage imageNamed:iconName]];
            [button setTitle:titleName forState:UIControlStateNormal];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [_buttonArray addObject:button];
        }
    }
    return _buttonArray;
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGFloat rowHeight = self.contentView.frame.size.height;
    CGFloat heightAndWidth = rowHeight * 0.6;
    CGFloat offset = 15;
    CGFloat margin = ([UIScreen mainScreen].bounds.size.width - offset * 2 - self.buttonArray.count * heightAndWidth) / (self.buttonArray.count - 1);
    CGFloat x = offset;
    CGFloat y = (rowHeight - heightAndWidth) / 2.0;
    for(YHHomeButton *button in self.buttonArray){
        button.frame = CGRectMake(x, y, heightAndWidth, heightAndWidth);
        x = CGRectGetMaxX(button.frame) + margin;
    }
}

+ (instancetype) cellFromTableView:(UITableView *) tableView withReuseIdentifier:(NSString *) identifier andArray:(NSArray *) tempArray{
    YHTalkHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier andArray:tempArray];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andArray:(NSArray *) tempArray{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.array = tempArray;
        for(YHHomeButton *button in self.buttonArray){
            [self.contentView addSubview:button];
        }
    }
    return self;
}

@end
