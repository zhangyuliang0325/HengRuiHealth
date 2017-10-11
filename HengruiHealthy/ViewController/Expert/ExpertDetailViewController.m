//
//  ExpertDetailViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/25.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertDetailViewController.h"

#import "ExpertDetailTableViewController.h"
#import "AppointmentTableViewController.h"

@interface ExpertDetailViewController () {
    ExpertDetailTableViewController *_tvcExpertDetail;
}

@end

@implementation ExpertDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _tvcExpertDetail = (ExpertDetailTableViewController *)segue.destinationViewController;
    _tvcExpertDetail.expert = self.expert;
}
- (IBAction)actionForAppointmentButton:(UIButton *)sender {
    AppointmentTableViewController *tvcAppointment = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAppointment"];
    tvcAppointment.expert = self.expert;
    [self.navigationController pushViewController:tvcAppointment animated:YES];
}

@end
