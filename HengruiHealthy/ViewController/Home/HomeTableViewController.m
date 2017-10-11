//
//  HomeTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/9.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HomeTableViewController.h"

#import "ExpertDetailViewController.h"
#import "AppointmentTableViewController.h"

#import "ArchivesActionSheetManager.h"

#import "HomeExpertListHeader.h"
#import "HomeExpertTableViewCell.h"

#import "HomeClient.h"

#import "MBPrograssManager.h"
#import "SDCycleScrollViewManager.h"
#import <MJExtension.h>
#import "HealthConsulteViewController.h"

@interface HomeTableViewController () <HomeExpertCellDelegate, HomeExpertListHeaderDelegate> {
    NSArray *_experts;
    NSString *_sort;
    ExpertType _type;
    __weak IBOutlet SDCycleScrollView *_vwBanner;
}

@property (nonatomic,retain) UIButton *kefuButton;                     //联系客服按钮
@property (nonatomic,retain) HomeExpertListHeader *sectionHeaderVi;    //区头视图

@end

NSString *const EVALUESORT = @"Evaluate";
NSString *const PRICESORT = @"ConsultPrice";
NSString *const APTITUDESORT = @"Grade";

@implementation HomeTableViewController

#pragma mark - 懒加载
//联系客服按钮懒加载
-(UIButton *)kefuButton{
    if (_kefuButton == nil) {
        _kefuButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _kefuButton.frame = CGRectMake(HRHtyScreenWidth - 95, HRHtyScreenHeight - 170, 70, 70);
        [_kefuButton setTitle:@"联系客服" forState:UIControlStateNormal];
        _kefuButton.titleLabel.font = [UIFont systemFontOfSize:15];
        _kefuButton.backgroundColor = [UIColor redColor];
        _kefuButton.layer.cornerRadius = 35;
        _kefuButton.layer.masksToBounds = YES;
        [_kefuButton addTarget:self action:@selector(kefuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _kefuButton;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Http server 

- (void)obtainExpertsForSortFor:(NSString *)sort {
    [MBPrograssManager showPrograssOnMainView];
    [[HomeClient shareInstance] obtanExpertListAtPage:@"1" limit:@"6" sort:sort handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            _experts = [Expert mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            [self.tableView reloadData];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Action
//健康报告
- (IBAction)actionForReportButton:(UIButton *)sender {
    ArchivesActionSheetManager *manager = [[ArchivesActionSheetManager alloc] initWithController:self];
    [manager showActionSheet];
}
//专家建议 HealthyAdvicesTableViewController
- (IBAction)actionForReviewButton:(UIButton *)sender {
    //[self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"HealthyAdvice" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcHealthyAdvice"] animated:YES];
    UITableViewController * healthyAdviceVC = [[UIStoryboard storyboardWithName:@"HealthyAdvice" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcHealthyAdvice"];
    healthyAdviceVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:healthyAdviceVC animated:YES];
}
//健康档案 HealthyArchiveViewController
- (IBAction)actionForArchivesButton:(UIButton *)sender {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"vcArchive"] animated:YES];
}
//服药记录
- (IBAction)actionForRecordButton:(UIButton *)sender {
    //[self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcMedicaitonRecords"] animated:YES];
    UIViewController * medicationRecordVC = [[UIStoryboard storyboardWithName:@"Medication" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcMedicaitonRecords"];
    medicationRecordVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:medicationRecordVC animated:YES];
}
//健康提醒
- (IBAction)actionForPromptButton:(UIButton *)sender {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"HealthyPrompt" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcHealthyPrompt"] animated:YES];
}
//健康咨询按钮点击事件
- (IBAction)jkzxButtonClick:(UIButton *)sender {
    HealthConsulteViewController * consulteVC = [[UIStoryboard storyboardWithName:@"Consulte" bundle:nil] instantiateViewControllerWithIdentifier:@"HealthConsulteViewControllerID"];
    consulteVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:consulteVC animated:YES];
}
//联系客服按钮点击事件
-(void)kefuButtonClick{
    NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"131****"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}

- (IBAction)actionForAllButton:(UIButton *)sender {
    [self.navigationController pushViewController:[[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcExpertList"] animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _experts.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *homeExpertCell = @"HomeExpertCell";
    HomeExpertTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:homeExpertCell forIndexPath:indexPath];
    Expert *expert = _experts[indexPath.row];
    cell.expert = expert;
    [cell loadCell];
    cell.delegate = self;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Expert *expert = _experts[indexPath.row];
    ExpertDetailViewController *tvcExpertDetail = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"vcExpertDetail"];
    tvcExpertDetail.expert = expert;
    tvcExpertDetail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tvcExpertDetail animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    HomeExpertListHeader *header = [[[NSBundle mainBundle] loadNibNamed:@"HomeExpertListHeader" owner:self options:nil] lastObject];
    header.delegate = self;
    header.type = _type;
    self.sectionHeaderVi = header;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 55;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 130;
}

#pragma mark - Home Expert Header Delegate

- (void)findExpertByType:(ExpertType)type {
    _type = type;
    switch (type) {
        case reviewExpert:
            _sort = EVALUESORT;
            break;
        case priceExpert:
            _sort = PRICESORT;
            break;
        case aptitudeExpert:
            _sort = APTITUDESORT;
            break;
        default:
            break;
    }
    [self obtainExpertsForSortFor:_sort];
}

#pragma mark - Home expert cell delegate

- (void)apointmentExpert:(Expert *)expert {
    AppointmentTableViewController *tvcAppointment = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAppointment"];
    tvcAppointment.expert = expert;
    [self.navigationController pushViewController:tvcAppointment animated:YES];
}

#pragma mark - UI

- (void)initUI {
    self.tableView.tableHeaderView.frame = CGRectMake(0, 0, HRHtyScreenWidth, [self calculateHeaderHeight]);
    [SDCycleScrollViewManager configCycleViewOnView:_vwBanner];
    [self.tableView addSubview:self.kefuButton];
}

#pragma mark - Method

- (void)loadData {
    _sort = EVALUESORT;
    [self obtainExpertsForSortFor:_sort];
}

- (CGFloat)calculateHeaderHeight {
    CGFloat advHeight = HRHtyScreenWidth * 164 / 375;
    CGFloat actionTopHeight = (HRHtyScreenWidth - 2) / 3 * 4 / 5;
    CGFloat actionBottomHeight = (HRHtyScreenWidth - 1) / 2 * 9 / 25;
    return advHeight + actionTopHeight + actionBottomHeight + 22 + 19;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    self.kefuButton.frame = CGRectMake(HRHtyScreenWidth - 95,scrollView.contentOffset.y + HRHtyScreenHeight - 170, 70, 70);
}

@end
