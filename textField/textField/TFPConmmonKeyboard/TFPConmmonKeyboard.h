//
//  TFPConmmonKeyboard.h
//  TransfarFinancialPayment
//
//  Created by 陈曦 on 16/9/9.
//  Copyright © 2016年 Transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TFPConmmonKeyboardDelegate <NSObject>
//**删除按钮*/
- (void)keyboardDelete;
//**完成按钮*/
- (void)keyboardComplete;
//**数字被点击*/
- (void)keyboardInputText:(NSString *)text;

@end

@interface TFPConmmonKeyboard : UIView

@property (nonatomic, weak) id<TFPConmmonKeyboardDelegate> delegate;

@end
