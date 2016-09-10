//
//  TFPConmmonTextField.h
//  UITextField
//
//  Created by 陈曦 on 16/6/28.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_OPTIONS(NSUInteger, TFPConmmonTextFieldType) {

    ConmmonTextFieldBankCardNumber = 1 << 0, // 银行卡号模式
    ConmmonTextFieldMonetNumber = 1 << 1, //金额输入模式
    ConmmonTextFieldPassword = 1 << 2, //密码模式6-12位的时候回调
    ConmmonTextFieldPhoneMobile = 1 << 3, // 手机号码
};
@class TFPConmmonTextField;

@protocol TFPConmmonTextFieldPasswordDelegate <NSObject>

@optional
/**
 * 密码模式 超过设置位数的时候的回调
 */
- (void)conmmonText:(TFPConmmonTextField *)textField passwordLengthBeyondCallback:(NSString *)text;


@end

@protocol TFPConmmonTextFieldPhoneMobileDelegate <NSObject>

@optional
// 手机号码 输入11位会自动调用此方法
- (void)conmmonText:(TFPConmmonTextField *)textField phoneMobileEnterFinish:(NSString *)phoneMobile;

//文本发生变化
- (void)conmmonText:(TFPConmmonTextField *)textField textChange:(NSString *)text;

@end

@interface TFPConmmonTextField : UITextField
/**
 *  //安全手机号
 */
@property (nonatomic, strong) NSString *securityString;
/**
 *  输入模式
 */
@property (nonatomic, assign) TFPConmmonTextFieldType fieldtype;
/**
 *  //获取没有空格的号码.在银行卡号模式下使用
 */
@property (nonatomic, strong) NSString *textString;

/**
 *  密码模式 密码位数.在密码模式下.必须设置.
 */
@property (nonatomic, assign) CGFloat passwordLength;

/**
 *  金额输入模式.保留小数点后2位,自定义小数点前几位
 */
@property (nonatomic, assign) CGFloat monetLength;
/**
 *  密码模式 的代理.
 */
@property (nonatomic, weak) id<TFPConmmonTextFieldPasswordDelegate> passwordDelegate;

/**手机号模式代理*/
@property (nonatomic, weak) id<TFPConmmonTextFieldPhoneMobileDelegate> mobileDelegate;

/**是否启动自定义数字键盘*/
@property (nonatomic, assign) BOOL customKeyBord;

//**设置手机号码格式数字,11位字符串*/
- (void)setPhoneMobileText:(NSString *)string;

@end
