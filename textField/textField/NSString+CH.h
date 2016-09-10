//
//  NSString+CH.h
//  Transfar_Business
//
//  Created by RiceJia on 15/11/9.
//  Copyright © 2015年 Transfar. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (CH)
- (NSString *)stringByAppendingStringToFileName:(NSString *)string;

- (BOOL)hasSubString:(NSString *)string;

+(BOOL)isEmpty:(NSString *)aString shouldCleanWhiteSpace:(BOOL)cleanWhiteSpace;
- (NSString *)URLEncodedString;
- (NSString *)URLDecodedString;
+ (NSString *)stringWithArab:(int)arab;
-(id)JSONValue;
//
+ (NSString *)validString:(NSString*)string;

- (CGSize)sizeWIthFont:(UIFont *)font height:(CGFloat)height;

- (CGSize)sizeWIthFont:(UIFont *)font width:(CGFloat)width;


+ (NSString *)getAreaString:(NSString *)string length:(CGFloat)length;

+(int)string:(NSString *)string numberWithSearchString:(NSString *)SearchString;

@end
