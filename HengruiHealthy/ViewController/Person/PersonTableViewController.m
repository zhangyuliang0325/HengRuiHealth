//
//  PersonTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PersonTableViewController.h"
#import "FamilysViewController.h"
#import "SettingClient.h"
#import "MBPrograssManager.h"
#import <TOWebViewController/TOWebViewController.h>
#import "AppointmentBookViewController.h"    //预约记录页

@interface PersonTableViewController () {
    
}

@end

@implementation PersonTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)logout {
    [MBPrograssManager showPrograssOnMainView];
    [MBPrograssManager showPrograssOnMainView];
    [[SettingClient shareInstance] logoutWithHandler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kHRHtyAccount];
            [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kHRHtyPassword];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[UIStoryboard storyboardWithName:@"Login" bundle:nil] instantiateViewControllerWithIdentifier:@"navLogin"];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Action
- (IBAction)actionForLogout:(UIBarButtonItem *)sender {
    [self logout];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return  10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        TOWebViewController *wvc = [[TOWebViewController alloc] initWithURLString:@"http://192.168.1.113:9000/content/mobile/helper.html"];
        wvc.showPageTitles = NO;
        wvc.title = @"使用帮助";
        wvc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:wvc animated:YES];
    } else if (indexPath.section == 0) {
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcPersonInfo"] animated:YES];
    } else if (indexPath.section == 4) {
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"vcFamilys"] animated:YES];
    } else if (indexPath.section == 3) {   //预约记录 AppointmentBookViewControllerID
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"vcAppointmentRecords"] animated:YES];
//        AppointmentBookViewController * appointmentVC = [[UIStoryboard storyboardWithName:@"Appointment" bundle:nil] instantiateViewControllerWithIdentifier:@"AppointmentBookViewControllerID"];
//        appointmentVC.hidesBottomBarWhenPushed = YES;
//        [self.navigationController pushViewController:appointmentVC animated:YES];
    }else {
        [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcEditPassword"] animated:YES];
    }
}

@end
