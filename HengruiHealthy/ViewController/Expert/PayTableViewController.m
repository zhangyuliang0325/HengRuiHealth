//
//  PayTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PayTableViewController.h"

#import "PaySuccessViewController.h"

#import "HealthyArchive.h"

#import "ExpertClient.h"

#import "PersonClient.h"

#import "MBPrograssManager.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"

@interface PayTableViewController () {
    
    __weak IBOutlet UILabel *_lblLevel;
    __weak IBOutlet UILabel *_lblUtil;
    __weak IBOutlet UILabel *_lblDuties;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UIImageView *_imgAvatar;
    
    __weak IBOutlet UILabel *_lblPrice;
    __weak IBOutlet UIButton *_btnAlipay;
    __weak IBOutlet UIButton *_btnWechat;
    __weak IBOutlet UIView *_vwArchives;
    __weak IBOutlet UILabel *_lblBirth;
    __weak IBOutlet UILabel *_lblSex;
    __weak IBOutlet UILabel *_lblReply;
    __weak IBOutlet UITextView *_txtRemark;
    __weak IBOutlet UIButton *_btnPay;
    
    NSString *_pay;
    NSString *_orderCode;
    NSString *_alipayResult;
}

@end

@implementation PayTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)appointmentExpert {
    [MBPrograssManager showPrograssOnMainView];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
//    NSString *birth = [[formatter stringFromDate:self.birth] stringByAppendingString:@" 00:00:00"];
//    NSString *reply = [[formatter stringFromDate:self.reply] stringByAppendingString:@" 00:00:00"];
    NSString *birth = [self.birth stringByAppendingString:@" 00:00:00"];
    NSString *reply = [self.reply stringByAppendingString:@" 00:00:00"];

//    NSMutableString *archiveIds = nil;
//    if (_chooseArchives != nil && _chooseArchives.count != 0) {
//        archiveIds = [NSMutableString string];
//        for (int i = 0; i < _chooseArchives.count; i ++) {
//            HealthyArchive *archive = _chooseArchives[i];
//            [archiveIds appendFormat:@"%@;", archive.archiveCode];
//        }
//    }
//    if (archiveIds != nil) {
//        [archiveIds deleteCharactersInRange:NSMakeRange(archiveIds.length - 1, 1)];
//    }
    NSString *sex = self.sex;
    [[ExpertClient shartInstance] appointmentExpert:self.expert.expertId forUser:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId] archives:self.archiveIds birth:birth replyTime:reply sex:sex remark:self.remark pay:_pay handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            _orderCode = response[@"Id"];
            if ([response[@"Payment"][@"IsPayment"] boolValue]) {
                [self openSuccessViewController];
            } else {
                if ([_pay isEqualToString:@"wechatapp"]) {
                    PayReq *request = [[PayReq alloc] init];
                    request.partnerId = kHRHtyWcBID;
                    request.prepayId = response[@"Payment"][@"WeChatPaySign"][@"prepayId"];
                    request.package = @"Sign=WXPay";
                    request.nonceStr = response[@"Payment"][@"WeChatPaySign"][@"nonceStr"];
                    request.timeStamp = [response[@"Payment"][@"WeChatPaySign"][@"timeStamp"] intValue];
                    request.sign = response[@"Payment"][@"WeChatPaySign"][@"paySign"];
                    [WXApi sendReq:request];
                } else {
                    [[AlipaySDK defaultService] payOrder:response[@"Payment"][@"AlipaySign"] fromScheme:@"com.hengzhan.hengruihealthy.alipay" callback:^(NSDictionary *resultDic) {
                        NSInteger resultCode = [resultDic[@"resultStatus"] integerValue];
                        switch (resultCode) {
                            case 9000:
                            {
//                                NSData *aliData = [NSJSONSerialization dataWithJSONObject:resultDic[@"result"] options:NSJSONWritingPrettyPrinted error:nil];
//                                _alipayResult = [[NSString alloc] initWithData:aliData encoding:NSUTF8StringEncoding];
//                                _alipayResult = [_alipayResult stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//                                _alipayResult = [_alipayResult stringByReplacingOccurrencesOfString:@"\n" withString:@""];
//                                _alipayResult = [_alipayResult stringByReplacingOccurrencesOfString:@" " withString:@""];
                                _alipayResult = resultDic[@"result"];
                                [self openSuccessViewController];
                            }
                                break;
                            case 6004:
                            case 8000:
                                [MBPrograssManager showMessage:@"订单正在处理中" OnView:self.view];
                                break;
                            case 5000:
                                [MBPrograssManager showMessage:@"订单支付重复请求" OnView:self.view];
                                break;
                            case 6001:
                                [MBPrograssManager showMessage:@"订单取消支付" OnView:self.view];
                                break;
                            case 6002:
                                [MBPrograssManager showMessage:@"网络连接出错，请检查您的网络" OnView:self.view];
                                break;
                            case 4000:
                            default:
                                [MBPrograssManager showMessage:@"订单支付失败" OnView:self.view];
                                break;
                        }
                    }];
                }
            }
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}


