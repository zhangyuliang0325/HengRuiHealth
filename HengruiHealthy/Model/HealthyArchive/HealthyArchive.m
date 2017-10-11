//
//  HealthyArchive.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/16.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "HealthyArchive.h"

//#import <MJExtension/MJExtension.h>

@interface HealthyArchive () {
    NSMutableString *_mStr;
    NSMutableArray *_mHospital;
    NSMutableArray *_mCase;
    NSMutableArray *_mDrug;
}

@end


@implementation HealthyArchive

- (instancetype)init {
    if (self = [super init]) {
        _mStr = [NSMutableString string];
    }
    return self;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"archiveId":@"Id",
             @"archiveCode":@"FriendlyId",
             @"Dalx_Bl":@"Dalx_Bl",
             @"Dalx_Yyfa":@"Dalx_Yyfa",
             @"Dalx_Yyjc":@"Dalx_Yyjc",
             @"userId":@"UserId",
             @"recordTime":@"RecordTime",
             @"remark":@"Remark",
             @"Jczz_SfDydssjd":@"Jczz_SfDydssjd",
             @"Jczz_SfFlkg":@"Jczz_SfFlkg",
             @"Jczz_SfFzxh":@"Jczz_SfFzxh",
             @"Jczz_SfXs":@"Jczz_SfXs",
             @"Jczz_SfZhdh":@"Jczz_SfZhdh",
             @"Sjbb_SfBmfx":@"Sjbb_SfBmfx",
             @"Sjbb_SfPfsr":@"Sjbb_SfPfsr",
             @"Sjbb_SfSzmm":@"Sjbb_SfSzmm",
             @"Wxh_SfSlmhxj":@"Wxh_SfSlmhxj",
             @"Wxh_SfSzflr":@"Wxh_SfSzflr",
             @"Wxh_SfTnbsb":@"Wxh_SfTnbsb",
             @"Wxh_SfTnbz":@"Wxh_SfTnbz"
             };
}

#pragma mark - Setter

- (void)setDalx_Bl:(NSString *)Dalx_Bl {
    _Dalx_Bl = Dalx_Bl;
    if (_mCase == nil) {
        _mCase = [NSMutableArray array];
    }
    if ([Dalx_Bl containsString:@";"]) {
        NSArray *urls = [Dalx_Bl componentsSeparatedByString:@";"];
        [urls enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_mCase addObject:[NSString stringWithFormat:@"%@%@", BasePath, obj]];
        }];
    } else {
        [_mCase addObject:[NSString stringWithFormat:@"%@%@", BasePath, Dalx_Bl]];
    }
}

- (void)setDalx_Yyfa:(NSString *)Dalx_Yyfa {
    _Dalx_Yyfa = Dalx_Yyfa;
    if (_mDrug == nil) {
        _mDrug = [NSMutableArray array];
    }
    if ([Dalx_Yyfa containsString:@";"]) {
        NSArray *urls = [Dalx_Yyfa componentsSeparatedByString:@";"];
        [urls enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_mDrug addObject:[NSString stringWithFormat:@"%@%@", BasePath, obj]];
        }];
    } else {
        [_mDrug addObject:[NSString stringWithFormat:@"%@%@", BasePath, Dalx_Yyfa]];
    }
}

- (void)setDalx_Yyjc:(NSString *)Dalx_Yyjc {
    _Dalx_Yyjc = Dalx_Yyjc;
    if (_mHospital == nil) {
        _mHospital = [NSMutableArray array];
    }
    if ([Dalx_Yyjc containsString:@";"]) {
        NSArray *urls = [Dalx_Yyjc componentsSeparatedByString:@";"];
        [urls enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_mHospital addObject:[NSString stringWithFormat:@"%@%@", BasePath, obj]];
        }];
    } else {
        [_mHospital addObject:[NSString stringWithFormat:@"%@%@", BasePath, Dalx_Yyjc]];
    }
}

- (void)setJczz_SfXs:(BOOL)Jczz_SfXs {
    _Jczz_SfXs = Jczz_SfXs;
    if (Jczz_SfXs) {
        [_mStr appendString:@"消瘦; "];
    }
}

