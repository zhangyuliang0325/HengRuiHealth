//
//  ArchivesActionSheetManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ArchivesActionSheetManager.h"

#import "FatTableViewController.h"
#import "BloodSugarTableViewController.h"
#import "SpoTableViewController.h"
#import "WeightTableViewController.h"
#import "BloodPressureTableViewController.h"
#import "ArchivesTableViewController.h"

@interface ArchivesActionSheetManager () {
    UIViewController *_vc;
    UINavigationController *_nav;
}

@end

@implementation ArchivesActionSheetManager

- (instancetype)initWithController:(UIViewController *)vc {
    if (self = [super init]) {
        _vc = vc;
        _nav = _vc.navigationController;
    }
    return self;
}

- (void)showActionSheet {

    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"选择健康报告" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *fatAction = [UIAlertAction actionWithTitle:@"体脂档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        FatTableViewController *tvcFat = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcFat"];
        [self pushViewController:tvcFat title:@"体脂档案"];
    }];
    [ac addAction:fatAction];
    
    UIAlertAction *bloodSugarAction = [UIAlertAction actionWithTitle:@"血糖档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BloodSugarTableViewController *tvcBloodSugar = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcBloodSugar"];
        [self pushViewController:tvcBloodSugar title:@"血糖档案"];
    }];
    [ac addAction:bloodSugarAction];
    
    UIAlertAction *spoAction = [UIAlertAction actionWithTitle:@"血氧档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        SpoTableViewController *tvcSpo = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcSpo"];
        [self pushViewController:tvcSpo title:@"血氧档案"];
    }];
    [ac addAction:spoAction];
    
    UIAlertAction *weightAction = [UIAlertAction actionWithTitle:@"体重档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WeightTableViewController *tvcWeight = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcWeight"];
        [self pushViewController:tvcWeight title:@"体重档案"];
    }];
    [ac addAction:weightAction];
    
    UIAlertAction *bloodPressureAction = [UIAlertAction actionWithTitle:@"血压档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        BloodPressureTableViewController *tvcBloodPressure = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcBloodPressure"];
        [self pushViewController:tvcBloodPressure title:@"血压档案"];
    }];
    [ac addAction:bloodPressureAction];
    
    UIAlertAction *electrocardioAction = [UIAlertAction actionWithTitle:@"心电档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ArchivesTableViewController *tvcArchives = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchives"];
        tvcArchives.fileName = ELECTROCARDIOURL;
        [self pushViewController:tvcArchives title:@"心电档案"];
    }];
    [ac addAction:electrocardioAction];
    
    UIAlertAction *routineurineAction = [UIAlertAction actionWithTitle:@"尿常规档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ArchivesTableViewController *tvcArchives = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchives"];
        tvcArchives.fileName = ROUTINEURINEURL;
        [self pushViewController:tvcArchives title:@"尿常规档案"];
    }];
    [ac addAction:routineurineAction];
    
    UIAlertAction *bloodFatAction = [UIAlertAction actionWithTitle:@"血脂档案" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        ArchivesTableViewController *tvcArchives = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchives"];
        tvcArchives.fileName = BLOODFATURL;
        [self pushViewController:tvcArchives title:@"血脂档案"];
    }];
    [ac addAction:bloodFatAction];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [ac addAction:cancelAction];
    
    [_vc presentViewController:ac animated:YES completion:nil];
}

- (void)pushViewController:(UIViewController *)vc title:(NSString *)title {
    vc.title = title;
    
    if (![_vc isKindOfClass:NSClassFromString(@"HomeTableViewController")]) {
        
        
        NSMutableArray *mCtrls = [NSMutableArray arrayWithArray:_nav.childViewControllers];
        [mCtrls replaceObjectAtIndex:mCtrls.count - 1 withObject:vc];
        [_nav setViewControllers:mCtrls];
        [_vc.view removeFromSuperview];
        [_vc removeFromParentViewController];
        _nav.navigationItem.backBarButtonItem = nil;
        _vc.view = nil;
        _vc = nil;
    } else {
        [_nav pushViewController:vc animated:YES];
    }
}


@end
