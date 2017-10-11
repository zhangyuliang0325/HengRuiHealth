//
//  HealthyArchive.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@interface HealthyArchive : NSObject

//返回json

@property (copy, nonatomic) NSString *archiveId;
@property (copy, nonatomic) NSString *archiveCode;
@property (copy, nonatomic) NSString *Dalx_Bl;
@property (copy, nonatomic) NSString *Dalx_Yyfa;
@property (copy, nonatomic) NSString *Dalx_Yyjc;
@property (copy, nonatomic) NSString *userId;
@property (copy, nonatomic) NSString *recordTime;
@property (copy, nonatomic) NSString *remark;
@property (assign, nonatomic) BOOL Jczz_SfDydssjdn;
@property (assign, nonatomic) BOOL Jczz_SfFlkg;
@property (assign, nonatomic) BOOL Jczz_SfFzxh;
@property (assign, nonatomic) BOOL Jczz_SfXs;
@property (assign, nonatomic) BOOL Jczz_SfZhdh;
@property (assign, nonatomic) BOOL Sjbb_SfBmfx;
@property (assign, nonatomic) BOOL Sjbb_SfPfsr;
@property (assign, nonatomic) BOOL Sjbb_SfSzmm;
@property (assign, nonatomic) BOOL Wxh_SfSlmhxj;
@property (assign, nonatomic) BOOL Wxh_SfSzflr;
@property (assign, nonatomic) BOOL Wxh_SfTnbsb;
@property (assign, nonatomic) BOOL Wxh_SfTnbz;

//转换可用信息

@property (copy, nonatomic) NSString *baseInfo;
@property (strong, nonatomic) NSArray *hospitols;
@property (strong, nonatomic) NSArray *cases;
@property (strong, nonatomic) NSArray *drugs;
@property (copy, nonatomic) NSString *date;
@property (copy, nonatomic) NSString *time;
@property (assign, nonatomic) BOOL choosed;

@end
