//
//  MedicationDetailTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MedicationDetailTableViewController.h"

#import <SDWebImage/UIImageView+WebCache.h>

@interface MedicationDetailTableViewController () {
    
    __weak IBOutlet UIImageView *_imgMedication;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UILabel *_lblSpec;
    __weak IBOutlet UILabel *_lblDosage;
    __weak IBOutlet UILabel *_lblCompany;
    __weak IBOutlet UILabel *_lblApproval;
    __weak IBOutlet UILabel *_lblProfile;
}

@end

@implementation MedicationDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 0.0001;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - UI

- (void)configUI {
    SDWebImageDownloader *downloader = [SDWebImageManager sharedManager].imageDownloader;
    [downloader setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken] forHTTPHeaderField:@"Cookie"];
    [downloader downloadImageWithURL:[NSURL URLWithString:self.medication.imageURL] options:SDWebImageDownloaderHandleCookies progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _imgMedication.image = image;
    }];
    _lblName.text = self.medication.goodsName;
    _lblSpec.text = [NSString stringWithFormat:@"规格: %@", self.medication.specification];
    _lblDosage.text = [NSString stringWithFormat:@"服用次数: %@", self.medication.dosage];
    _lblCompany.text = [NSString stringWithFormat:@"生产企业: %@", self.medication.company];
    _lblApproval.text = [NSString stringWithFormat:@"批准文号: %@", self.medication.approval];
    _lblProfile.text = self.medication.profile;
    [self.tableView reloadData];
}

@end
