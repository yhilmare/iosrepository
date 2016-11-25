//
//  UIImage+YHResize.m
//  WanCai
//
//  Created by CheungKnives on 16/7/17.
//  Copyright © 2016年 SYYH. All rights reserved.
//

#import "UIImage+YHResize.h"

@implementation UIImage (YHResize)

- (UIImage *)croppedImage:(CGRect)bounds {
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

- (UIImage*)cutImageWithRadius:(int)radius {
    UIGraphicsBeginImageContext(self.size);
    CGContextRef gc = UIGraphicsGetCurrentContext();
    
    float x1 = 0.;
    float y1 = 0.;
    float x2 = x1+self.size.width;
    float y2 = y1;
    float x3 = x2;
    float y3 = y1+self.size.height;
    float x4 = x1;
    float y4 = y3;
    radius = radius*2;
    
    CGContextMoveToPoint(gc, x1, y1+radius);
    CGContextAddArcToPoint(gc, x1, y1, x1+radius, y1, radius);
    CGContextAddArcToPoint(gc, x2, y2, x2, y2+radius, radius);
    CGContextAddArcToPoint(gc, x3, y3, x3-radius, y3, radius);
    CGContextAddArcToPoint(gc, x4, y4, x4, y4-radius, radius);
    
    
    CGContextClosePath(gc);
    CGContextClip(gc);
    
    CGContextTranslateCTM(gc, 0, self.size.height);
    CGContextScaleCTM(gc, 1, -1);
    CGContextDrawImage(gc, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
    
    UIImage *newimage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newimage;
}

//将图片裁剪成正方形
- (UIImage *)squareImage {
    UIImage *image = nil;
    UIGraphicsBeginImageContext(self.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat offset = (self.size.width - self.size.height) / 2;
    CGFloat radius = offset > 0 ? self.size.height : self.size.width;
    if (offset > 0) {  //图片的宽比高度大，则将图片的宽度裁剪
        CGContextMoveToPoint(context, offset, 0);
        CGContextAddRect(context, CGRectMake(offset, 0, self.size.height, self.size.height));
    } else {
        CGContextMoveToPoint(context, 0, -offset);
        CGContextAddRect(context, CGRectMake(0, -offset, self.size.width, self.size.width));
    }
    
    CGContextClosePath(context);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, CGRectMake(0, 0, radius, radius), self.CGImage);
    
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
