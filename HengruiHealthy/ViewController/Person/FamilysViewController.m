//
//  FamilysViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "FamilysViewController.h"

#import "AddFamilyTableViewController.h"

#import "FamilysTableViewCell.h"
#import "CutFamily.h"

#import "Family.h"

#import "PersonClient.h"

#import "MBPrograssManager.h"
#import <MJExtension.h>

@interface FamilysViewController () <UITableViewDelegate, UITableViewDataSource, FamiliseCellDelegate, CutFamilyDelegate> {
    
    __weak IBOutlet UITableView *_tvFamily;
    
    NSMutableArray *_familys;
    Person *_person;
    Family *_own;
    Family *_currentFamily;
    CutFamily *_cutFamily;
}

@end

@implementation FamilysViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _cutFamily = [[[NSBundle mainBundle] loadNibNamed:@"CutFamily" owner:self options:nil] lastObject];
    [self.view addSubview:_cutFamily];
    _cutFamily.delegate = (id)self;
    [self getFamilys];
    [self obtainPersonInfo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getFamilys {
    [[PersonClient shareInstance] getFamilys:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *familys = [Family mj_objectArrayWithKeyValuesArray:response];
            if (_familys == nil) {
                _familys = [NSMutableArray array];
            }
            [_familys addObjectsFromArray:familys];
            [_tvFamily reloadData];
        } else {
            
        }
    }];
}

- (void)removeFamily:(Family *)family {
    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] deleteFamily:family.familyId handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [MBPrograssManager showMessage:@"移除家人成功" OnView:self.view];
            [_familys removeObject:family];
            [_tvFamily reloadData];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

- (void)obtainPersonInfo {
//    [MBPrograssManager showPrograssOnMainView];
    [[PersonClient shareInstance] obtainInfoWithHandler:^(id response, BOOL isSuccess) {
//        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            _person = [Person mj_objectWithKeyValues:response];
            if (_own == nil) {
                _own = [[Family alloc] init];
                _own.nickName = _person.realName;
                _own.person = _person;
                _own.isLogin = YES;
                _currentFamily = _own;
            }
            [_tvFamily reloadData];
        } else {
//            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}
- (IBAction)actionForAddFamily:(UIButton *)sender {
    AddFamilyTableViewController *tvcAddFamily = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcAddFamily"];
    [self.navigationController pushViewController:tvcAddFamily animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return _familys.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"FamilysCell";
    FamilysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    Family *family = nil;
    if (indexPath.section == 0) {
        family = _own;
    } else {
        family = _familys[indexPath.row];
    }
    cell.family = family;
    cell.delegate = (id)self;
    [cell loadCell];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

#pragma mark - Family cell delegate

- (void)selectedFamily:(Family *)family {
    _cutFamily.family = family;
    [_cutFamily hideDelegate:family == _own];
    [_cutFamily show];
}

#pragma mark - Cut family delegate

- (void)cutAccount:(Family *)family {
    _currentFamily.isLogin =  NO;
    family.isLogin = YES;
    _currentFamily = family;
    [_tvFamily reloadData];
    [[NSUserDefaults standardUserDefaults] setObject:family.person.personId forKey:kHRHtyUserId];
}

- (void)deleteFamily:(Family *)family {
    [self removeFamily:family];
}

@end
