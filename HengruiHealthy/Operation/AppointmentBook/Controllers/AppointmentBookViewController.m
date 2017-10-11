//
//  AppointmentBookViewController.m
//  HengruiHealthy
//
//  Created by Hengzhan on 2017/9/26.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentBookViewController.h"
#import "AppointmentBookCell.h"
#import "AppointmentService.h"
#import "AppointmentBook.h"

NSString *const cellID = @"AppointmentBookCellID";

@interface AppointmentBookViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *allButton;               //全部按钮
@property (weak, nonatomic) IBOutlet UIButton *goingOnButton;           //进行中按钮
@property (weak, nonatomic) IBOutlet UIButton *unPayButton;             //未付款按钮
@property (weak, nonatomic) IBOutlet UIButton *completeButton;          //已完成按钮
@property (weak, nonatomic) IBOutlet UITableView *contentTableView;     //内容tableView
@property (nonatomic,retain) NSMutableDictionary *params;               //请求接口的参数字典

@property (nonatomic,retain) NSMutableArray<AppointmentBook *> *books;  //请求后的model数据

@end

@implementation AppointmentBookViewController

#pragma mark lazy懒加载
-(NSMutableDictionary *)params{
    if (_params == nil) {
        _params = [NSMutableDictionary dictionary];
        _params[@"IdentityUserIdAssign"] = @"Id";
        _params[@"PageIndex"] = @"1";
        _params[@"QueryLimit"] = @"10";
        _params[@"IsEnd"] = nil;
        _params[@"IsPayment"] = nil;
    }
    return _params;
}

-(NSMutableArray<AppointmentBook *> *)books{
    if (_books == nil) {
        _books = [NSMutableArray array];
    }
    return _books;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
    [self loadData];
}

//初始化UI设置
-(void)setUpUI{
    self.title = @"预约记录";
    [self.contentTableView registerNib:[UINib nibWithNibName:@"AppointmentBookCell" bundle:nil] forCellReuseIdentifier:cellID];
    
}
//加载数据
-(void)loadData{
    [[AppointmentService shareInstance] getAppointmentBooks:self.params handler:^(NSArray<AppointmentBook *> *response, BOOL isSuccess) {
        if (isSuccess) {
            [self.books addObjectsFromArray:response];
            NSLog(@"%@",self);
        }
    }];
}

#pragma mark 按钮点击事件
//全部按钮点击事件
- (IBAction)allButtonClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self changeButtonState:sender];
}
//进行中按钮点击事件
- (IBAction)goingOnButtonClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self changeButtonState:sender];
}
//未付款按钮点击事件
- (IBAction)unPayedButtonClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self changeButtonState:sender];
}
//已完成按钮点击事件
- (IBAction)completeButtonClick:(UIButton *)sender {
    if (sender.selected) {
        return;
    }
    [self changeButtonState:sender];
}
//改变按钮点击状态
- (void)changeButtonState:(UIButton *)btn {
    self.allButton.selected = NO;
    self.goingOnButton.selected = NO;
    self.unPayButton.selected = NO;
    self.completeButton.selected = NO;
    btn.selected = YES;
}

#pragma mark TableView数据源和代理

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 433;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AppointmentBookCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    
    
    return cell;
}



@end
