//
//  AddFamilyTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AddFamilyTableViewController.h"

#import "VertifyButton.h"

#import "LoginClient.h"
#import "PersonClient.h"

#import "MBPrograssManager.h"

@interface AddFamilyTableViewController () {
    
    __weak IBOutlet UITextField *_tfName;
    __weak IBOutlet UITextField *_tfMobile;
    __weak IBOutlet UITextField *_tfVertify;
    __weak IBOutlet VertifyButton *_btnFetch
    ;
}

@end

@implementation AddFamilyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 
}

- (void)getVertity {
    [MBPrograssManager showPrograssOnMainView];
    [[LoginClient shareInstance] obtainVertifyByMobile:_tfMobile.text handler:^(id responese, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessage:@"验证码已发送，请咨询您的家人" OnView:self.view];
            [_btnFetch triggerTime];
        } else {
            [MBPrograssManager showMessage:responese OnView:self.view];
        }
    }];
};

- (void)saveFamily {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] addFamilyName:_tfName.text mobile:_tfMobile.text vertity:_tfMobile.text handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actionForSaveFamily:(VertifyButton *)sender {
    [self getVertity];
}

@end
