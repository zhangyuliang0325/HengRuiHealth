//
//  RegistViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "RegistViewController.h"

#import "VertifyButton.h"

#import "LoginClient.h"

#import "CheckStringManager.h"
#import "AlertManager.h"
#import "MBPrograssManager.h"
#import <TOWebViewController/TOWebViewController.h>
#import "AppDelegate.h"
@interface RegistViewController () <UITextFieldDelegate> {
    
    __weak IBOutlet UIScrollView *_scroll;
    __weak IBOutlet VertifyButton *_btnObtain;
    __weak IBOutlet UIButton *_btnProtocol;
    __weak IBOutlet UIButton *_btnAccept;
    __weak IBOutlet UIButton *_btnRegist;
    __weak IBOutlet UITextField *_tfPassword;
    __weak IBOutlet UITextField *_tfVertity;
    __weak IBOutlet UITextField *_tfAccount;
}

@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _scroll.contentSize = CGSizeMake(HRHtyScreenWidth, HRHtyScreenHeight);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Http server

- (void)registWithAccount:(NSString *)account vertity:(NSString *)vertity password:(NSString *)password {
    [MBPrograssManager showPrograssOnMainView];
    [[LoginClient shareInstance] registWithAccount:account password:password vertify:vertity handler:^(id responese, BOOL isSuccess) {
        if (isSuccess) {
            [self loginWithAccount:_tfAccount.text password:_tfPassword.text];
        } else {
            [MBPrograssManager hidePrograssFromMainView];
            [MBPrograssManager showMessage:responese OnView:self.view];
        }
    }];
}

- (void)loginWithAccount:(NSString *)account password:(NSString *)password {
    [[LoginClient shareInstance] loginWithAccount:account password:password handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:account forKey:kHRHtyAccount];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:kHRHtyPassword];
            [[NSUserDefaults standardUserDefaults] setObject:response forKey:kHRHtyUserId];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tbcMain"];
        } else {
//            [MBPrograssManager showMessage:response OnView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
            [MBPrograssManager showMessageOnMainView:@"注册成功，请登录"];
        }
        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate setUpSingalR];
    }];
}

- (void)obtainVertityCodeWithMobile:(NSString *)mobile {
    [[LoginClient shareInstance] obtainVertifyByMobile:mobile handler:^(id responese, BOOL isSuccess) {
        if (isSuccess) {
            [_btnObtain triggerTime];
            [MBPrograssManager showMessage:@"验证码已发送至您的手机" OnView:self.view];
        } else {
            [MBPrograssManager showMessage:responese OnView:self.view];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForBack:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)actionForShowProtocol:(UIButton *)sender {
    TOWebViewController *wvc = [[TOWebViewController alloc] initWithURLString:@"http://192.168.1.113:9000/content/mobile/useragreement.html"];
    
    wvc.hidesBottomBarWhenPushed = YES;
    wvc.showPageTitles = NO;
    wvc.title = @"用户协议";
    [self.navigationController pushViewController:wvc animated:YES];
}

- (IBAction)actionForAcceptProtocol:(UIButton *)sender {
    sender.selected = !sender.selected;
    _btnRegist.enabled = sender.selected;
}

- (IBAction)actionForRegist:(UIButton *)sender {
    [self.view endEditing:YES];
    if (_btnRegist.enabled) {
        if ([self checkInfoForRegist]) {
            [self registWithAccount:_tfAccount.text vertity:_tfVertity.text password:_tfPassword.text];
        }
    }
}

- (IBAction)actionForObtain:(VertifyButton *)sender {
    [self.view endEditing:YES];
    if ([self checkInfoForFetchVertityCode]) {
        [sender triggerTime];
        [self obtainVertityCodeWithMobile:_tfAccount.text];
//        [[ConnectManager shareInstance] obtainVertifyWithMobile:_tfAccount.text];
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
    } else if (textField == _tfPassword) {
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

- (BOOL)checkInfoForRegist {
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
