//
//  FergetViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "FergetViewController.h"

#import "VertifyButton.h"

#import "LoginClient.h"

#import "CheckStringManager.h"
#import "AlertManager.h"
#import "MBPrograssManager.h"

@interface FergetViewController () <UITextFieldDelegate> {
    
    __weak IBOutlet UIScrollView *_scroll;
    __weak IBOutlet UIButton *_btnSubmit;
    __weak IBOutlet VertifyButton *_btnObtain;
    __weak IBOutlet UITextField *_tfConfirm;
    __weak IBOutlet UITextField *_tfPassword;
    __weak IBOutlet UITextField *_tfVertity;
    __weak IBOutlet UITextField *_tfAccount;
}

@end

@implementation FergetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scroll.contentSize = CGSizeMake(HRHtyScreenWidth, HRHtyScreenHeight);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)obtainVertityCodeWithMobile:(NSString *)mobile {
    [MBPrograssManager showPrograssOnMainView];
    [[LoginClient shareInstance] obtainVertifyByMobile:mobile handler:^(id responese, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [_btnObtain triggerTime];
            [MBPrograssManager showMessage:@"验证码已发送至您的手机，请查收" OnView:self.view];
        } else {
            [MBPrograssManager showMessage:responese OnView:self.view];
        }
    }];
}

- (void)resetWithAccount:(NSString *)account password:(NSString *)password vertity:(NSString *)vertity {
    [MBPrograssManager showPrograssOnMainView];
    [[LoginClient shareInstance] resetPasswordForAccount:account password:password vertify:vertity handler:^(id responese, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessageOnMainView:@"重置密码成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBPrograssManager showMessage:responese OnView:self.view];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForObtain:(UIButton *)sender {
    if ([self checkInfoForFetchVertityCode]) {
        [self obtainVertityCodeWithMobile:_tfAccount.text];
    }
}

- (IBAction)actionForSubmit:(UIButton *)sender {
    if ([self checkInfoForReset]) {
        [self resetWithAccount:_tfAccount.text password:_tfPassword.text vertity:_tfVertity.text];
    }
}

#pragma mark - Text field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == _tfAccount) {
        if (textField.text.length - range.length + string.length > 11) {
            return NO;
        }
    } else if (textField == _tfVertity) {
        if (textField.text.length - range.length + string.length > 6) {
            return NO;
        }
    } else if (textField == _tfPassword || textField == _tfConfirm) {
        if (textField.text.length - range.length + string.length > 12) {
            return NO;
        } else {
            return [CheckStringManager checkString:string inputExpressions:@"[a-zA-Z0-9]"];
        }
    }
    return YES;
}

#pragma mark - UI

#pragma mark - Method

- (BOOL)checkInfoForFetchVertityCode {
    if ([CheckStringManager checkBlankString:_tfAccount.text]) {
        [MBPrograssManager showMessage:@"请输入手机号码" OnView:self.view];
        return NO;
    }
    if (![CheckStringManager checkMobile:_tfAccount.text]) {
        [MBPrograssManager showMessage:@"手机号码不正确，请重新输入" OnView:self.view];
        return NO;
    }
    return YES;
}

- (BOOL)checkInfoForReset {
    if ([self checkInfoForFetchVertityCode]) {
        if ([CheckStringManager checkBlankString:_tfVertity.text]) {
            [MBPrograssManager showMessage:@"请输入验证码" OnView:self.view];
            return NO;
        }
        if (![CheckStringManager checkVertity:_tfVertity.text]) {
            [MBPrograssManager showMessage:@"验证码不正确，请重新输入" OnView:self.view];
            return NO;
        }
        if ([CheckStringManager checkBlankString:_tfPassword.text]) {
            [MBPrograssManager showMessage:@"请输入密码" OnView:self.view];
            return NO;
        }
        if (![CheckStringManager checkPassword:_tfPassword.text]) {
            [MBPrograssManager showMessage:@"密码格式不正确，请重新输入" OnView:self.view];
            return NO;
        }
    } else {
        return NO;
    }
    return YES;
}

@end
