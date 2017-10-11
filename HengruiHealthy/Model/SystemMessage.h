//
//  SystemMessage.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import <MJExtension/MJExtension.h>

@class MessageContent;

@interface SystemMessage : NSObject

@property (copy, nonatomic) NSString *messageId;
@property (copy, nonatomic) NSString *createTime;
@property (assign, nonatomic) BOOL isRead;

@property (copy, nonatomic) NSString *messageContentId;
@property (copy, nonatomic) NSString *messageContentTime;
@property (copy, nonatomic) NSString *businessContentId;
@property (copy, nonatomic) NSString *messageContentType;
@property (copy, nonatomic) NSString *messageTextContent;

@end

@interface MessageContent : NSObject



@end

