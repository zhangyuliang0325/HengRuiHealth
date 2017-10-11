//
//  HealthyAdvicesTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/5.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyAdvicesTableViewController.h"

#import "HealthyAdviceDetailTableViewController.h"

#import "HealthyAdvicesTableViewCell.h"
#import "HDDateView.h"

#import "HealthyAdviceClient.h"

#import <MJRefresh/MJRefresh.h>
#import <MJExtension.h>
@interface HealthyAdvicesTableViewController () <HDDateViewDelegate, HealthyAdviceCellDelegate> {
    __weak IBOutlet HDDateView *_vwFrom;
    __weak IBOutlet HDDateView *_vwTo;
    
    NSMutableArray *_advices;
    int _page;
    
    NSString *_from;
    NSString *_to;
}

@end

static int _limit = 15;

@implementation HealthyAdvicesTableViewController

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    //self.hidesBottomBarWhenPushed = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"专家建议";
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)getHealthyAdvices {
    [[HealthyAdviceClient shareInstance] getHealthyAdvicesForUser:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId] page:[NSString stringWithFormat:@"%d", _page] limit:[NSString stringWithFormat:@"%d", _limit] min:_from max:_to handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *advices = [HealthyAdvice mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            if (_advices == nil) {
                _advices = [NSMutableArray array];
            }
            [_advices addObjectsFromArray:advices];
            [self.tableView reloadData];
        } else {
            
        }
        [self endRefresh];
    }];
}

- (void)readAdvice:(HealthyAdvice *)advice {
    [[HealthyAdviceClient shareInstance] readAdvices:advice.adviceId handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            advice.isRead = YES;
            [self.tableView reloadData];
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _advices.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HealthyAdvicesCell";
    HealthyAdvicesTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.advice = _advices[indexPath.section];
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 5;
    }
}

#pragma mark - Date view delegate

- (void)chooseDate:(NSDate *)date type:(HDDateViewType)type {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    switch (type) {
        case dateViewForm:
            _from = [[formatter stringFromDate:date] stringByAppendingString:@" 00:00:00"];
            break;
        case dateViewTo:
            _to = [[formatter stringFromDate:date] stringByAppendingString:@" 00:00:00"];
            break;
        default:
            break;
    }
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - Healthy advice cell delegate 

- (void)reviewAdvice:(HealthyAdvice *)advice {
    [self readAdvice:advice];
    HealthyAdviceDetailTableViewController *tvcHealthyAdviceDetail = [[UIStoryboard storyboardWithName:@"HealthyAdvice" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcHealthyAdviceDetail"];
    tvcHealthyAdviceDetail.advice = advice;
    [self.navigationController pushViewController:tvcHealthyAdviceDetail animated:YES];
}

#pragma mark - UI

- (void)configUI {
    _vwFrom.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"自%@", dateString];
    };
    _vwFrom.delegate = (id)self;
    
    _vwTo.formatDateString = ^NSString *(NSString *dateString) {
        return [NSString stringWithFormat:@"至%@", dateString];
    };
    _vwTo.delegate = (id)self;
    
    [self addRefreshFooter];
    [self addRefreshHeader];
    [self.tableView.mj_header beginRefreshing];
}

- (void)addRefreshHeader {
    __weak typeof(self) ws = self;
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_page = 1;
        [ss->_advices removeAllObjects];
        [ss getHealthyAdvices];
    }];
}

- (void)addRefreshFooter {
    __weak typeof(self) ws = self;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        __strong typeof(ws) ss = ws;
        ss->_page ++;
        [ss getHealthyAdvices];
    }];
    self.tableView.mj_footer.automaticallyHidden = YES;
}

- (void)endRefresh {
    if (self.tableView.mj_header.isRefreshing) {
        [self.tableView.mj_header endRefreshing];
        if (_advices.count == 0) {
            
        }
    } else {
        if (_page *_limit > _advices.count) {
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
        } else {
            [self.tableView.mj_footer endRefreshing];
        }
    }
}

@end
