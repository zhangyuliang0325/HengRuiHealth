//
//  HealthyAdviceDetailTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyAdviceDetailTableViewController.h"

#import "HealthyArchive.h"

@interface HealthyAdviceDetailTableViewController () {
    
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UILabel *_lblContent;
    __weak IBOutlet UIView *_vwArchives;
}

@end

@implementation HealthyAdviceDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate 

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (tableView == self.view) {
        if (section == 2) {
            return 30;
        } else {
            return 10;
        }
    }
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        return UITableViewAutomaticDimension;
    } else {
        if (indexPath.section == 1) {
            if (indexPath.row == 0) {
                if (self.advice.archives.count == 0 || self.advice.archives == nil || self.advice.archives.count == 1) {
                    return 44;
                } else {
                    return (self.advice.archives.count - 1) * 5 + self.advice.archives.count * 18 + 16;
                }
            }
        }
    }
    return 44;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - UI

- (void)configUI {
    _lblName.text = self.advice.expert.name;
    _lblTime.text = [self.advice.time substringToIndex:15];
    _lblContent.text = self.advice.content;
    CGFloat y = 8;
    for (int i = 0; i < self.advice.archives.count; i ++) {
        UILabel *lblArchive = [[UILabel alloc] init];
        HealthyArchive *archive = self.advice.archives[i];
        lblArchive.font = [UIFont systemFontOfSize:15.0f];
        lblArchive.textColor = [UIColor colorWithRed:141.0 / 255 green:141.0 / 255 blue:141.0 / 255 alpha:1];
        lblArchive.text = archive.archiveCode;
        [lblArchive sizeToFit];
        if (self.advice.archives.count == 1) {
            lblArchive.frame = CGRectMake(HRHtyScreenWidth - 15 - lblArchive.bounds.size.width, 0, lblArchive.bounds.size.width, 44);
        } else {
            lblArchive.frame = CGRectMake(HRHtyScreenWidth - 15 - lblArchive.bounds.size.width, y, lblArchive.bounds.size.width, 18);
            y = y + 26;
        }
        [_vwArchives addSubview:lblArchive];
    }
}

@end
