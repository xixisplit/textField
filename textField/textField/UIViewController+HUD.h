//
//  UIViewController+HUD.h
//  TransfarDriver
//
//  Created by Kevin on 15/7/9.
//  Copyright (c) 2015年 Transfar. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

//覆盖整个window
- (void)showHudInView:(UIView *)view hint:(NSString *)hint;

//不覆盖导航条
- (void)showHudInSuitableView:(NSString *)hint;

- (void)showHudInSuitableView:(NSString *)hint viewHeight:(float)height;

//不覆盖导航条和tabbar
- (void)showHudInSuitableMidView:(NSString *)hint;

- (void)hideHud;

- (void)showHint:(NSString *)hint;

// 从默认(showHint:)显示的位置再往上(下)yOffset
- (void)showHint:(NSString *)hint yOffset:(float)yOffset;

- (void)showSuccessHint:(NSString *)hint yOffset:(float)yOffset;

@end
