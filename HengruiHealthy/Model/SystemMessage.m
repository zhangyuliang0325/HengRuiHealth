//
//  SystemMessage.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "SystemMessage.h"

@implementation SystemMessage

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"messageId":@"Id",
             @"createTime":@"CreateTime",
             @"isRead":@"IsRead",
             @"messageContentId":@"Content.Id",
             @"messageContentTime":@"Content.CreateTime",
             @"businessContentId":@"Content.BusinessId",
             @"messageContentType":@"Content.MessageType",
             @"messageTextContent":@"Content.TextContent"
             };
}

@end
