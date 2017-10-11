//
//  ArchivesTableViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/6/27.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ArchivesTableViewCell<T> : UITableViewCell

@property (strong, nonatomic) T t;

- (void)loadCell;

@end
