//
//  TFPConmmonKeyboard.m
//  TransfarFinancialPayment
//
//  Created by 陈曦 on 16/9/9.
//  Copyright © 2016年 Transfar. All rights reserved.
//

#import "TFPConmmonKeyboard.h"
#import "UIImage+Scale.h"
#import "CHUtil.h"

@interface TFPConmmonKeyboard ()

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *keyArray;

@end

@implementation TFPConmmonKeyboard

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {

        self.keyArray = @[ @"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"完成", @"0", @"删除" ];

        [self addPageSubviews];
        [self layoutPageSubviews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 52 * 4 + 3);
    }
    return self;
}

#pragma mark-- lifeCycle

- (void)addPageSubviews
{

    int margin = 1; //间隙
    int width = ([UIScreen mainScreen].bounds.size.width - margin) / 3; //格子的宽
    int height = 52; //格子的高

    for (int i = 0; i < 12; i++)
    {
        int row = i / 3;
        int col = i % 3;
        UIButton *button = [[UIButton alloc] init];
        button.frame = CGRectMake(0 + col * (width + margin), row * (height + margin), width, height);
        button.backgroundColor = [UIColor redColor];
        button.tag = i;
        [button setTitle:self.keyArray[i] forState:(UIControlStateNormal)];
        button.titleLabel.font = [UIFont systemFontOfSize:20];
        
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
        
        if (i == 9) {
            button.backgroundColor = [CHUtil colorWithHexString:@"#DBDCE3"];
            
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:(UIControlStateHighlighted)];
            [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
            
        }else if (i == 11)
        {
            button.backgroundColor = [CHUtil colorWithHexString:@"#DBDCE3"];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:(UIControlStateHighlighted)];
            [button setTitleColor:[UIColor lightGrayColor] forState:(UIControlStateHighlighted)];
        
        }else
        {
            button.backgroundColor = [UIColor whiteColor];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor lightGrayColor]] forState:(UIControlStateHighlighted)];
        }
        
        
        [self addSubview:button];
        [button addTarget:self action:@selector(keyboardButtonClick:) forControlEvents:(UIControlEventTouchUpInside)];
    }
}

- (void)layoutPageSubviews
{
}
//私有方法
#pragma mark-- private function

// 控件监听方法
#pragma mark-- event response

- (void)keyboardButtonClick:(UIButton *)button
{
    NSLog(@"%@", self.keyArray[button.tag]);
    if (button.tag == 9)
    {

        if ([self.delegate respondsToSelector:@selector(keyboardComplete)])
        {
            [self.delegate keyboardComplete];
        }
    }
    else if (button.tag == 11)
    {
        if ([self.delegate respondsToSelector:@selector(keyboardDelete)])
        {
            [self.delegate keyboardDelete];
        }
    }
    else
    {

        if ([self.delegate respondsToSelector:@selector(keyboardInputText:)])
        {
            [self.delegate keyboardInputText:self.keyArray[button.tag]];
        }
    }
}

#pragma mark-- Delegate
#pragma mark-- setter getter

@end
