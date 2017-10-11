//
//  ExpertReviewViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertReviewViewController.h"

#import "ExpertReplyTableViewCell.h"
#import "AttachReplyTableViewCell.h"

#import "AppointmentRemark.h"

#import "PersonClient.h"

#import "CheckStringManager.h"
#import <MJExtension.h>
@interface ExpertReviewViewController () <UITextViewDelegate, UITableViewDelegate, UITableViewDataSource> {
    
    __weak IBOutlet UILabel *_lblRecordTime;
    __weak IBOutlet UILabel *_lblDescription;
    __weak IBOutlet UILabel *_lblPatientName;
    __weak IBOutlet UITextView *_txtRemark;
    __weak IBOutlet UILabel *_lblRemark;
    __weak IBOutlet NSLayoutConstraint *_consButtom;
    __weak IBOutlet UITableView *_tvReplies;
    __weak IBOutlet UIView *_vwMessage;
    
    NSArray *_replies;
}

@end

@implementation ExpertReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self getExpertReview];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardAppeared:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHidden:) name:UIKeyboardWillHideNotification object:nil];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)getExpertReview {
    [[PersonClient shareInstance] getExpertReview:self.record.recordId handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            _replies = [AppointmentRemark mj_objectArrayWithKeyValuesArray:response];
            [_tvReplies reloadData];
        } else {
            
        }
    }];
}

- (void)saveReply {
//    AppointmentRemark *remark = [_replies lastObject];
    [[PersonClient shareInstance] saveExpertReview:nil appointmentId:self.record.recordId content:_txtRemark.text handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            [self getExpertReview];
        } else {
            
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForSend:(UIButton *)sender {
    [self saveReply];
    _lblRemark.text = @"回复";
    _txtRemark.text = @"";
    [_txtRemark resignFirstResponder];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_replies.count >= 2) {
        return 2;
    } else {
        return _replies.count;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _replies.count - 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        AppointmentRemark *expertReply = _replies[0];
        static NSString *expertCellIdentifier = @"ExpertReplyCell";
        ExpertReplyTableViewCell *expertCell = [tableView dequeueReusableCellWithIdentifier:expertCellIdentifier forIndexPath:indexPath];
        expertCell.reply = expertReply;
        expertCell.expert = self.record.expert;
        [expertCell loadCell];
        return expertCell;
    } else {
        AppointmentRemark *attachReply = _replies[indexPath.row + 1];
        static NSString *attachCellIdentifier = @"AttachReplyCell";
        if ([attachReply.remarkerType isEqualToString:@"患者"]) {
            AttachReplyTableViewCell *attachCell = [tableView dequeueReusableCellWithIdentifier:attachCellIdentifier forIndexPath:indexPath];
            attachCell.reply = attachReply;
            [attachCell loadCell];
            return attachCell;
        } else {
            AppointmentRemark *attachReply = _replies[indexPath.row + 1];
            static NSString *expertCellIdentifier = @"ExpertReplyCell";
            ExpertReplyTableViewCell *expertCell = [tableView dequeueReusableCellWithIdentifier:expertCellIdentifier forIndexPath:indexPath];
            expertCell.reply = attachReply;
            expertCell.expert = self.record.expert;
            [expertCell loadCell];
            return expertCell;
        }
        
        
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 114;
}

#pragma mark - Text view delegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView {
    _lblRemark.text = textView.text;
    if ([CheckStringManager checkBlankString:textView.text]) {
        _lblRemark.text = @" ";
    }
}

#pragma mark - UI 

- (void)configUI {
    if ([self.fromWhere isEqualToString:@"1"]) {
        _lblPatientName.text = self.record.patient.realName;
        _lblDescription.text = self.record.remark;
        _lblRecordTime.text = [self.record.createTime substringToIndex:10];
    } else {
        
    }
    
}

- (void)keyboardAppeared:(NSNotification *)notification {
    CGFloat keyboardHeight = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    _consButtom.constant = keyboardHeight;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setNeedsLayout];
    }];
}

- (void)keyboardHidden:(NSNotification *)notification {
    _consButtom.constant = 0;
    [UIView animateWithDuration:0.3 animations:^{
        [self.view setNeedsLayout];
    }];
}

@end
