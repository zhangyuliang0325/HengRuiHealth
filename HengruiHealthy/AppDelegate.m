//
//  AppDelegate.m
//  HengruiHealthy
//
//  Created by Mac on 2017/5/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppDelegate.h"

#import "WXApi.h"
#import "HDLocalNotificaitonManager.h"
#import <AlipaySDK/AlipaySDK.h>
#import "PromptManager.h"
#import "PersonClient.h"
#import "MBPrograssManager.h"
#import <SignalR.h>                  //IM
#import <MJExtension.h>
#import "ExpertReviewViewController.h"
#import "Connecter.h"                //用来查询版本号

@interface AppDelegate () <UIAlertViewDelegate,SRConnectionDelegate>

//@property (nonatomic,retain) SRHubConnection *srHubCon;

@end


@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [WXApi registerApp:@"wx325277be0e9f1dcc"];
    [self checkVersion];
    [[HDLocalNotificaitonManager shareInstance] registNotificaiton];
    [self queryPrompts];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    //[self.srHubCon start];
//    [self.srHubCon stop:@100000];
//    [self.srHubCon start:[[SRAutoTransport alloc] init]];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    //NSLog(@"application.applicationState ---   %zd",application.applicationState);
    if (application.applicationState == UIApplicationStateInactive) {
        NSLog(@"Inactive");
    }else if (application.applicationState == UIApplicationStateActive) {
        NSLog(@"Active");
        NSString *notifiStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"textContent"];
        if ([notifiStr isEqualToString:@"健康-预约专家-回复"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预约专家回复" message:@"预约专家-回复" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            alert.tag = 10086;
            [alert show];
        }else if ([notifiStr isEqualToString:@"健康-预约专家-提醒"]) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"预约专家提醒" message:@"预约专家-提醒" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
        
    }else if (application.applicationState == UIApplicationStateBackground){
        NSLog(@"Background");
        // 当应用在后台收到本地通知时执行的跳转代码
        NSString *notifiStr = [[NSUserDefaults standardUserDefaults] objectForKey:@"textContent"];
        if ([notifiStr isEqualToString:@"健康-预约专家-回复"]) {
            ExpertReviewViewController *vcExpertReview = [[UIStoryboard storyboardWithName:@"Personal" bundle:nil] instantiateViewControllerWithIdentifier:@"vcExpertReview"];
            vcExpertReview.fromWhere = @"2";
            [[self topViewControll].navigationController pushViewController:vcExpertReview animated:YES];
        }else if ([notifiStr isEqualToString:@"健康-预约专家-提醒"]) {
            
        }else if ([notifiStr isEqualToString:@"健康-健康建议"]) {
            UITableViewController * healthyAdviceVC = [[UIStoryboard storyboardWithName:@"HealthyAdvice" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcHealthyAdvice"];
            healthyAdviceVC.hidesBottomBarWhenPushed = YES;
            [[self topViewControll].navigationController pushViewController:healthyAdviceVC animated:YES];
        }else if ([notifiStr isEqualToString:@"系统-帐户-提交用户意见"]) {
            
        }else if ([notifiStr isEqualToString:@"客服-系统-创建会话"]) {
            
        }else if ([notifiStr isEqualToString:@"客服-对话"]) {
            
        }else if ([notifiStr isEqualToString:@"广播-全部"]) {
            
        }else {
            NSLog(@"notificationTextContent 没有值");
        }
    }
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    } else {
        
        return [WXApi handleOpenURL:url delegate:(id)self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    } else {
        
        return [WXApi handleOpenURL:url delegate:(id)self];
    }
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    
    if ([url.host isEqualToString:@"safepay"]) {
        //跳转支付宝钱包进行支付，处理支付结果
        [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
            NSLog(@"result = %@",resultDic);
        }];
    } else {
        
        return [WXApi handleOpenURL:url delegate:(id)self];
    }
    return YES;
}


-(void) onReq:(BaseReq*)req
{
    if([req isKindOfClass:[GetMessageFromWXReq class]])
    {
        // 微信请求App提供内容， 需要app提供内容后使用sendRsp返回
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App提供内容"];
        NSString *strMsg = @"微信请求App提供内容，App要调用sendResp:GetMessageFromWXResp返回给微信";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alert.tag = 1000;
        [alert show];
    }
    else if([req isKindOfClass:[ShowMessageFromWXReq class]])
    {
        ShowMessageFromWXReq* temp = (ShowMessageFromWXReq*)req;
        WXMediaMessage *msg = temp.message;
        
        //显示微信传过来的内容
        WXAppExtendObject *obj = msg.mediaObject;
        
        NSString *strTitle = [NSString stringWithFormat:@"微信请求App显示内容"];
        NSString *strMsg = [NSString stringWithFormat:@"标题：%@ \n内容：%@ \n附带信息：%@ \n缩略图:%lu bytes\n\n", msg.title, msg.description, obj.extInfo, (unsigned long)msg.thumbData.length];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];    }
    else if([req isKindOfClass:[LaunchFromWXReq class]])
    {
        //从微信启动App
        NSString *strTitle = [NSString stringWithFormat:@"从微信启动"];
        NSString *strMsg = @"这是从微信启动的消息";
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
}

