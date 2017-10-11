//
//  SystemMessageTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "SystemMessageTableViewController.h"

#import "SystemMessageTableViewCell.h"

#import "SettingClient.h"
#import <MJExtension.h>
#import "ExpertReviewViewController.h"

@interface SystemMessageTableViewController ()<SystemMessageCellDelegate> {
    NSMutableArray *_messages;
}

@end

@implementation SystemMessageTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"系统消息";
    [self getMessages];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getMessages {
    [[SettingClient shareInstance] getMessages:^(id response, BOOL isSuccess) {
        NSLog(@"%@",response);
        if (isSuccess) {
            _messages = [SystemMessage mj_objectArrayWithKeyValuesArray:response];
            [self.tableView reloadData];
        } else {
            
        }
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _messages.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"SystemMessageCell";
    SystemMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    cell.message = _messages[indexPath.row];
    cell.checkBtn.tag = indexPath.row;
    [cell loadCell];
    return cell;
}

-(void)reviewMessage{
    
}

-(void)checkNowButtonClick:(UIButton *)button{
    ExpertReviewViewController *vcExpertReview = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"vcExpertReview"];
    vcExpertReview.fromWhere = @"2";
    vcExpertReview.message = _messages[button.tag];
    [self.navigationController pushViewController:vcExpertReview animated:YES];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return UITableViewAutomaticDimension;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    return 100;
//}

@end

