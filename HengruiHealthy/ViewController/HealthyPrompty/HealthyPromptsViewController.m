//
//  HealthyPromptsViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyPromptsViewController.h"

#import "AddHealthyPromptViewController.h"

#import "HealthyPromptsTableViewCell.h"

#import "HealthyPrompt.h"

#import "PersonClient.h"

#import "PromptManager.h"
#import "MBPrograssManager.h"
#import <MJExtension.h>

@interface HealthyPromptsViewController () <UITableViewDelegate, UITableViewDataSource, AddHealthyPromptyDelegate, HealthyPromptCellDelegate> {
    NSArray *_items;
    PromptManager *_manager;
    __weak IBOutlet UIView *_vwBlank;
    __weak IBOutlet UITableView *_tvClicks;
    NSArray *_prompts;
    
    
}

@end

@implementation HealthyPromptsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [[PromptManager alloc] init];
    [self queryPrompts];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)removePrompt:(HealthyPrompt *)prompt {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] removePrompt:prompt.promptId handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            NSMutableArray *array = [NSMutableArray arrayWithArray:_prompts];
            [array removeObject:prompt];
            _prompts = array;
            [_tvClicks reloadData];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

- (void)savePrompt:(HealthyPrompt *)prompt enable:(BOOL)enable{
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] savePrompt:prompt.promptId title:prompt.title time:prompt.promptTime weekdays:prompt.weekdays ring:prompt.ring isVibrating:prompt.isVibrating ? @"true" : @"false" remark:prompt.remark enable:enable ? @"true" : @"false" handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            prompt.isEnable = enable;
            if (enable) {
                [_manager addNotification:prompt];
            } else {
                [_manager cancelNotificaiton:prompt];
            }
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

- (void)queryPrompts {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] queryPrompts:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            _vwBlank.hidden = YES;
            _prompts = [HealthyPrompt mj_objectArrayWithKeyValuesArray:response];
            [_manager mergeNotificaitons:_prompts];
            [_tvClicks reloadData];
        } else {
            
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForAddButton:(UIButton *)sender {
    AddHealthyPromptViewController  *vcAddHealthyPrompt = [[UIStoryboard storyboardWithName:@"HealthyPrompt" bundle:nil] instantiateViewControllerWithIdentifier:@"vcAddHealthyPrompt"];
    vcAddHealthyPrompt.isModify = NO;
//    vcAddHealthyPrompt.click = nil;
    vcAddHealthyPrompt.delegate = (id)self;
    [self.navigationController pushViewController:vcAddHealthyPrompt animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _prompts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HealthyPromptsCell";
    HealthyPromptsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.item = _prompts[indexPath.row];
    [cell loadCell];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    HealthyPrompt *click = _prompts[indexPath.row];
    AddHealthyPromptViewController  *vcAddHealthyPrompt = [[UIStoryboard storyboardWithName:@"HealthyPrompt" bundle:nil] instantiateViewControllerWithIdentifier:@"vcAddHealthyPrompt"];
    vcAddHealthyPrompt.isModify = YES;
    vcAddHealthyPrompt.prompt = click;
    vcAddHealthyPrompt.delegate = (id)self;
    [self.navigationController pushViewController:vcAddHealthyPrompt animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        HealthyPrompt *prompt = _prompts[indexPath.row];
        [self removePrompt:prompt];
    }
}

#pragma mark - Add prompt delegate

- (void)changedPrompts {
    [self queryPrompts];
}

#pragma mark - Healthy prompt cell delegate

- (void)openPrompt:(HealthyPrompt *)prompt isOpen:(BOOL)isOpen {
    [self savePrompt:prompt enable:isOpen];
}

#pragma mark - UI


@end
