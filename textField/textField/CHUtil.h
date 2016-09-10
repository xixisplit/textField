//
//  TFUtil.h
//  TFUtil
//
//  Created by kevin on 15/8/20.
//  Copyright (c) 2015年 Transfar. All rights reserved.
//

#define kOperationID @"operationID"

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface CHUtil : NSObject

+ (CHUtil *)sharedInstance;

/**
 * @brief  判断字符串是否是null
 */
+ (BOOL)isNullString:(NSString *)string;

/**
 * @brief   根据传入的字符串和字体大小来返回text的CGSize
 */
+ (CGSize) getTextCGSize:(NSString*)str Font :(UIFont*)font;

/**
 *  @brief  获取MAC地址
 *
 *  @return MAC地址
 */
+ (NSString *) getMacAddress;

/**
 *  @brief  获取ip地址
 *
 *  @return ip地址
 */
+ (NSString *)localIPAddresses;


/**
 * @brief   获取当前系统时间。
 */
+ (NSString *)currentSystemTime;

/**
 * @brief   将毫秒数转换成时间
 */
+(NSString *)ConvertSecToTime:(NSString *)timeStr;

/**
 * @brief   颜色转换 IOS中十六进制的颜色转换为UIColor
 */
+ (UIColor *) colorWithHexString: (NSString *) hexString;

/**
 * @brief   颜色转换 IOS中RGB 转换为 UIcolor 不用输入/255.0;
 */
+ (UIColor *)colorWithRed:(float)red
                withGreen:(float)green
                withBlue:(float)blue
                withAlpha:(float)alpha;
/**
 * @brief   验证手机号码。
 */
+ (BOOL)validateMobile:(NSString *)mobileNum;
@end
