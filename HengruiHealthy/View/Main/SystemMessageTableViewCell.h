//
//  SystemMessageTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "SystemMessage.h"

@protocol SystemMessageCellDelegate <NSObject>

- (void)reviewMessage;
- (void)checkNowButtonClick:(UIButton *)button;    //立即查看按钮点击事件

@end

@interface SystemMessageTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *checkBtn;   //立即查看按钮


@property (strong, nonatomic) SystemMessage *message;

@property (assign, nonatomic) id<SystemMessageCellDelegate> delegate;

- (void)loadCell;

@end
