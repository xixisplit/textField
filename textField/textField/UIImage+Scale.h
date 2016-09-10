//
//  UIImage+Scale.h
//  TransfarFinancialPayment
//
//  Created by 陈曦 on 16/8/8.
//  Copyright © 2016年 Transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
/**
 *  根据传入的 image 和大小返回对应大小的图片
 *
 *  @param image   图片
 *  @param newSize 大小
 *
 *  @return <#return value description#>
 */
+ (UIImage *)imageTransImage:(UIImage *)image formtoSize:(CGSize)newSize;

/**
 *  根据颜色返回1*1的 image 图片 用于设置 button setBackgroundImage: 的样式的背景图片
 *
 *  @param color 颜色
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  根据颜色和size返回对应大小的图片
 *
 *  @param color  颜色
 *  @param size  大小
 */
+ (UIImage *)imageWithColor:(UIColor *)color withSize:(CGSize)size;

@end
