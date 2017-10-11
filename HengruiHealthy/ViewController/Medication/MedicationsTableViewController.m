//
//  MedicationsTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "MedicationsTableViewController.h"

#import "MedicationDetailTableViewController.h"
#import "AddMedicationsViewController.h"

#import "MedictionsTableViewCell.h"
#import "BlankHealthyArchiveList.h"

#import "MedicaitonClient.h"

#import <MJRefresh/MJRefresh.h>
#import "MBPrograssManager.h"
#import <MJExtension.h>
@interface MedicationsTableViewController () <UISearchBarDelegate, MedicationCellDelegate> {
   
    __weak IBOutlet UISearchBar *_searchBar;
    
    BlankHealthyArchiveList *_blankPage;
    NSMutableArray *_medications;
    NSMutableArray *_choosedMedications;
    int _page;
}

@end

int const _limit = 15;

@implementation MedicationsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server 

- (void)getMedications {
    [[MedicaitonClient shareInstance] getMedication:_searchBar.text page:[NSString stringWithFormat:@"%d", _page] limit:[NSString stringWithFormat:@"%d", _limit] handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *medications = [Medication mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            if (_medications == nil) {
                _medications = [NSMutableArray array];
            }
            [_medications addObjectsFromArray:medications];
            [self.tableView reloadData];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
        [self endRefresh];
    }];
}

#pragma mark - Action

- (IBAction)actionForSaveButton:(UIBarButtonItem *)sender {
    if ([self.delegate respondsToSelector:@selector(saveMeidcations:)]) {
        [self.delegate saveMeidcations:_choosedMedications];
    }
    [self.navigationController popViewControllerAnimated:YES];
//    AddMedicationsViewController *vcAddMedications = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"vcAddMedications"];
//    vcAddMedications.medications = _choosedMedications;
//    [self.navigationController pushViewController:vcAddMedications animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _medications.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"MedicationsCell";
    MedictionsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.medication = _medications[indexPath.row];
    cell.delegete = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

#pragma mark - Search bar delegate

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Medication cell delegate

- (void)chooseMedication:(Medication *)medication withState:(BOOL)state{
    if (_choosedMedications == nil) {
        _choosedMedications = [NSMutableArray array];
    }
    medication.isChoosed = state;
    if (state) {
        if (![_choosedMedications containsObject:medication]) {
            [_choosedMedications addObject:medication];
        }
    } else {
        if ([_choosedMedications containsObject:medication]) {
            [_choosedMedications removeObject:medication];
        }
    }
}

- (void)reviewMedication:(Medication *)medication {
    MedicationDetailTableViewController *tvcMedicationDetail = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcMedicationDetail"];
    tvcMedicationDetail.medication = medication;
    [self.navigationController pushViewController:tvcMedicationDetail animated:YES];
}

#pragma mark - UI

- (void)configUI {
    [self addRefreshFooter];
    [self addRefreshHeader];
    [self.tableView.mj_header beginRefreshing];
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(ws) ss = self;
        [ss->_medications removeAllObjects];
        ss->_page = 1;
        [ss getMedications];
    }];
}

- (void)addRefreshFooter {
    __weak typeof(self) ws = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_page ++;
        [ss getMedications];
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
}

- (void)endRefresh {
    [self removeBlankPage];
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
        if (_medications.count == 0) {
            [self showBlankPage];
            self.tableView.mj_footer.hidden = YES;
        }
    } else {
        if (_medications.count < _page * _limit) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

- (void)showBlankPage {
    if (_blankPage == nil) {
        _blankPage = [[[NSBundle mainBundle] loadNibNamed:@"BlankHealthyArchiveList" owner:self options:nil] lastObject];
        _blankPage.title = nil;
        _blankPage.message = nil;
        _blankPage.isHideMessage = YES;
        _blankPage.isHideButton = YES;
        _blankPage.frame = CGRectMake(0, 5, HRHtyScreenWidth, self.tableView.bounds.size.height);
    }
    
    [self.tableView addSubview:_blankPage];
}

- (void)removeBlankPage {
    if ([self.tableView.subviews containsObject:_blankPage]) {
        [_blankPage removeFromSuperview];
    }
}

#pragma mark - Method

@end
