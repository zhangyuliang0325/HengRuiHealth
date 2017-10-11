//
//  LoginViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "LoginViewController.h"

#import "LoginClient.h"

#import "MBPrograssManager.h"
#import "CheckStringManager.h"
#import "AlertManager.h"
#import "AppDelegate+StartManager.h"
#import "EAIntroViewManager.h"
#import "AppDelegate.h"

@interface LoginViewController () <UITextFieldDelegate, UINavigationControllerDelegate, EAIntroDelegate> {
    
    __weak IBOutlet UIScrollView *_scroll;
    __weak IBOutlet UIButton *_btnRegist;
    __weak IBOutlet UIButton *_btnLogin;
    __weak IBOutlet UIButton *_btnFerget;
    __weak IBOutlet UITextField *_tfPassword;
    __weak IBOutlet UITextField *_tfAccount;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startController];
    self.navigationController.delegate = self;
    [self configUIOnLoad];
    _scroll.contentSize = CGSizeMake(HRHtyScreenWidth, HRHtyScreenHeight);
    // Do any additional setup after loading the view.
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.view endEditing:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)loginWithAccount:(NSString *)account password:(NSString *)password {
    [MBPrograssManager showPrograssOnMainView];
    [[LoginClient shareInstance] loginWithAccount:account password:password handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:account forKey:kHRHtyAccount];
            [[NSUserDefaults standardUserDefaults] setObject:password forKey:kHRHtyPassword];
            [[NSUserDefaults standardUserDefaults] setObject:response forKey:kHRHtyUserId];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"tbcMain"];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
        AppDelegate * appDelegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
        [appDelegate setUpSingalR];
    }];
}

#pragma mark - Action

- (IBAction)actionForLogin:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self checkInfo]) {
        [self loginWithAccount:_tfAccount.text password:_tfPassword.text];
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
    } else if (textField == _tfPassword) {
        if (textField.text.length - range.length + string.length > 12) {
            return NO;
        } else {
            return [CheckStringManager checkString:string inputExpressions:@"[A-Za-z0-9]"];
        }
    }
    return YES;
}

#pragma mark - Navigation controller delegate

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([viewController isKindOfClass:NSClassFromString(@"FergetViewController")]) {
        [navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [navigationController setNavigationBarHidden:YES animated:YES];
    }
}

#pragma mark - EAIntro delegate

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    [self autoLogin];
}

#pragma mark - UI

- (void)configUIOnLoad {
    _btnRegist.layer.borderColor = [UIColor orangeColor].CGColor;
    _btnRegist.layer.borderWidth = 1;
    
}

- (void)startController {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger startCount = [delegate fetchStartCount];
    if (startCount == 1) {
        [EAIntroViewManager configEAIntroViewInView:self.view pages:[NSArray arrayWithObjects:[UIImage imageNamed:@"guide1"], [UIImage imageNamed:@"guide2"], [UIImage imageNamed:@"guide3"], [UIImage imageNamed:@"guide4"], [UIImage imageNamed:@"guide5"], nil] delegate:self];
    } else {
        [self checkVersion];
    }
}

#pragma mark - Method

- (BOOL)checkInfo {
    if ([CheckStringManager checkBlankString:_tfAccount.text]) {
        [MBPrograssManager showMessage:@"请输入手机号码" OnView:self.view];
        return NO;
    }
    if (![CheckStringManager checkMobile:_tfAccount.text]) {
        [MBPrograssManager showMessage:@"手机号码不正确，请重新输入" OnView:self.view];
        return NO;
    }
    if ([CheckStringManager checkBlankString:_tfPassword.text]) {
        [MBPrograssManager showMessage:@"请输入密码" OnView:self.view];
        return NO;
    }
    if (![CheckStringManager checkPassword:_tfPassword.text]) {
        [MBPrograssManager showMessage:@"密码不正确，请重新输入" OnView:self.view];
        return NO;
    }
    return YES;
}

- (void)autoLogin {
    NSString *account = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAccount];
    if (![CheckStringManager checkBlankString:account]) {
        [self loginWithAccount:account password:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyPassword]];
    }
}

- (void)checkVersion {
    [MBPrograssManager showPrograssOnMainView];
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *url = @"https://itunes.apple.com/lookup?id=1261666235";
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBPrograssManager hidePrograssFromMainView];
            if (error) {
                [self autoLogin];
                return;
            } else {
                NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
                NSArray *resultArr = responseObject[@"results"];
                if (resultArr.count > 0) {
                    NSDictionary *resultsDict = resultArr.firstObject;
                    NSString *appStoreVersion = resultsDict[@"version"];
                    NSString *trackViewUrl = resultsDict[@"trackViewUrl"];
                    if ([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                        UIAlertController *ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"当前版本 v%@", currentVersion] message:[NSString stringWithFormat:@"有更新版本 v%@", appStoreVersion] preferredStyle:UIAlertControllerStyleAlert];
                        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                            [self autoLogin];
                        }];
                        UIAlertAction *update = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
                        }];
                        [ac addAction:cancel];
                        [ac addAction:update];
                        [self presentViewController:ac animated:YES completion:nil];
                    } else {
                        [self autoLogin];
                        return;
                    }
                } else {
                    [self autoLogin];
                }
            }
            
        });
    }];
    [task resume];
}

@end
