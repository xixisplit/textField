//
//  ViewController.m
//  textField
//
//  Created by 陈曦 on 16/9/10.
//  Copyright © 2016年 xi chen. All rights reserved.
//

#import "ViewController.h"
#import "TFPConmmonTextField.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    

    TFPConmmonTextField *field1 = [[TFPConmmonTextField alloc]init];
    field1.layer.borderWidth = 1;
    field1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    field1.backgroundColor = [UIColor whiteColor];
    field1.frame = CGRectMake(50, 50, 250, 30);
    field1.fieldtype = ConmmonTextFieldBankCardNumber;
    field1.placeholder = @"银行卡号";
    [self.view addSubview:field1];
    
    
    TFPConmmonTextField *field2 = [[TFPConmmonTextField alloc]init];
     field2.backgroundColor = [UIColor whiteColor];
    field2.layer.borderWidth = 1;
    field2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    field2.frame = CGRectMake(50, 100, 250, 30);
    field2.fieldtype = ConmmonTextFieldMonetNumber;
    field2.placeholder = @"金额输入";
    field2.monetLength = 7;
    [self.view addSubview:field2];
    
    
    TFPConmmonTextField *field3 = [[TFPConmmonTextField alloc]init];
    field3.backgroundColor = [UIColor whiteColor];
    field3.layer.borderWidth = 1;
    field3.layer.borderColor = [UIColor lightGrayColor].CGColor;
    field3.frame = CGRectMake(50, 150, 250, 30);
    field3.fieldtype = ConmmonTextFieldPassword;
    field3.placeholder = @"密码模式";
    field3.passwordLength = 6;
    [self.view addSubview:field3];
    
    
    TFPConmmonTextField *field4 = [[TFPConmmonTextField alloc]init];
     field4.backgroundColor = [UIColor whiteColor];
    field4.layer.borderWidth = 1;
    field4.layer.borderColor = [UIColor lightGrayColor].CGColor;
    field4.frame = CGRectMake(50, 200, 250, 30);
    field4.fieldtype = ConmmonTextFieldPhoneMobile;
    field4.placeholder = @"手机号模式/自定义数字键盘";
    field4.customKeyBord = YES;
    
    [self.view addSubview:field4];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
