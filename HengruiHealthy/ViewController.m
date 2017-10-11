//
//  ViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ViewController.h"

#import "HDDateView.h"

#import "HDClick+CoreDataModel.h"

#import "HDCoreDataManager.h"

@protocol HDChartViewDelegate;

@interface ViewController ()  {
  
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    HDDateView *dateView = [[[NSBundle mainBundle] loadNibNamed:@"HDDateView" owner:self options:nil] lastObject];
    dateView.frame = CGRectMake(30, 30, 200, 50);
    [self.view addSubview:dateView];
    
   
    
}



@end
