//
//  AddHealthyPromptViewController.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "HealthyPrompt.h"

@protocol AddHealthyPromptyDelegate <NSObject>

- (void)changedPrompts;

@end

@interface AddHealthyPromptViewController : UIViewController

//@property (strong, nonatomic) HDClick *click;
@property (assign, nonatomic) BOOL isModify;

@property (strong, nonatomic) HealthyPrompt *prompt;

@property (assign, nonatomic) id<AddHealthyPromptyDelegate> delegate;

@end
