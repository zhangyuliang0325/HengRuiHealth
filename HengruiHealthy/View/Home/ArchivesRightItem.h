//
//  ArchivesRightItem.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/10.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ArchivesRightItemDelegate <NSObject>

- (void)chooseArchive;

@end

@interface ArchivesRightItem : UIButton

@property (assign, nonatomic) UIViewController *vc;
@property (copy, nonatomic) NSString *title;

@property (assign, nonatomic) id<ArchivesRightItemDelegate> delegate;

- (void)loadView;

@end
