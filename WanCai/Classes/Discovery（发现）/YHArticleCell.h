//
//  YHArticleCell.h
//  WanCai
//
//  Created by CheungKnives on 16/7/21.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YHArticleList;

@interface YHArticleCell : UITableViewCell

@property (nonatomic, strong) UIImageView *parallaxImage;

@property (nonatomic, strong) UILabel *zLabel;

@property (nonatomic, strong) UIView *dimView;

@property (nonatomic, strong) UILabel *articleTitleLabel;


@property (nonatomic, assign) CGFloat parallaxRatio; //ratio of cell height, should between [1.0f, 2.0f], default is 1.5f;

@property (nonatomic, strong) YHArticleList *article;

@property (nonatomic, strong) NSURL *postUrl;

@property (nonatomic, strong) NSString *imageURL;

- (void)setLabel1:(NSString *)text1;

- (void)setArticle:(YHArticleList *)article;

@end
