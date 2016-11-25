//
//  UIImage+YHResize.h
//  WanCai
//
//  Created by CheungKnives on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (YHResize)

- (UIImage *)croppedImage:(CGRect)bounds;
- (UIImage*)cutImageWithRadius:(int)radius;
- (UIImage *)squareImage;

@end
