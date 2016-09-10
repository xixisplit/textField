//
//  NSString+CH.m
//  Transfar_Business
//
//  Created by RiceJia on 15/11/9.
//  Copyright © 2015年 Transfar. All rights reserved.
//

#import "NSString+CH.h"

@implementation NSString (CH)

- (NSString *)stringByAppendingStringToFileName:(NSString *)string
{
    NSString * pathExtension = [self pathExtension];
    NSString * filename = [self stringByDeletingPathExtension];
    NSString * newFilename =  [filename stringByAppendingString:string];
    return [newFilename stringByAppendingPathExtension:pathExtension];
}

- (BOOL)hasSubString:(NSString *)string
{
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
    {
        if ([self containsString:string])
        {
            return YES;
        }
    }else{
        if ( [self rangeOfString:string].length >0)
        {
            return YES;
        }
    }
    return NO;
}

+(BOOL)isEmpty:(NSString *)aString shouldCleanWhiteSpace:(BOOL)cleanWhiteSpace
{
    if (!aString) {
        return YES;
    }
    if ((NSNull *)aString == [NSNull null] ) {
        return YES;
    }
    if ([aString length] == 0) {
        return YES;
    }
    if (cleanWhiteSpace) {
        aString = [aString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([aString length] == 0) {
            return YES;
        }
    }
    return NO;
}
- (NSString *)URLEncodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,                                                                         (CFStringRef)self,                                                                     NULL,                                                                          CFSTR("!*'();:@&=+$,/?%#[]"),                                                                 kCFStringEncodingUTF8));
    return result;
}
- (NSString*)URLDecodedString
{
    NSString *result = (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,                                                                                           (CFStringRef)self,                                                                                       CFSTR(""),                                                                                       kCFStringEncodingUTF8));
    return result;
}

+ (NSString *)stringWithArab:(int)arab
{
    NSArray * array = @[@"一",@"二",@"三",@"四",@"五",@"六",@"日"];
    return array[arab-1];
}

- (id)JSONValue
{
    NSData* data = [self dataUsingEncoding:NSUTF8StringEncoding];
    __autoreleasing NSError* error = nil;
    id result = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    if (error != nil) return nil;
    return result;
}

+ (NSString *)validString:(NSString*)string
{
    if (string == nil)
    {
        return @"";
    }else{
        return string;
    }
}

// 自动计算文字的高度
- (CGSize)sizeWIthFont:(UIFont *)font height:(CGFloat)height
{
    CGSize actualsize = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //get current font attributes
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        //IOS7 fix: get size that text needs, limit the width
        actualsize =[self boundingRectWithSize:CGSizeMake(MAXFLOAT,height) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        actualsize = [self sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT,height) lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    return actualsize;
}

// 自动计算文字的高度
- (CGSize)sizeWIthFont:(UIFont *)font width:(CGFloat)width
{
    CGSize actualsize = CGSizeZero;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        //get current font attributes
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
        //IOS7 fix: get size that text needs, limit the width
        actualsize =[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin  attributes:tdic context:nil].size;
    }else{
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        actualsize = [self sizeWithFont:font constrainedToSize:CGSizeMake(width, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
#pragma clang diagnostic pop
    }
    return actualsize;
}

// 截取一定长度地址字符串,比如 （杭州市，2） -> 杭州 
+ (NSString *)getAreaString:(NSString *)string length:(CGFloat)length{
    
    if ([NSString isEmpty:string shouldCleanWhiteSpace:YES] || [string isEqualToString:@"不限"]) {
        return nil;
    }
    
   NSString * resultStr = string;
    if ([string hasSuffix:@"省"] ||[string hasSuffix:@"市"]||[string hasSuffix:@"区"]||[string hasSuffix:@"县"]) {
        resultStr = [resultStr substringToIndex:resultStr.length-1];
    }
    
    if (resultStr.length > length) {
        resultStr = [NSString stringWithFormat:@"%@..",[string substringToIndex:length]];
    }
    
    return resultStr;
}


+(int)string:(NSString *)string numberWithSearchString:(NSString *)SearchString;
{
    if (string.length == 0) {
        return 0;
    }
    int x = 0;
    for (int i = 0; i<string.length; i++) {
        
        NSString *str = [string substringWithRange:NSMakeRange(i, 1)];
        if ([str isEqualToString:SearchString]) {
            x = x+1;
        }
    }
    return x;

}

@end
