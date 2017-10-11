//
//  DateTypeViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/7/19.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateTypeViewCell : UICollectionViewCell

FOUNDATION_EXTERN NSString *const typeViewColor;
FOUNDATION_EXTERN NSString *const typeViewText;

@property (strong, nonatomic) NSDictionary *type;

- (void)loadCell;

@end
