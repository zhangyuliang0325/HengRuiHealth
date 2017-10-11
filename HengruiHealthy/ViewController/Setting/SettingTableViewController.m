//
//  SettingTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/23.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "SettingTableViewController.h"

#import "WXApi.h"
#import "MBPrograssManager.h"

#import "SettingClient.h"

@interface SettingTableViewController () {
    
    __weak IBOutlet UIView *_vwnew;
}

@end

@implementation SettingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getMessageCount];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)checkVersion {
    [MBPrograssManager showPrograssOnMainView];
   NSString *currentVersion = [NSBundle mainBundle].infoDictionary[@"CFBundleShortVersionString"];
    NSString *url = @"https://itunes.apple.com/lookup?id=1261666235";
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
       dispatch_async(dispatch_get_main_queue(), ^{
           [MBPrograssManager hidePrograssFromMainView];
           if (error) {
               [self presentAlertWithVersion:currentVersion message:nil update:NO trackUrl:nil];
           } else {
               NSDictionary *responseObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
               NSArray *resultArr = responseObject[@"results"];
               if (resultArr.count > 0) {
                   NSDictionary *resultsDict = resultArr.firstObject;
                   NSString *appStoreVersion = resultsDict[@"version"];
                   NSString *trackViewUrl = resultsDict[@"trackViewUrl"];
                   if ([appStoreVersion compare:currentVersion options:NSNumericSearch] == NSOrderedDescending) {
                       NSString *message = [NSString stringWithFormat:@"有更新版本 v%@", appStoreVersion];
                       [self presentAlertWithVersion:currentVersion message:message update:YES trackUrl:trackViewUrl];
                   } else {
                       [self presentAlertWithVersion:currentVersion message:nil update:NO trackUrl:nil];
                   }
               } else {
                   [self presentAlertWithVersion:currentVersion message:nil update:NO trackUrl:nil];
               }
           }

       });
    }];
    [task resume];
}

- (void)getMessageCount {
    [[SettingClient shareInstance] getMessageCount:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            if ([response integerValue] != 0) {
                _vwnew.hidden = NO;
            } else {
                _vwnew.hidden = YES;
            }
        }
    }];
}

- (void)presentAlertWithVersion:(NSString *)currentVersion message:(NSString *)message update:(BOOL)hasNew trackUrl:(NSString *)trackViewUrl {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:[NSString stringWithFormat:@"当前版本 v%@", currentVersion] message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:cancel];
    if (hasNew) {
        UIAlertAction *update = [UIAlertAction actionWithTitle:@"去更新" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:trackViewUrl]];
        }];
        [ac addAction:update];
    }
    [self presentViewController:ac animated:YES completion:nil];

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        [self sendLinkContent];
    } else if (indexPath.section == 2) {
        [self checkVersion];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01;
}

- (void) sendLinkContent
{
    WXMediaMessage *message = [WXMediaMessage message];
    message.title = @"您的移动健康管家【恒瑞健康】";
    message.description = @"软件可展示您线下测量的血压、血脂、血糖、血氧、体脂、体重、尿常规、心电数据。随时随地了解自己的身体情况。";
    [message setThumbImage:[UIImage imageNamed:@"share_icon"]];
    
    WXWebpageObject *ext = [WXWebpageObject object];
    ext.webpageUrl = @"http://www.hengzhankj.com/content/mobile/download.html";
    
    message.mediaObject = ext;
    
    SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
    req.bText = NO;
    req.message = message;
    req.scene = WXSceneSession;
    
    [WXApi sendReq:req];
}

@end
