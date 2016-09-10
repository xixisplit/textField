//
//  UIImage+Scale.m
//  TransfarFinancialPayment
//
//  Created by 陈曦 on 16/8/8.
//  Copyright © 2016年 Transfar. All rights reserved.
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

//-(void)TransformtoSize:(CGSize)newsize;
////    // 创建一个bitmap的context
////    // 并把它设置成为当前正在使用的context
//    UIGraphicsBeginImageContext(newsize);
//
//
////    // 绘制改变大小的图片
////    [self drawInRect:CGRectMake(0, 0, newsize.width, newsize.height)];
////    // 从当前context中创建一个改变大小后的图片
////    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
////    // 使当前的context出堆栈
////    UIGraphicsEndImageContext();
////    // 返回新的改变大小后的图片
////    return scaledImage;
//}
+ (UIImage *)imageTransImage:(UIImage *)image formtoSize:(CGSize)newSize
{

    ////    // 创建一个bitmap的context
    ////    // 并把它设置成为当前正在使用的context
    //        UIGraphicsBeginImageContext(newSize);
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 2.0);
    //
    //
    ////    // 绘制改变大小的图片
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    ////    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    ////    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    ////    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0, 0, 1, 1);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return img;
}

+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
