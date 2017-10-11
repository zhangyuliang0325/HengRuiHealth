//
//  AppointmentDetailTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentDetailTableViewController.h"

#import "HealthyArchiveDetailTableViewController.h"

#import "ExpertReviewViewController.h"

#import "AppointmentArchiveTableViewCell.h"

#import "PersonClient.h"

#import "MBPrograssManager.h"
#import <MJExtension.h>
@interface AppointmentDetailTableViewController () <AppoinmentArchiveCellDelegate> {
    
    __weak IBOutlet UITableView *_tvArchives;
    __weak IBOutlet UIImageView *_imgMale;
    __weak IBOutlet UIImageView *_imgFemale;
    __weak IBOutlet UILabel *_lblBirth;
    __weak IBOutlet UILabel *_lblOverdueTime;
    __weak IBOutlet UITextView *_txtRemark;
    __weak IBOutlet UIButton *_btnReview;
    
    NSArray *_archives;
}

@end

@implementation AppointmentDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.record == nil) {
        [self getDetail];
    } else {
        [self configUI];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)getDetail {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] getAppointmentRecordDetail:self.recordId handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            self.record = [AppointmentRecord mj_objectWithKeyValues:response];
            [self configUI];
        } else {
            
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForReviewButton:(UIButton *)sender {
    ExpertReviewViewController *vcExpertReview = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"vcExpertReview"];
    vcExpertReview.record = self.record;
    [self.navigationController pushViewController:vcExpertReview animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == _tvArchives) {
        return 1;
    } else {
        
        return [super numberOfSectionsInTableView:tableView];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tvArchives) {
        return self.record.reports.count;
    } else {
        return [super tableView:tableView numberOfRowsInSection:section];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tvArchives) {
        static NSString *cellIdentifier = @"AppointmentArchiveCell";
        AppointmentArchiveTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
        HealthyArchive *archive = self.record.reports[indexPath.row];
        cell.archive = archive;
        cell.delegate = (id)self;
        [cell loadCell];
        return cell;
    } else {
        
        return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _tvArchives) {
        return 44;
    } else {
        if (indexPath.section == 0) {
            return 44 * self.record.reports.count + 34;
        } else {
            return [super tableView:tableView heightForRowAtIndexPath:indexPath];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.tableView) {
        return 10;
    } else {
        return 0.0001;
    }
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

#pragma mark - Appointment archive cell delegate

- (void)reviewArchive:(HealthyArchive *)archive {
    HealthyArchiveDetailTableViewController *tvcArchiveDetail = [[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchiveDetail"];
    tvcArchiveDetail.archiveId = archive.archiveId;
    [self.navigationController pushViewController:tvcArchiveDetail animated:YES];
}

#pragma mark - UI

- (void)configUI {
    if ([self.record.sex isEqualToString:@"男"]) {
        _imgMale.image = [UIImage imageNamed:@"accept_protocol"];
        _imgFemale.image = [UIImage imageNamed:@"disaccept_protocol"];
    } else {
        _imgMale.image = [UIImage imageNamed:@"disaccept_protocol"];
        _imgFemale.image = [UIImage imageNamed:@"accept_protocol"];
    }
    _lblBirth.text = [self.record.birthday substringToIndex:10];
    _lblOverdueTime.text = [self.record.lastEvlueTime substringToIndex:10];
    _txtRemark.text = self.record.remark;
    [_tvArchives reloadData];
}


@end
