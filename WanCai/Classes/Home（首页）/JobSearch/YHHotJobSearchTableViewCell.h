//
//  YHHotJobSearchTableViewCell.h
//  WanCai
//
//  Created by CheungKnives on 16/7/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^BYDBlock)(void);
typedef void(^Myblock) (NSInteger index);
@interface YHHotJobSearchTableViewCell : UITableViewCell

- (void)infortdataArr:(NSMutableArray *)arr;
@property (nonatomic,strong) Myblock block;
@property (nonatomic,strong) BYDBlock DBlock;
@end
