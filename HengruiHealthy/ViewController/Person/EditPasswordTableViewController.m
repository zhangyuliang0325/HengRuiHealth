//
//  EditPasswordTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EditPasswordTableViewController.h"

#import "PersonClient.h"

#import "CheckStringManager.h"
#import "MBPrograssManager.h"
#import "AlertManager.h"

@interface EditPasswordTableViewController () <UITextFieldDelegate> {
    
    __weak IBOutlet UIButton *_btnSubmit;
    __weak IBOutlet UITextField *_tfConfirm;
    __weak IBOutlet UITextField *_tfNew;
    __weak IBOutlet UITextField *_tfOld;
}

@end

@implementation EditPasswordTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)changeOldPassword:(NSString *)old toNewPassword:(NSString *)newPassword {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] changeOldPassword:old toNewPassword:newPassword handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessageOnMainView:@"密码修改成功"];
            [[NSUserDefaults standardUserDefaults] setObject:newPassword forKey:kHRHtyPassword];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForSubmit:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self checkInfo]) {
        [self changeOldPassword:_tfOld.text toNewPassword:_tfNew.text];
    }
}

#pragma mark - Text field delegate 

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.text.length - range.length + string.length > 12) {
        return NO;
    } else {
        return [CheckStringManager checkString:string inputExpressions:@"[0-9a-zA-Z]"];
    }
    return YES;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

#pragma mark - Method 

- (BOOL)checkInfo {
    if ([CheckStringManager checkBlankString:_tfOld.text]) {
        [MBPrograssManager showMessage:@"请输入原密码" OnView:self.view];
        return NO;
    }
    if (![_tfOld.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyPassword]]) {
        [MBPrograssManager showMessage:@"原密码输入错误，请检查后重新输入" OnView:self.view];
        return NO;
    }
    if ([CheckStringManager checkBlankString:_tfNew.text]) {
        [MBPrograssManager showMessage:@"请输入新密码" OnView:self.view];
        return NO;
    }
    if (![CheckStringManager checkPassword:_tfNew.text]) {
        [MBPrograssManager showMessage:@"新密码格式不正确，请重新输入" OnView:self.view];
        return NO;
    }
    if ([CheckStringManager checkBlankString:_tfConfirm.text]) {
        [MBPrograssManager showMessage:@"请再次输入新密码" OnView:self.view];
        return NO;
    }
    if (![_tfConfirm.text isEqualToString:_tfNew.text]) {
        [MBPrograssManager showMessage:@"两次输入的新密码不一致，请重新输入" OnView:self.view];
        return NO;
    }
    return YES;
}

@end