#pragma mark - Action

- (IBAction)actionForAlipayButton:(UIButton *)sender {
    _btnAlipay.selected = YES;
    _btnWechat.selected = NO;
    _pay = @"alipay";
}

- (IBAction)actionForWechatButton:(UIButton *)sender {
    _btnWechat.selected = YES;
    _btnAlipay.selected = NO;
    _pay = @"wechatapp";
}

- (IBAction)actionForPayButton:(UIButton *)sender {
    [self appointmentExpert];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            if (self.archives.count == 0 || self.archives == nil || self.archives.count == 1) {
                return 44;
            } else {
                return (self.archives.count - 1) * 5 + self.archives.count * 18 + 16;
            }
        }
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.00001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else if (section == 3) {
        return 5;
    } else if (section == 4) {
        return 0.000001;
    } else {
        return 30;
    }
}

- (void)configUI {
    _pay = @"alipay";
    _lblSex.text = self.sex;
    _lblBirth.text = self.birth.length > 10 ? [self.birth substringToIndex:10] : self.birth;
    _lblReply.text = self.reply.length > 10 ? [self.reply substringToIndex:10] : self.reply;
    _txtRemark.text = self.remark;
    _lblName.text = self.expert.name;
    _lblDuties.text = self.expert.duties;
    _lblUtil.text = self.expert.util;
    _lblLevel.text = self.expert.level;
    _lblPrice.text = [NSString stringWithFormat:@"¥ %.2f", self.expert.price];
    SDWebImageDownloader *downloader = [SDWebImageManager sharedManager].imageDownloader;
    [downloader setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken]forHTTPHeaderField:@"Cookie"];
    [downloader downloadImageWithURL:[NSURL URLWithString:self.expert.avatar] options:SDWebImageDownloaderHandleCookies progress:nil completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _imgAvatar.image = image;
    }];
    CGFloat y = 8;
    for (int i = 0; i < self.archives.count; i ++) {
        UILabel *lblArchive = [[UILabel alloc] init];
        HealthyArchive *archive = self.archives[i];
        lblArchive.font = [UIFont systemFontOfSize:15.0f];
        lblArchive.textColor = [UIColor colorWithRed:97.0 / 255 green:97.0 / 255 blue:97.0 / 255 alpha:1];
        lblArchive.text = archive.archiveCode;
        [lblArchive sizeToFit];
        if (self.archives.count == 1) {
            lblArchive.frame = CGRectMake(HRHtyScreenWidth - 15 - lblArchive.bounds.size.width, 0, lblArchive.bounds.size.width, 44);
        } else {
            lblArchive.frame = CGRectMake(HRHtyScreenWidth - 15 - lblArchive.bounds.size.width, y, lblArchive.bounds.size.width, 18);
            y = y + 26;
        }
        [_vwArchives addSubview:lblArchive];
    }
}

- (void)openSuccessViewController {
    PaySuccessViewController *vcPaySuccess = [[UIStoryboard storyboardWithName:@"Expert" bundle:nil] instantiateViewControllerWithIdentifier:@"vcPaySuccess"];
    vcPaySuccess.code = _orderCode;
    [self.navigationController pushViewController:vcPaySuccess animated:YES];
    [[PersonClient shareInstance] queryPaymentState:_orderCode alipayResult:_alipayResult handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            
        } else {
            
        }
    }];
}

//-(void)onResp:(BaseResp*)resp{
//    if ([resp isKindOfClass:[PayResp class]]){
//        PayResp*response=(PayResp*)resp;
//        switch(response.errCode){
//            caseWXSuccess:
//                //服务器端查询支付通知或查询API返回的结果再提示成功
//                [self openSuccessViewController:_orderCode];
//                NSLog(@"支付成功");
//                break;
//            default:
//                NSLog(@"支付失败，retcode=%d",resp.errCode);
//                break;
//        }
//    }
//}


@end
