//
//  YHDiscoveryTableViewCell.m
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHDiscoveryTableViewCell.h"

@implementation YHDiscoveryTableViewCell

- (void) setViewController:(UIViewController *)viewController{
    [viewController.view removeFromSuperview];
    _viewController = viewController;
    _viewController.view.frame = CGRectZero;
    [self.contentView addSubview:self.viewController.view];
    self.viewController.view.transform = CGAffineTransformMakeRotation(M_PI_2);
}

- (void) layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.contentView.size.width;
    CGFloat height = self.contentView.size.height;
    self.viewController.view.frame = CGRectMake(0, 0, width, height);
}

+ (instancetype) cellWithTableView:(UITableView *) tableView withIdentifier:(NSString *) identifier{
    
    YHDiscoveryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if(cell == nil){
        cell = [[self alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}

@end
