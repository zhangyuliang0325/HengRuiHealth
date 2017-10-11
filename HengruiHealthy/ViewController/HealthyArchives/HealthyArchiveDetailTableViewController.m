//
//  HealthyArchiveDetailTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/15.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyArchiveDetailTableViewController.h"

#import "ArchiveDetailPhotoTableViewCell.h"

#import "HealthyArchive.h"

#import "ArchiveClient.h"

#import "MBPrograssManager.h"
#import "CheckStringManager.h"
#import <MJExtension.h>

@interface HealthyArchiveDetailTableViewController () {
    
    __weak IBOutlet UILabel *_lblCode;
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UILabel *_lblInfo;
    __weak IBOutlet UITextView *_txtRemark;
    
    HealthyArchive *_archive;
    
    CGFloat _section2Height;
    CGFloat _section3Height;
    CGFloat _hospitalTitleHeight;
    CGFloat _hospitalPhotoHeight;
    CGFloat _caseTitleHeight;
    CGFloat _casePhotoHeight;
    CGFloat _drugTitleHeight;
    CGFloat _drugPhotoHeight;
}
@end

@implementation HealthyArchiveDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self obtainArchiveDetail];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Http server

- (void)obtainArchiveDetail {
    [MBPrograssManager showPrograssOnMainView];
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId];
    [[ArchiveClient shareInstance] obtainArchiveDetail:self.archiveId forUser:userId handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            _archive = [HealthyArchive mj_objectWithKeyValues:response];
            [self configUIInfo];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Table view data source 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_archive == nil) {
        return 0;
    }
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_archive == nil) {
        return 0;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 3) {
        
        switch (indexPath.row) {
            case 1:
            {
                ArchiveDetailPhotoTableViewCell *archiveCell =(ArchiveDetailPhotoTableViewCell *)cell;
                archiveCell.photos = _archive.hospitols;
                [archiveCell loadCell];
            }
                break;
            case 3:
            {
                ArchiveDetailPhotoTableViewCell *archiveCell =(ArchiveDetailPhotoTableViewCell *)cell;
                archiveCell.photos = _archive.cases;
                [archiveCell loadCell];
            }
                break;
            case 5:
            {
                ArchiveDetailPhotoTableViewCell *archiveCell =(ArchiveDetailPhotoTableViewCell *)cell;
                archiveCell.photos = _archive.drugs;
                [archiveCell loadCell];
            }
                break;
            default:
                break;
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
        {
            return 44;
        }
            break;
        case 1:
        {
            return _section2Height;
        }
            break;
        case 2:
        {
            return _section3Height;
        }
            break;
        case 3:
        {
            switch (indexPath.row) {
                case 0:
                {
                    return _hospitalTitleHeight;
                }
                    break;
                case 1:
                {
                    return _hospitalPhotoHeight;
                }
                    break;
                case 2:
                {
                    return _caseTitleHeight;
                }
                    break;
                case 3:
                {
                    return _casePhotoHeight;
                }
                    break;
                case 4:
                {
                    return _drugTitleHeight;
                }
                    break;
                case 5:
                {
                    return _drugPhotoHeight;
                }
                    break;
            }
        }
            break;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
        {
            return 5;
        }
            break;
        case 1:
        {
            if (_section2Height != 0) {
                return 10;
            } else {
                return 0.0001;
            }
        }
            break;
        case 2:
        {
            if (_section3Height != 0) {
                return 5;
            } else {
                return 0.0001;
            }
        }
            break;
        case 3:
        {
            if (_archive.hospitols != nil && _archive.hospitols.count != 0 &&_archive.cases != nil && _archive.cases.count != 0 && _archive.drugs != nil && _archive.drugs.count != 0) {
                return 10;
            } else {
                return 0.0001;
            }
        }
            break;
    }
    return [super tableView:tableView heightForHeaderInSection:section];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0001;
    
}

#pragma mark - Method

- (void)configUIInfo {
    if (_archive == nil) {
        return;
    }
    
    if ([CheckStringManager checkBlankString:_archive.baseInfo]) {
        _section2Height = 0;
    } else {
        _lblInfo.text = [NSString stringWithFormat:@"       %@", _archive.baseInfo];
        [_lblInfo sizeToFit];
        _section2Height = 45 + _lblInfo.bounds.size.height;
    }
    
    if ([CheckStringManager checkBlankString:_archive.remark]) {
        _section3Height = 0;
    } else {
        
        _section3Height = 105;
    }
    
    if (_archive.hospitols == nil || _archive.hospitols.count == 0) {
        _hospitalTitleHeight = 0;
        _hospitalPhotoHeight = 0;
    } else {
        _hospitalTitleHeight = 44;
        _hospitalPhotoHeight = 76;
    }
    
    if (_archive.cases == nil || _archive.cases.count == 0) {
        _casePhotoHeight = 0;
        _caseTitleHeight = 0;
    } else {
        _caseTitleHeight = 44;
        _casePhotoHeight = 76;
    }
    
    if (_archive.drugs == nil ||_archive.drugs.count == 0) {
        _drugTitleHeight = 0;
        _drugPhotoHeight = 0;
    } else {
        _drugTitleHeight = 44;
        _drugPhotoHeight = 76;
    }
    
    [self.tableView reloadData];
    
    _lblTime.text = [NSString stringWithFormat:@"%@ %@", _archive.date, _archive.time];
    _lblCode.text = _archive.archiveCode;
    _lblInfo.text = [NSString stringWithFormat:@"       %@", _archive.baseInfo];
    _txtRemark.text = _archive.remark;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        _txtRemark.contentOffset = CGPointMake(0, 0);
    });
}

@end
