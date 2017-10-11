//
//  HomeViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HomeViewController.h"

#import "ArchivesTableViewController.h"
#import "BloodPressureTableViewController.h"

#import "ArchivesCollectionViewCell.h"

#import "FileManager.h"
#import "SDCycleScrollViewManager.h"
#import <MJExtension.h>
@interface HomeViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    __weak IBOutlet UIView *_vwBanner;
    __weak IBOutlet UICollectionViewFlowLayout *_layoutArchive;
    __weak IBOutlet UICollectionView *_cvArchive;
    
    NSArray *_archives;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self queryArchivesFromPlist];
    [self configUI];
    [SDCycleScrollViewManager configCycleViewOnView:_vwBanner];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Collection view data source 

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdeintifier = @"archivesCellIdentifier";
    ArchivesCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdeintifier forIndexPath:indexPath];
    Archive *archive = _archives[indexPath.row];
    cell.archive = archive;
    [cell loadCell];
    return cell;
}

#pragma mark - Collection view delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
        {
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcFat"] animated:YES];
        }
            break;
        case 1:
        {
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcBloodSugar"] animated:YES];
        }
            break;
        case 2:
        {
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcSpo"] animated:YES];
        }
            break;
        case 3:
        {
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcWeight"] animated:YES];
        }
            break;
        case 4:
        {
            [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcBloodPressure"] animated:YES];
        }
            break;
        case 5:
        {
            ArchivesTableViewController *tvcArchives = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchives"];
            tvcArchives.fileName = ELECTROCARDIOURL;
            [self.navigationController pushViewController:tvcArchives animated:YES];
        }
            break;
        case 6:
        {
            ArchivesTableViewController *tvcArchives = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchives"];
            tvcArchives.fileName = ROUTINEURINEURL;
            [self.navigationController pushViewController:tvcArchives animated:YES];
        }
            break;
        case 7:
        {
            ArchivesTableViewController *tvcArchives = [[UIStoryboard storyboardWithName:@"Home" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchives"];
            tvcArchives.fileName = BLOODFATURL;
            [self.navigationController pushViewController:tvcArchives animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark - UI

- (void)configUI {
    _layoutArchive.itemSize = CGSizeMake(HRHtyScreenWidth / 4, (HRHtyScreenHeight - 114 - HRHtyScreenWidth * 3 / 4) / 2);
    _layoutArchive.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    _layoutArchive.minimumLineSpacing = 0;
    _layoutArchive.minimumInteritemSpacing = 0;
}

#pragma mark - Method

- (void)queryArchivesFromPlist {
    NSString * path = [FileManager openNativePlistFile:@"Archives"];
    _archives = [Archive mj_objectArrayWithFile:path];
}


@end
