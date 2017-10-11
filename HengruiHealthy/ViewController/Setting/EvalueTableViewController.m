//
//  EvalueTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "EvalueTableViewController.h"

#import "PersonClient.h"

#import "AlertManager.h"
#import "CheckStringManager.h"
#import "MBPrograssManager.h"

@interface EvalueTableViewController () <UITextViewDelegate> {
    
    __weak IBOutlet UILabel *_lblCount;
    __weak IBOutlet UIButton *_btnSubmit;
    __weak IBOutlet UILabel *_lblPleaseHolder;
    __weak IBOutlet UITextView *_txtEvalue;
}

@end

@implementation EvalueTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:_txtEvalue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)submitEvalueContent:(NSString *)content {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] evalueContent:content handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessageOnMainView:@"感谢您的宝贵意见，我们会越做越好"];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForSubmit:(UIButton *)sender {
    [self.view endEditing:YES];
    if ([self checkInfo]) {
        [self submitEvalueContent:_txtEvalue.text];
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.0001;
}

#pragma mark - Text view delegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _lblPleaseHolder.hidden = YES;
    } else {
        _lblPleaseHolder.hidden = NO;
    }
    NSLog(@"change");
    NSLog(@"content:%@, length:%lu", textView.text, (unsigned long)textView.text.length);
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if (textView.text.length - range.length + text.length > 200) {
        return NO;
    }
    if ([text isEqualToString:@"\n"] || [text isEqualToString:@"\br"]) {
        
    }
    NSLog(@"should");
    NSLog(@"content:%@, length:%lu", textView.text, (unsigned long)textView.text.length);
    return YES;
}

#pragma mark - Method

- (BOOL)checkInfo {
    if ([CheckStringManager checkBlankString:_txtEvalue.text]) {
        [MBPrograssManager showMessage:@"请输入您的宝贵意见" OnView:self.view];
        return NO;
    }
    return YES;
}

- (void)textViewDidChangeText:(NSNotification *)notification

{
    
    /**
     
     *  最大输入长度,中英文字符都按一个字符计算
     
     */
    
    static int kMaxLength = 200;
    
    
    
    UITextView *textView = (UITextView *)notification.object;
    
    NSString *toBeString = textView.text;
    
    // 获取键盘输入模式
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    
    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        UITextRange *selectedRange = [textView markedTextRange];
        
        //获取高亮选择部分
        
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        
        if (!position) {
            
            if (toBeString.length > kMaxLength) {
                
                // 截取子串
                
                textView.text = [toBeString substringToIndex:kMaxLength];
                
            }
            _lblCount.text = [NSString stringWithFormat:@"最多可输入%lu/200字", (unsigned long)textView.text.length];
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
            
            NSLog(@"11111111111111========      %@",position);
            
        }
        
    } else {
        
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length > kMaxLength) {
            
            // 截取子串
            
            textView.text = [toBeString substringToIndex:kMaxLength];
            
        }
        
    }
    
}

@end