-(void) onResp:(BaseResp*)resp
{
    if([resp isKindOfClass:[SendMessageToWXResp class]])
    {
        NSString *strTitle = [NSString stringWithFormat:@"发送媒体消息结果"];
        NSString *strMsg = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:strTitle message:strMsg delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    } else if ([resp isKindOfClass:[PayResp class]]){
        PayResp*response=(PayResp*)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
            {
                UITabBarController *rootVC = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
                UINavigationController *selectVC = (UINavigationController *)rootVC.selectedViewController;
                UIViewController *topVC = selectVC.topViewController;
                if ([topVC isKindOfClass:NSClassFromString(@"PayTableViewController")] && [topVC respondsToSelector:NSSelectorFromString(@"openSuccessViewController")]) {
                    [topVC performSelector:NSSelectorFromString(@"openSuccessViewController")];
                }
            }
                break;
            default:
                NSLog(@"支付失败，retcode=%d",resp.errCode);
                break;
        }
    }

}

- (void)queryPrompts {
    [[PersonClient shareInstance] queryPrompts:^(id response, BOOL isSuccess) {
        if (isSuccess) {
//            _vwBlank.hidden = YES;
            NSArray *prompts = [HealthyPrompt mj_objectArrayWithKeyValuesArray:response];
            PromptManager *manager = [[PromptManager alloc] init];
            [manager mergeNotificaitons:prompts];
        } else {
            
        }
    }];
}

#pragma mark 初始化配置SingalR.
- (void)setUpSingalR {
    SRHubConnection *hubConnection = [SRHubConnection connectionWithURLString:[NSString stringWithFormat:@"%@signalr",BasePath]];
    [hubConnection addValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken] forHTTPHeaderField:@"Cookie"];
    [hubConnection setDelegate:self];
    SRHubProxy *chat = (SRHubProxy *)[hubConnection createHubProxy:@"messageHub"];
    [chat on:@"addMessage" perform:self selector:@selector(addMessage:)];
    [hubConnection setStarted:^{
        NSLog(@"SRConnection Started");
    }];
    //后台回复之后来到这里
    [hubConnection setReceived:^(NSDictionary *message) {
        NSLog(@"%@",message);
        NSArray *a = message[@"A"];
        if (a.count <= 0) {return;}
        NSDictionary *dict = [a objectAtIndex:0];
        NSDictionary *content = dict[@"Content"];
        NSString *messageType = content[@"MessageType"];
        NSString *textContent = content[@"TextContent"]; //预约专家回复
        [[NSUserDefaults standardUserDefaults] setObject:messageType forKey:@"textContent"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        //初始化本地推送的消息
        UILocalNotification *localNote = [[UILocalNotification alloc] init];
        localNote.alertBody = textContent;
        [[UIApplication sharedApplication] scheduleLocalNotification:localNote];
    }];
    [hubConnection setReconnecting:^{
        NSLog(@"SRConnection Reconnecting");
    }];
    [hubConnection setReconnected:^{
        NSLog(@"SRConnection Reconnected");
    }];
    [hubConnection setClosed:^{
        NSLog(@"SRConnection Closed");
    }];
    [hubConnection setError:^(NSError *error) {
        NSLog(@"SRConnection Error %@",error);
    }];
    [hubConnection start];
}

- (void)addMessage:(NSString *)message{
    
}

//获取栈顶的控制器
- (UIViewController *)topViewControll {
    UIViewController *resultVC;
    resultVC = [self topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}

- (UIViewController *)topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

//检测版本升级
-(void)checkVersion{
    NSDictionary *infoDict = [NSBundle mainBundle].infoDictionary;
    NSString *bundleVersion = [infoDict objectForKey:@"CFBundleShortVersionString"];
    CGFloat bundleNum = [self changeVersionNumber:bundleVersion];
    [[Connecter shareInstance] GET:@"http://itunes.apple.com/cn/lookup?id=1261666235" parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dicResponse = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        NSArray *results = dicResponse[@"results"];
        if (results.count > 0) {
            NSDictionary *resultDict  = results[0];
            NSString *currentVersion = resultDict[@"version"];
            CGFloat currentNum = [self changeVersionNumber:currentVersion];
            if (currentNum > bundleNum) {
                UIAlertView *alert = [[UIAlertView alloc] init];
                alert.tag = 10010;
                alert.title = @"通知";
                alert.message = @"有新的版本发布，是否前往更新？";
                [alert addButtonWithTitle:@"前往更新"];
                alert.delegate = self;
                [alert show];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}

//版本号转换
-(CGFloat)changeVersionNumber:(NSString *)versionNum{
    CGFloat vnum = 0.0;
    if (versionNum == nil) {
        return vnum;
    }
    NSArray *arr = [versionNum componentsSeparatedByString:@"."];
    if (arr.count > 2) {
        NSString *total = [NSString stringWithFormat:@"%@.%@%@",arr[0],arr[1],arr[2]];
        vnum = total.doubleValue;
        return vnum;
    } else {
        vnum = versionNum.doubleValue;
        return vnum;
    }
}

//UIAlertViewDelegate
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 10086) {
        
    }else if (alertView.tag == 10010) {
        if (buttonIndex == 0) {
            NSURL *url = [NSURL URLWithString:@"https://itunes.apple.com/cn/app/id1261666235"];
            [[UIApplication sharedApplication] openURL:url];
        } else {
            
        }
    }
}



@end
