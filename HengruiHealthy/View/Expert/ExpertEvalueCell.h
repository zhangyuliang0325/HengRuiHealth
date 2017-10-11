//
//  ExpertEvalueCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/24.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ExpertEvalueContent.h"

@interface ExpertEvalueCell : UITableViewCell

@property (strong, nonatomic) ExpertEvalueContent *content;
@property (assign, nonatomic) CGFloat cellHeight;

- (void)loadCell;

@end
