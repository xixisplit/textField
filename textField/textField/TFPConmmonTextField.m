//
//  TFPConmmonTextField.m
//  UITextField
//
//  Created by 陈曦 on 16/6/28.
//  Copyright © 2016年 xi chen. All rights reserved.
//   UIKeyboardTypeDecimalPad  金额输入
#define myDotNumbers @"0123456789.\n"
#define myNumbers @"0123456789\n"
#import "NSString+CH.h"
#import "TFPConmmonKeyboard.h"
#import "TFPConmmonTextField.h"
#import "UITextField+Extension.h"
#import "UIViewController+HUD.h"

@interface TFPConmmonTextField () <UITextFieldDelegate, UIKeyInput,
                                   TFPConmmonKeyboardDelegate>

@property(nonatomic, assign) BOOL point;

@property(nonatomic, assign) BOOL textDelete;

@property(nonatomic, assign) CGFloat textLengh;

@property(nonatomic, strong) TFPConmmonKeyboard *keyBoard;

@end

@implementation TFPConmmonTextField

- (instancetype)init {
  self = [super init];
  if (self) {

    [self addtarget];
  }
  return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
  self = [super initWithFrame:frame];
  if (self) {
    [self addtarget];
  }
  return self;
}

- (void)addtarget {

  self.delegate = self;
  self.clearButtonMode = UITextFieldViewModeAlways;
  [self addTarget:self
                action:@selector(textChange)
      forControlEvents:UIControlEventEditingChanged];
}

