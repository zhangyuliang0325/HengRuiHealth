//
//  HealthyPromptsTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HealthyPrompt.h"

#import "HDClick+CoreDataClass.h"

@protocol HealthyPromptCellDelegate <NSObject>

- (void)openPrompt:(HealthyPrompt *)prompt isOpen:(BOOL)isOpen;

@end

@interface HealthyPromptsTableViewCell : UITableViewCell

@property (strong, nonatomic) HealthyPrompt *item;
@property (assign, nonatomic) id<HealthyPromptCellDelegate> delegate;

- (void)loadCell;

@end
