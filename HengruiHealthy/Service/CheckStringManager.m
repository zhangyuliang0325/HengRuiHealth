//
//  CheckStringManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "CheckStringManager.h"

NSString *const passwordRegular = @"^[a-zA-Z0-9]{6,12}";
NSString *const mobileRegular = @"^((13[0-9])|(14[5|7])|(15([0-3]|[5-9]))|(18[0-9]))\\d{8}$";
NSString *const vertityRegular = @"^[0-9]{6}";

@implementation CheckStringManager

+ (instancetype)shareInstance {
    static CheckStringManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[CheckStringManager alloc] init];
    });
    return manager;
}

+ (BOOL)checkBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)checkString:(NSString *)string inputExpressions:(NSString *)exp {
    NSRegularExpression *expression = [NSRegularExpression  regularExpressionWithPattern:exp options:NSRegularExpressionCaseInsensitive error:nil];
    int count = (int)[expression numberOfMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length)];
    if (count >= string.length) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL)checkPassword:(NSString *)password {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", passwordRegular];
    return [predicate evaluateWithObject:password];
}

+ (BOOL)checkMobile:(NSString *)mobile {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobileRegular];
    return [predicate evaluateWithObject:mobile];
}

+ (BOOL)checkVertity:(NSString *)vertity {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", vertityRegular];
    return [predicate evaluateWithObject:vertity];
}

+ (BOOL)verifyIDCardNumber:(NSString *)IDCardNumber {
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18)
    {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:IDCardNumber])
    {
        return NO;
    }
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([IDCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([IDCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([IDCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([IDCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([IDCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([IDCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [IDCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6
    + [IDCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[IDCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

@end
