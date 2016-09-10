//
//  UITextField+Extension.m
//  TransfarFinancialPayment
//
//  Created by 陈曦 on 16/8/5.
//  Copyright © 2016年 Transfar. All rights reserved.
//

#import "UITextField+Extension.h"

@implementation UITextField (Extension)


- (NSRange) textFieldSelectedRange
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextRange* selectedRange = self.selectedTextRange;
    UITextPosition* selectionStart = selectedRange.start;
    UITextPosition* selectionEnd = selectedRange.end;
    
    const NSInteger location = [self offsetFromPosition:beginning toPosition:selectionStart];
    const NSInteger length = [self offsetFromPosition:selectionStart toPosition:selectionEnd];
    
    return NSMakeRange(location, length);
}

- (void) textFieldSetSelectedRange:(NSRange) range  // 备注：UITextField必须为第一响应者才有效
{
    UITextPosition* beginning = self.beginningOfDocument;
    
    UITextPosition* startPosition = [self positionFromPosition:beginning offset:range.location];
    UITextPosition* endPosition = [self positionFromPosition:beginning offset:range.location + range.length];
    UITextRange* selectionRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    
    [self setSelectedTextRange:selectionRange];
}


@end