- (void)setJczz_SfFlkg:(BOOL)Jczz_SfFlkg {
    _Jczz_SfFlkg = Jczz_SfFlkg;
    if (Jczz_SfFlkg) {
        [_mStr appendString:@"乏力、口干（苦、异味）; "];
    }
}

- (void)setJczz_SfFzxh:(BOOL)Jczz_SfFzxh {
    _Jczz_SfFzxh = Jczz_SfFzxh;
    if (Jczz_SfFzxh) {
        [_mStr appendString:@"烦躁心慌; "];
    }
}

- (void)setJczz_SfZhdh:(BOOL)Jczz_SfZhdh {
    _Jczz_SfZhdh = Jczz_SfZhdh;
    if (Jczz_SfZhdh) {
        [_mStr appendString:@"自汗盗汗; "];
    }
}

- (void)setJczz_SfDydssjdn:(BOOL)Jczz_SfDydssjdn {
    _Jczz_SfDydssjdn = Jczz_SfDydssjdn;
    if (Jczz_SfDydssjdn) {
        [_mStr appendString:@"多饮、多食、善饥、多尿; "];
    }
}

- (void)setSjbb_SfBmfx:(BOOL)Sjbb_SfBmfx {
    _Sjbb_SfBmfx = Sjbb_SfBmfx;
    if (Sjbb_SfBmfx) {
       [_mStr appendString:@"便秘、腹泻、便秘腹泻交替; "];
    }
}

- (void)setSjbb_SfPfsr:(BOOL)Sjbb_SfPfsr {
    _Sjbb_SfPfsr = Sjbb_SfPfsr;
    if (Sjbb_SfPfsr) {
       [_mStr appendString:@"皮肤瘙痒、蚁爬感 ; "];
    }
}

- (void)setSjbb_SfSzmm:(BOOL)Sjbb_SfSzmm {
    _Sjbb_SfSzmm = Sjbb_SfSzmm;
    if (Sjbb_SfSzmm) {
        [_mStr appendString:@"手足麻木、疼痛（针刺感）无知觉、踩异物感、手套、袜套感; "];
    }
}

- (void)setWxh_SfTnbz:(BOOL)Wxh_SfTnbz {
    _Wxh_SfTnbz = Wxh_SfTnbz;
    if (Wxh_SfTnbz) {
        [_mStr appendString:@"糖尿病足; "];
    }
}

- (void)setWxh_SfSzflr:(BOOL)Wxh_SfSzflr {
    _Wxh_SfSzflr = Wxh_SfSzflr;
    if (Wxh_SfSzflr) {
        [_mStr appendString:@"手足发凉/热; "];
    }
}

- (void)setWxh_SfTnbsb:(BOOL)Wxh_SfTnbsb {
    _Wxh_SfTnbsb = Wxh_SfTnbsb;
    if (Wxh_SfTnbsb) {
        [_mStr appendString:@"糖尿病肾病 ; "];
    }
}

- (void)setWxh_SfSlmhxj:(BOOL)Wxh_SfSlmhxj {
    _Wxh_SfSlmhxj = Wxh_SfSlmhxj;
    if (Wxh_SfSlmhxj) {
        [_mStr appendString:@"视力模糊、下降  （眼底、视网膜、白内障）; "];
    }
}

#pragma mark - Getter

- (NSArray *)hospitols {
    return _mHospital;
}

- (NSArray *)cases {
    return _mCase;
}

- (NSArray *)drugs {
    return _mDrug;
}

- (NSString *)baseInfo {
    if (_mStr.length != 0) {
        [_mStr deleteCharactersInRange:NSMakeRange(_mStr.length - 2, 2)];
        return _mStr;
    } else {
        return nil;
    }
}

- (NSString *)date {
    NSString *year = [self.recordTime substringToIndex:4];
    NSString *month = [self.recordTime substringWithRange:NSMakeRange(5, 2)];
    NSString *day = [self.recordTime substringWithRange:NSMakeRange(8, 2)];
    return [NSString stringWithFormat:@"%@年%@月%@日", year, month, day];
}

- (NSString *)time {
    return [self.recordTime substringWithRange:NSMakeRange(11, 5)];
}

@end
