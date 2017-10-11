//
//  HealthyArchiveListTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyArchiveListTableViewController.h"

#import "HealthyArchiveDetailTableViewController.h"

#import "HealthyArchiveListTableViewCell.h"
#import "HealthyArchiveListFooter.h"
#import "BlankHealthyArchiveList.h"
#import "HDDateView.h"

#import "ArchiveClient.h"

#import <MJRefresh/MJRefresh.h>
#import "MBPrograssManager.h"
#import <MJExtension.h>
@interface HealthyArchiveListTableViewController () <HealthyArchiveListCellDelegate, BlankHealthyArchiveListDelegate, HealthyArchiveListFootDelegate, HDDateViewDelegate> {
    
    __weak IBOutlet HDDateView *_vwDateFrom;
    __weak IBOutlet HDDateView *_vwDateTo;
    
    NSMutableArray *_healthyArchives;
    
    BlankHealthyArchiveList *_blankPage;
    NSInteger _pageNumber;
    NSInteger _limit;
    
    NSDate *_from;
    NSDate *_to;
    CGFloat _dateLead;
    CGFloat _codeLead;
}

@end

@implementation HealthyArchiveListTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self configCompont];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server


- (void)obtainArchiveListWithPageNumer:(NSInteger)pageNumber limit:(NSInteger)limit {
    NSString *userId = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId];
    NSString *number = [NSString stringWithFormat:@"%d", (int)pageNumber];
    NSString *min = [NSString stringWithFormat:@"%d", (int)limit];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy-MM-dd HH:ss"];
    NSString *from = nil;
    NSString *to = nil;
    if (_from != nil) {
        from = [format stringFromDate:_from];
    }
    if (_to != nil) {
        to = [format stringFromDate:_to];
    }
    [[ArchiveClient shareInstance] obtainArchiveListForUser:userId pageNumber:number limit:min from:from to:to handler:^(id response, BOOL isSuccess) {
        [self removeBlankPage];
        self.tableView.tableHeaderView.hidden = NO;
        if (isSuccess) {
            NSArray *jsons = response[@"Items"];
            NSArray *models = [HealthyArchive mj_objectArrayWithKeyValuesArray:jsons];
            [_healthyArchives addObjectsFromArray:models];
            [self endRefresh];
            [self.tableView reloadData];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
            if (_pageNumber > 1) {
                _pageNumber --;
            }
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _healthyArchives.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HealthyArchiveCellIdentifier";
    HealthyArchiveListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.archive = _healthyArchives[indexPath.row];
    cell.dateLead = _dateLead;
    cell.codeLead = _codeLead;
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate 

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark - Healthy archive cell delegate

- (void)reviewArchive:(HealthyArchive *)archive {
    HealthyArchiveDetailTableViewController *tvcArchiveDetail = [[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchiveDetail"];
    tvcArchiveDetail.archiveId = archive.archiveId;
    [self.navigationController pushViewController:tvcArchiveDetail animated:YES];
}

#pragma mark - Healthy archive footer delegate

- (void)addArchiveFooter {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAddArchive"] animated:YES];
}

#pragma mark - Blank archive delegate {

- (void)addArchiveBlank {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAddArchive"] animated:YES];
}

#pragma mark - Date view delegate

- (void)chooseDate:(NSDate *)date type:(HDDateViewType)type {
    switch (type) {
        case dateViewForm:
            _from = date;
            _dateLead = ((HRHtyScreenWidth - 1) / 2 - _vwDateFrom.textWidth) / 2;
            break;
        case dateViewTo:
            _to = date;
            _codeLead = ((HRHtyScreenWidth - 1) / 2 - _vwDateTo.textWidth) / 2;
            break;
    }
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UI

- (void)configUI {
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
//    self.tableView.estimatedRowHeight = 70;
    self.tableView.tableFooterView = [UIView new];
    [self addRefreshFooter];
    [self addRefreshHeader];
    [self.tableView.mj_header beginRefreshing];
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        [ss->_healthyArchives removeAllObjects];
        ss->_pageNumber = 1;
        [ss obtainArchiveListWithPageNumer:_pageNumber limit:_limit];
    }];
};

- (void)addRefreshFooter {
    __weak typeof(self) ws = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_pageNumber ++;
        [ss obtainArchiveListWithPageNumer:_pageNumber limit:_limit];
    }];
    [self.tableView.mj_footer setAutomaticallyHidden:YES];
}

- (void)endRefresh {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
        if (_healthyArchives.count == 0) {
            [self showBlankPage];
            self.tableView.tableHeaderView.hidden = YES;
            self.tableView.mj_footer.hidden = YES;
        }
    } else {
        if (_healthyArchives.count < (_pageNumber * _limit)) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

- (void)showBlankPage {
    if (_blankPage == nil) {
        CGFloat h = self.tableView.bounds.size.height - 5;
        _blankPage = [[[NSBundle mainBundle] loadNibNamed:@"BlankHealthyArchiveList" owner:self options:nil] lastObject];
        _blankPage.delegate = self;
        _blankPage.frame = CGRectMake(0, 5, HRHtyScreenWidth, h);
    }
    
    [self.tableView addSubview:_blankPage];
}

- (void)removeBlankPage {
    if ([self.tableView.subviews containsObject:_blankPage]) {
        [_blankPage removeFromSuperview];
    }
}

#pragma mark - Method

- (void)configCompont {
    _limit = 15;
    _healthyArchives = [NSMutableArray array];
    
    _dateLead = ((HRHtyScreenWidth - 1) / 2 - 116) / 2;
    _codeLead = ((HRHtyScreenWidth - 1) / 2 - 116) / 2;
    
    _vwDateFrom.type = dateViewForm;
    _vwDateFrom.delegate = (id)self;
    _vwDateFrom.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"自%@", dateString];
    };
    _vwDateTo.type = dateViewTo;
    _vwDateTo.delegate = (id)self;
    _vwDateTo.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"至%@", dateString];
    };
}

@end