- (void)deleteTextChange {

  if (self.fieldtype == ConmmonTextFieldPhoneMobile) {

    self.text =
        [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *mutStr = [NSMutableString stringWithString:self.text];

    if (mutStr.length > 3) {
      [mutStr insertString:@" " atIndex:3];
    }
    if (mutStr.length > 8) {
      [mutStr insertString:@" " atIndex:8];
    }
    if (mutStr.length > 13) {

      mutStr =
          (NSMutableString *)[mutStr substringWithRange:NSMakeRange(0, 13)];
    }

    self.text = mutStr;
  }
}

- (void)textChange {
  // 获取键盘高亮文字. 删除键盘不高亮的文字.

  if (self.text.length < self.textLengh) {

    self.textDelete = YES;
  } else {
    self.textDelete = NO;
    self.textLengh = self.text.length;
  }

  if ([self.mobileDelegate
          respondsToSelector:@selector(conmmonText:textChange:)]) {

    [self.mobileDelegate
        conmmonText:self
         textChange:[self.text stringByReplacingOccurrencesOfString:@" "
                                                         withString:@""]];
  }

  //-------------------银行卡号---------------------
  if (self.fieldtype == ConmmonTextFieldBankCardNumber) {

    self.text =
        [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *mutStr = [NSMutableString stringWithString:self.text];
    //--------------------------

    //        -----------------------------------
    if (mutStr.length > 4) {
      [mutStr insertString:@" " atIndex:4];
    }
    if (mutStr.length > 9) {
      [mutStr insertString:@" " atIndex:9];
    }
    if (mutStr.length > 14) {
      [mutStr insertString:@" " atIndex:14];
    }
    if (mutStr.length > 19) {

      [mutStr insertString:@" " atIndex:19];
    }
    if (mutStr.length > 24) {
      [mutStr insertString:@" " atIndex:24];
    }
    if (mutStr.length > 28) {

      mutStr =
          (NSMutableString *)[mutStr substringWithRange:NSMakeRange(0, 28)];
    }
    self.text = mutStr;
  }
  // 手机号码格式 123 3345 1123
  else if (self.fieldtype == ConmmonTextFieldPhoneMobile) {

    self.text =
        [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSMutableString *mutStr = [NSMutableString stringWithString:self.text];

    if (mutStr.length > 3) {
      [mutStr insertString:@" " atIndex:3];
    }
    if (mutStr.length > 8) {
      [mutStr insertString:@" " atIndex:8];
    }
    if (mutStr.length > 13) {

      mutStr =
          (NSMutableString *)[mutStr substringWithRange:NSMakeRange(0, 13)];
    }
    if (mutStr.length == 13 && self.textDelete == NO) {
      if ([self.mobileDelegate
              respondsToSelector:@selector(conmmonText:
                                     phoneMobileEnterFinish:)]) {
        [self.mobileDelegate conmmonText:self phoneMobileEnterFinish:mutStr];
      }
    }
    self.text = mutStr;
  }
  //-------------------银行卡号---------------------
}

- (void)setSecurityString:(NSString *)securityString {

  _securityString = securityString;
  self.clearButtonMode = UITextFieldViewModeNever;
  self.text =
      [securityString stringByReplacingCharactersInRange:NSMakeRange(3, 4)
                                              withString:@"****"];
  self.enabled = NO;
}

- (NSString *)textString {

  return [self.text stringByReplacingOccurrencesOfString:@" " withString:@""];
}

- (BOOL)textField:(UITextField *)textField
    shouldChangeCharactersInRange:(NSRange)range
                replacementString:(NSString *)string {
  // 不让输入空格.
  if ([string isEqualToString:@" "]) {
    return NO;
  }
  if ([string isEqualToString:@""]) {
    return YES;
  }

  if (self.fieldtype == ConmmonTextFieldMonetNumber) {

    //如果 string 为"." 并且 self.text 已经有一位"."了,就直接返回 NO. 不再输入
    if ([string isEqualToString:@"."] &&
        [NSString string:self.text numberWithSearchString:@"."] > 0) {

      return NO;
    }

    if ([string isEqualToString:@"\n"] ||
        [string isEqualToString:@""]) { //按下return
      return YES;
    }

    // 限制当小数点后面2位.就不再让输入了
    NSCharacterSet *cs;
    NSUInteger nDotLoc = [textField.text rangeOfString:@"."].location;
    if (NSNotFound == nDotLoc && 0 != range.location) {
      cs = [[NSCharacterSet characterSetWithCharactersInString:myNumbers]
          invertedSet];
      if ([string isEqualToString:@"."]) {
        return YES;
      }
      if (textField.text.length >=
          self.monetLength) { //小数点前面self.monetLength 位
        return NO;
      }
    } else {
      cs = [[NSCharacterSet characterSetWithCharactersInString:myDotNumbers]
          invertedSet];
      if (textField.text.length >= self.monetLength + 3) {
        return NO;
      }
    }
    NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs]
        componentsJoinedByString:@""];
    BOOL basicTest = [string isEqualToString:filtered];
    if (!basicTest) {
      return NO;
    }
    if (NSNotFound != nDotLoc &&
        range.location > nDotLoc + 2) { //小数点后面两位
      return NO;
    }
    return YES;
  }

  /**
   *  密码tip提示模式
   */
  if (self.fieldtype == ConmmonTextFieldPassword) {

    if (textField.text.length >= self.passwordLength) {

      if ([self.passwordDelegate
              respondsToSelector:@selector(conmmonText:
                                     passwordLengthBeyondCallback:)]) {
        [self.passwordDelegate conmmonText:self
              passwordLengthBeyondCallback:textField.text];
        UIViewController *vc = (UIViewController *)self.passwordDelegate;
        [vc hideHud];
        [vc showHint:[NSString stringWithFormat:@"最多不能超过%d位",
                                                (int)self.passwordLength]
             yOffset:-200];
      }

      return NO;
    }
  }
  if (self.fieldtype == ConmmonTextFieldPhoneMobile) {

    // 调用自定义键盘的字符串输入. 阻止系统的输入返回.
    [self keyboardInputText:string];
    return NO;
  }

  return YES;
}

- (void)deleteBackward {

  // 在调用删除之前.先记录当前光标的 range;
  NSRange range = [self textFieldSelectedRange];

  [super deleteBackward];

  //    如果是银行卡模式.删除的时候.就 range - 1位.在空格的位置.- 2位,重新复制
  //    ruange 给光标位置
  if (self.fieldtype == ConmmonTextFieldBankCardNumber) {

    float x = 1;
    if (self.text.length == 4 || self.text.length == 9 ||
        self.text.length == 14 || self.text.length == 19 ||
        self.text.length == 24) {
      x = 2;
    }
    range = NSMakeRange(range.location - x, range.length);
    [self textFieldSetSelectedRange:range];
    // textlenght 文本发生变化的时候都记录
  } else if (self.fieldtype == ConmmonTextFieldPhoneMobile) {

    int locationOffset = 0; // location的偏移,默认为0,当在 text
                            // 文本中间位置删除的时候.在空格位置做特殊处理
    if ((range.location == 4 || range.location == 9) &&
        (range.location != self.text.length)) {
      self.text = [self.text
          stringByReplacingCharactersInRange:NSMakeRange(range.location - 2, 2)
                                  withString:@""];
      //
      locationOffset = 1;
    }

    float x = 1;
    if (self.text.length == 3 || self.text.length == 8 ||
        self.text.length == 13) {
      x = 2;
    }
    range = NSMakeRange(range.location - x - locationOffset, range.length);

    [self deleteTextChange];
    [self textFieldSetSelectedRange:range];
  }
}
- (void)setFieldtype:(TFPConmmonTextFieldType)fieldtype {
  _fieldtype = fieldtype;
  self.secureTextEntry = _fieldtype == ConmmonTextFieldPassword ? YES : NO;
}

- (void)setCustomKeyBord:(BOOL)customKeyBord {
  _customKeyBord = customKeyBord;
  if (customKeyBord) {

    self.inputView = self.keyBoard;
  }
}

//**设置手机号码格式数字*/
- (void)setPhoneMobileText:(NSString *)string {
  self.text = string;
  [self textChange];
  if (string.length == 11) {

    if ([self.mobileDelegate respondsToSelector:@selector(conmmonText:
                                                    phoneMobileEnterFinish:)]) {
      [self.mobileDelegate conmmonText:self phoneMobileEnterFinish:string];
    }
  }
}

//--------------自定义数字键盘---------------/

#pragma mark-- TFPConmmonKeyboardDelegate

- (void)keyboardDelete {

  [self deleteBackward];
}
- (void)keyboardComplete {

  [self endEditing:YES];
}

- (void)keyboardInputText:(NSString *)text {

  NSRange range = [self textFieldSelectedRange];

  NSMutableString *MutableString = [NSMutableString stringWithString:self.text];
  [MutableString insertString:text atIndex:range.location];
  self.text = MutableString.copy;
  [self textChange];

  NSLog(@"--长度--%d--%d", (int)self.text.length, (int)range.location);

  float x = 1;
  if (self.text.length == 5 || self.text.length == 10 ||
      self.text.length == 14 || range.location == 3 || range.location == 8) {
    x = 2;
  }
  range = NSMakeRange(range.location + x, range.length);

  NSLog(@"range --%ld-%ld", range.location, range.length);
  if (range.location > 13) {
    range.location = 13;
  }

  [self textFieldSetSelectedRange:range];
}

- (TFPConmmonKeyboard *)keyBoard {

  if (_keyBoard == nil) {

    _keyBoard = [[TFPConmmonKeyboard alloc] init];
    _keyBoard.delegate = self;
  }
  return _keyBoard;
}

@end
