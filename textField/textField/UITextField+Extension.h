//
//  UITextField+Extension.h
//  TransfarFinancialPayment
//
//  Created by 陈曦 on 16/8/5.
//  Copyright © 2016年 Transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Extension)

- (NSRange) textFieldSelectedRange;
- (void) textFieldSetSelectedRange:(NSRange) range;


@end
