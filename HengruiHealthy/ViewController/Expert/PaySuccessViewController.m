//
//  PaySuccessViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PaySuccessViewController.h"

#import "AppointmentDetailTableViewController.h"

@interface PaySuccessViewController () {
    
    __weak IBOutlet UILabel *_lblOrderCode;
}

@end

@implementation PaySuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action

- (IBAction)actionForReviewButton:(UIButton *)sender {
    AppointmentDetailTableViewController *tvcAppointmentDetail = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAppointmentDetail"];
    tvcAppointmentDetail.recordId = self.code;
    [self.navigationController pushViewController:tvcAppointmentDetail animated:YES];
}

#pragma mark - UI

- (void)configUI {
    _lblOrderCode.text = self.code;
}

@end
