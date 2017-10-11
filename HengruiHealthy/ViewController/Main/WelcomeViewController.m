//
//  WelcomeViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/2.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "WelcomeViewController.h"

#import "AppDelegate+StartManager.h"

#import "EAIntroViewManager.h"

@interface WelcomeViewController () <EAIntroDelegate> {
    
    __weak IBOutlet UIActivityIndicatorView *_indictor;
}

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self startController];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)autoLogin {
    
}

- (void)startController {
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSInteger startCount = [delegate fetchStartCount];
    if (startCount == 1) {
//        [EAIntroViewManager configEAIntroViewInView:self.view pages:[NSArray arrayWithObjects:@"http://pic.58pic.com/58pic/16/52/85/32n58PICV3T_1024.jpg", @"http://pic.58pic.com/58pic/14/10/63/26T58PICiwA_1024.jpg", @"http://pic.58pic.com/58pic/14/10/59/58PIC4458PICEXb_1024.jpg", @"http://pic.58pic.com/58pic/14/10/63/21758PICGc5_1024.jpg", @"http://pic.58pic.com/58pic/14/10/59/16n58PICyjE_1024.jpg", nil] delegate:self];
        [EAIntroViewManager configEAIntroViewInView:self.view pages:[NSArray arrayWithObjects:[UIImage imageNamed:@"guide1"], [UIImage imageNamed:@"guide2"], [UIImage imageNamed:@"guide3"], nil] delegate:self];
    } else {
        [self dismissSelf];
    }
}

- (void)dismissSelf {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}

#pragma mark - EAIntro delegate

- (void)introDidFinish:(EAIntroView *)introView wasSkipped:(BOOL)wasSkipped {
    [self dismissSelf];
}


@end
