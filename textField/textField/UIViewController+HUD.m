//
//  UIViewController+HUD.m
//  TransfarDriver
//
//  Created by Kevin on 15/7/9.
//  Copyright (c) 2015年 Transfar. All rights reserved.
//

#import "UIViewController+HUD.h"

#import "MBProgressHUD/MBProgressHUD.h"
#import <objc/runtime.h>
static const void *HttpRequestHUDKey = &HttpRequestHUDKey;
static NSInteger hudViewTag = 2015112588;
#define IS_IPHONE_4S [UIScreen mainScreen].bounds.size.height == 480
@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD{
    return objc_getAssociatedObject(self, HttpRequestHUDKey);
}

- (void)setHUD:(MBProgressHUD *)HUD{
    objc_setAssociatedObject(self, HttpRequestHUDKey, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHudInView:(UIView *)view hint:(NSString *)hint{
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.labelText = hint;
    [view addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void)showHint:(NSString *)hint {
    
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    // 为了适应自动换行 yuge 12.3
    hud.detailsLabelText = hint;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_4S ? 150.f : 200.f;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)showHint:(NSString *)hint yOffset:(float)yOffset {
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    // 为了适应自动换行 wangqian 12.4
    hud.detailsLabelText = hint;
    hud.detailsLabelFont = [UIFont boldSystemFontOfSize:16];
    hud.margin = 10.f;
    hud.yOffset = IS_IPHONE_4S ? 150.f : 200.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}

- (void)hideHud{
    
    [[self HUD] hide:YES];
    for (UIView *subView in self.view.subviews)
    {
        if (subView.tag == hudViewTag)
        {
            [subView removeFromSuperview];
            break;
        }
    }
}

- (void)showHudInSuitableView:(NSString *)hint
{
    if ([self.view viewWithTag:hudViewTag])
    {
        return;
    }
    UIView *hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];
    [self.view addSubview:hudView];
    hudView.tag = hudViewTag;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:hudView];
    HUD.labelText = hint;
    [hudView addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void)showHudInSuitableView:(NSString *)hint viewHeight:(float)height
{
    if ([self.view viewWithTag:hudViewTag])
    {
        return;
    }
    UIView *hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, height-64)];
    [self.view addSubview:hudView];
    hudView.tag = hudViewTag;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:hudView];
    HUD.labelText = hint;
    [hudView addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void)showHudInSuitableMidView:(NSString *)hint
{
    if ([self.view viewWithTag:hudViewTag])
    {
        return;
    }
    UIView *hudView = [[UIView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 49)];
    [self.view addSubview:hudView];
    hudView.tag = hudViewTag;
    MBProgressHUD *HUD = [[MBProgressHUD alloc] initWithView:hudView];
    HUD.labelText = hint;
    [hudView addSubview:HUD];
    [HUD show:YES];
    [self setHUD:HUD];
}

- (void)showSuccessHint:(NSString *)hint yOffset:(float)yOffset
{
    //显示提示信息
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"toast_success.png"]];
    hud.labelText = hint;
    hud.margin = 10.f;
    hud.minSize = CGSizeMake(100, 100);
    hud.yOffset = IS_IPHONE_4S ? 150.f : 200.f;
    hud.yOffset += yOffset;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1];
}


@end
