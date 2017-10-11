//
//  QualificaitonCollectionViewCell.h
//  HengruiHealthy
//
//  Created by Mac on 2017/8/23.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QualificaitonCollectionViewCell : UICollectionViewCell

@property (copy, nonatomic) NSString *url;

- (void)loadCell;

@end
