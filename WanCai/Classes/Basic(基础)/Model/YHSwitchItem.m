//
//  YHSwitchItem.m
//  WanCai
//
//  Created by CheungKnives on 16/5/19.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "YHSwitchItem.h"

@implementation YHSwitchItem

- (void)setOn:(BOOL)on {
    _on = on;
    
    // 数据存储
    [YHUserDefaults setBool:on forKey:self.title];
    
}

- (void)setTitle:(NSString *)title {
    [super setTitle:title];
    
    self.on = [YHUserDefaults boolForKey:title];
}

@end
