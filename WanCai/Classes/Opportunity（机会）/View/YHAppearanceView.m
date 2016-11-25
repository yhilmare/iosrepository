//
//  YHAppearanceView.m
//  WanCai
//
//  Created by yh_swjtu on 16/7/31.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHAppearanceView.h"
#import "YHAppearanceCellTableViewCell.h"

@interface YHAppearanceView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation YHAppearanceView

- (UITableView *) tableView{
    if(!_tableView){
        CGFloat width = 120;
        CGFloat height = 44 * 2 - 1;
        CGFloat offsetL = 5;
        CGFloat x = YHScreenWidth - offsetL - width;
        CGFloat y = 18;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(x, y, width, height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
        _tableView.layer.cornerRadius = 5;
        _tableView.layer.masksToBounds = YES;
    }
    return _tableView;
}
- (instancetype)init{
    if(self = [super init]){
        [self addSubview:self.tableView];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    
    CGFloat width = 150;
    CGFloat offsetL = 5;
    CGFloat x = [UIScreen mainScreen].bounds.size.width - offsetL - width + 110;
    CGFloat y = 18;
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextMoveToPoint(context, x, y);
    
    CGContextAddLineToPoint(context, x + 13, 5);
    
    CGContextAddLineToPoint(context, x + 26, y);
    
    CGContextAddLineToPoint(context, x, y);
    
    [[UIColor whiteColor] setFill];
    
    //CGContextStrokePath(context);
    CGContextFillPath(context);
    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
    [UIView animateWithDuration:0.5 animations:^{
        self.transform = CGAffineTransformMakeScale(0.01, 0.01);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        self.transform = CGAffineTransformMakeScale(1, 1);
    }];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    YHAppearanceCellTableViewCell *cell = [YHAppearanceCellTableViewCell cellFromTableview:tableView withIdentifier:@"opp_list_identifier"];
    if(indexPath.row == 0){
        cell.name = @"回收站";
        cell.iconName = @"opp_nope";
    }else{
        cell.name = @"收藏";
        cell.iconName = @"opp_liked";
    }
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if([self.delgate respondsToSelector:@selector(didClickTableViewAtIndexPath:)]){
        [self.delgate didClickTableViewAtIndexPath:indexPath];
    }
}

@end
