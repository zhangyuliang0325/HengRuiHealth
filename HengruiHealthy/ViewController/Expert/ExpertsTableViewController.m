//
//  ExpertsTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertsTableViewController.h"

//#import "ExpertDetailTableViewController.h"
#import "ExpertDetailViewController.h"

#import "ExpertListTableViewCell.h"
#import "HomeExpertListHeader.h"
#import "ExpertSearchView.h"
#import "BlankPage.h"

#import "Expert.h"

#import "ExpertClient.h"

#import "MBPrograssManager.h"
#import <MJRefresh/MJRefresh.h>
#import <MJExtension.h>

@interface ExpertsTableViewController () <HomeExpertListHeaderDelegate, BlankPageDelegate, ExpertSearchDelegate> {
    NSMutableArray *_experts;
    ExpertType _type;
    BlankPage *_blank;
    int _pageNumber;
    NSString *_sort;
    NSString *_keyword;
}

@end

static int _limit = 15;

NSString *const EVALUESORTEXPERTLIST = @"Evaluate";
NSString *const PRICESORT1EXPERTLIST = @"ConsultPrice";
NSString *const APTITUDESORTEXPERTLIST = @"Grade";

@implementation ExpertsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)searchExpertsByKeyword:(NSString *)keyword sort:(NSString *)sort pageNumber:(int)pageNumber {
    [[ExpertClient shartInstance] searchExpertByKeyword:keyword sort:sort pageNumer:[NSString stringWithFormat:@"%d", pageNumber] limit:[NSString stringWithFormat:@"%d", _limit] handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *experts = [Expert mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            [_experts addObjectsFromArray:experts];
            [self endRefresh];
            [self.tableView reloadData];
        } else {
            [self.tableView.mj_header endRefreshing];
            [self.tableView.mj_footer endRefreshing];
            //            [MBPrograssManager showMessage:response OnView:self.tableView];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _experts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"ExpertListCell";
    ExpertListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.expert = _experts[indexPath.row];
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Expert *expert = _experts[indexPath.row];
    ExpertDetailViewController *tvcExpertDetail = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"vcExpertDetail"];
    tvcExpertDetail.expert = expert;
    [self.navigationController pushViewController:tvcExpertDetail animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeExpertListHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"HomeExpertListHeader" owner:self options:nil] lastObject];
    header.delegate = (id)self;
    header.type = _type;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

#pragma mark - Home Expert Header Delegate

- (void)findExpertByType:(ExpertType)type {
    _type = type;
    switch (type) {
        case reviewExpert:
            _sort = EVALUESORTEXPERTLIST;
            break;
        case priceExpert:
            _sort = PRICESORT1EXPERTLIST;
            break;
        case aptitudeExpert:
            _sort = APTITUDESORTEXPERTLIST;
            break;
        default:
            break;
    }
    [self searchExpertsByKeyword:_keyword sort:_sort pageNumber:_pageNumber];
}

#pragma mark - Blank page delegate

- (void)retry {
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Expert search delegate

- (void)searchExpert:(NSString *)keyword {
    _keyword = keyword;
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - UI

- (void)configUI {
    [self configSeachBar];
    
    [self addRefreshFooter];
    [self addRefreshHeader];
    [self.tableView.mj_header beginRefreshing];
    _experts = [NSMutableArray array];
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_pageNumber = 1;
        [ss->_experts removeAllObjects];
        [ss searchExpertsByKeyword:ss->_keyword sort:ss->_sort pageNumber:ss->_pageNumber];
    }];
}

- (void)addRefreshFooter {
    __weak typeof(self) ws = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_pageNumber ++;
        [ss searchExpertsByKeyword:ss->_keyword sort:ss->_sort pageNumber:ss->_pageNumber];
    }];
    [self.tableView.mj_footer setAutomaticallyHidden:YES];
}

- (void)endRefresh {
    if ([self.tableView.mj_header isRefreshing]) {
        [self.tableView.mj_header endRefreshing];
        if (_experts.count == 0) {
            [self showBlankPage];
        }
    } else {
        if (_experts.count < _pageNumber * _limit) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

- (void)showBlankPage {
    _blank = [[[NSBundle mainBundle] loadNibNamed:@"BlankPage" owner:self options:nil] lastObject];
    _blank.frame = self.tableView.bounds;
    _blank.delegate = (id)self;
    [self.tableView addSubview:_blank];
}

- (void)removeBlankPage {
    if ([self.tableView.subviews containsObject:_blank]) {
        [_blank removeFromSuperview];
    }
}

- (void)configSeachBar {
    ExpertSearchView *searchView = [[[NSBundle mainBundle] loadNibNamed:@"ExpertSearchView" owner:self options:nil] lastObject];
    searchView.delegate = self;
    searchView.frame = CGRectMake(50, 0, HRHtyScreenWidth - 50, 35);
    self.navigationItem.titleView = searchView;
}

@end
