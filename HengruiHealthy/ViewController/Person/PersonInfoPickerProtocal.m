//
//  PersonInfoPickerProtocal.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/13.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "PersonInfoPickerProtocal.h"

@interface PersonInfoPickerProtocal () <UIPickerViewDataSource, UIPickerViewDelegate> {
    
}

@end

@implementation PersonInfoPickerProtocal

#pragma mark - Picker view data source

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.sources.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.sources[row];
}

#pragma mark - Picker view delegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if ([self.delegate respondsToSelector:@selector(selectRowForTitle:)]) {
        [self.delegate selectRowForTitle:[self.sources objectAtIndex:row]];
    }
}

@end
