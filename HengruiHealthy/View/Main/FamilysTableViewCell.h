//
//  FamilysTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/9/8.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Family.h"

@protocol FamiliseCellDelegate <NSObject>

- (void)selectedFamily:(Family *)family;

@end

@interface FamilysTableViewCell : UITableViewCell

@property (strong, nonatomic) Family *family;
@property (assign, nonatomic) id<FamiliseCellDelegate> delegate;

- (void)loadCell;

@end
