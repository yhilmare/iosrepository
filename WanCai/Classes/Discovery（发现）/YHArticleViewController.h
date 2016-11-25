//
//  YHArticleViewController.h
//  WanCai
//
//  Created by abing on 16/9/14.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>　

@protocol YHYHArticleViewControllerDelgate <NSObject>

- (void) didselectURL:(NSURL *)url andImageURL:(NSString *)imgurl;

@end

@interface YHArticleViewController : UIViewController

@property (nonatomic, assign) id<YHYHArticleViewControllerDelgate> delgate;

@end
