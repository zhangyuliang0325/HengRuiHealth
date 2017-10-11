//
//  ElectrocardioInfo.m
//  HengruiHealthy
//
//  Created by Mac on 2017/6/30.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ElectrocardioInfo.h"

@interface ElectrocardioInfo () <NSURLSessionDownloadDelegate> {
    
    __weak IBOutlet UIImageView *_img;
    __weak IBOutlet UITextField *_tfT;
    __weak IBOutlet UITextField *_tfR;
    __weak IBOutlet UITextField *_tfP;
    __weak IBOutlet UITextField *_tfQTC2;
    __weak IBOutlet UITextField *_tfQTC1;
    __weak IBOutlet UITextField *_tfQT;
    __weak IBOutlet UITextField *_tfPR;
    __weak IBOutlet UITextField *_tfEqual;
    __weak IBOutlet UITextField *_tfDuration;
    __weak IBOutlet UITextField *_tfTime;
    __weak IBOutlet UITextField *_tfDate;
    
    __weak IBOutlet UIScrollView *_scroll;
    NSMutableData *_mData;
    NSURLSessionDownloadTask *_task;
}

@end

@implementation ElectrocardioInfo

- (void)configView {
    _tfP.text = self.electrocardio.P;
    _tfT.text = self.electrocardio.T;
    _tfR.text = self.electrocardio.R;
    _tfQT.text = self.electrocardio.QT;
    _tfQTC1.text = self.electrocardio.QTC1;
    _tfPR.text = self.electrocardio.PR;
    NSString *time = self.electrocardio.measureTime;
    _tfDate.text = [NSString stringWithFormat:@"%@年%@月%@日", [time substringToIndex:4], [time substringWithRange:NSMakeRange(5, 2)], [time substringWithRange:NSMakeRange(8, 2)]];
    _tfTime.text = [NSString stringWithFormat:@"%@",[time substringWithRange:NSMakeRange(11, 8)]];
    _tfEqual.text = self.electrocardio.heartrate;
    _tfDuration.text = @"20ms";
    _scroll.contentSize = CGSizeMake(HRHtyScreenWidth * 2, HRHtyScreenHeight * 2);
    NSLog(@"%@", NSStringFromCGSize(_scroll.contentSize));
}

- (void)setElectrocardio:(Electrocardio *)electrocardio {
    _electrocardio = electrocardio;
    [self downloadImage];
}

- (IBAction)actionForCancel:(UIButton *)sender {
    [self removeFromSuperview];
}

- (void)downloadImage {
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:(id)self delegateQueue:[NSOperationQueue mainQueue]];
    NSString *urlString = [NSString stringWithFormat:@"http://www.hengzhankj.com/api/DeviceData/QueryEcgPictureV1?IdentityUserIdAssign=UserId&IsGetOne=true&EcgStructV1Id=%@&ResultType=file", _electrocardio.Id];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    NSMutableDictionary *allHeaders = [[NSMutableDictionary alloc] initWithDictionary:request.allHTTPHeaderFields];
    allHeaders[@"Cookie"] = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken];
//    [request setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyAuthToken] forHTTPHeaderField:@"Cookie"];
    request.allHTTPHeaderFields = allHeaders;
//    NSString *url = [NSString stringWithFormat:@"%@/api/DeviceData/QueryEcgPictureV1?IdentityUserIdAssign=UserId&IsGetOne=true&EcgStructV1Id=%@&ResultType=file", kBaseDomain, _electrocardio.Id];
    [request setHTTPMethod:@"GET"];
    _task = [session downloadTaskWithRequest:request completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *imag = [UIImage imageWithData:data];
        _img.image = imag;
    }];
    [_task resume];
}

#pragma mark - URL session down load task

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didFinishDownloadingToURL:(NSURL *)location {
    _img.image = [UIImage imageWithContentsOfFile:location.absoluteString];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didWriteData:(int64_t)bytesWritten totalBytesWritten:(int64_t)totalBytesWritten totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite {
    if (_mData == nil) {
        _mData = [[NSMutableData alloc] init];
    }
//    [_mData appendData:downloadTask.response];
}

- (void)URLSession:(NSURLSession *)session downloadTask:(NSURLSessionDownloadTask *)downloadTask didResumeAtOffset:(int64_t)fileOffset expectedTotalBytes:(int64_t)expectedTotalBytes {
    
}
@end
