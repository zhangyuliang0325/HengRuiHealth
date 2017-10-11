//
//  HealthConsulteViewController.m
//  HengruiHealthy
//
//  Created by Hengzhan on 2017/10/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthConsulteViewController.h"

@interface HealthConsulteViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *videoButton;  //视频新闻按钮

@property (weak, nonatomic) IBOutlet UIButton *photoButton;  //图片新闻按钮

@property (weak, nonatomic) IBOutlet UITableView *contentTableView;



@end

@implementation HealthConsulteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    
}

-(void)setupUI{
    self.title = @"健康咨讯";
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    
    return cell;
}


@end
