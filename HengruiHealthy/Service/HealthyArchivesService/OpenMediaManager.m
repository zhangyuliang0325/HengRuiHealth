//
//  OpenMediaManager.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/11.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "OpenMediaManager.h"

#import <AVFoundation/AVCaptureDevice.h>
#import <AVFoundation/AVMediaFormat.h>
#import<AssetsLibrary/AssetsLibrary.h>
#import<CoreLocation/CoreLocation.h>

@interface OpenMediaManager () <UIImagePickerControllerDelegate> {
    UIImagePickerController *_mediaVC;
}

@end

@implementation OpenMediaManager

- (instancetype)initWithRootViewController:(UIViewController *)rootVC {
    if (self == [super init]) {
        _rootVC = rootVC;
        _mediaVC = [[UIImagePickerController alloc] init];
        _mediaVC.delegate = (id)self;
        _mediaVC.allowsEditing = YES;
    }
    return self;
}

- (void)openMediaController {
    [_rootVC presentViewController:_mediaVC animated:YES completion:nil];
}

#pragma mark - Setter 

- (void)setSourceType:(UIImagePickerControllerSourceType)sourceType {
    _sourceType = sourceType;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        _mediaVC.sourceType = sourceType;
    } else {
        if ([self.delegate respondsToSelector:@selector(openFaild:)]) {
            
            switch (sourceType) {
                case UIImagePickerControllerSourceTypeCamera:
                    [self.delegate openFaild:@"您的手机不支持打开相机功能"];
                    break;
                case UIImagePickerControllerSourceTypePhotoLibrary:
                    [self.delegate openFaild:@"您的手机不支持打开相册功能"];
                    break;
                case UIImagePickerControllerSourceTypeSavedPhotosAlbum:
                    break;
                default:
                    break;
            }
        }
    }
}

#pragma mark - Image picker controller delegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [_mediaVC dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([self.delegate respondsToSelector:@selector(finishChoose:)]) {
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [self.delegate finishChoose:image];
    }
    [_mediaVC dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Method

+ (OpenMediaManager *)checkAuthorizationWithSourceType:(UIImagePickerControllerSourceType)sourceType rootViewController:(UIViewController *)rootVC {
    AVAuthorizationStatus status;
    switch (sourceType) {
        case UIImagePickerControllerSourceTypeCamera:
        {
            status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
            if (status ==AVAuthorizationStatusRestricted || status ==AVAuthorizationStatusDenied) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
                return nil;
            } else {
                return [OpenMediaManager openMediaWithRootViewController:rootVC sourceType:sourceType];
            }
        }
            break;
        case UIImagePickerControllerSourceTypePhotoLibrary:
        {
            ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
            if (author ==kCLAuthorizationStatusRestricted || author ==kCLAuthorizationStatusDenied){
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }
                return nil;
            } else {
                return [OpenMediaManager openMediaWithRootViewController:rootVC sourceType:sourceType];
            }
        }
            break;
        default:
            break;
    }
    return nil;
}

+ (OpenMediaManager *)openMediaWithRootViewController:(UIViewController *)rootVC sourceType:(UIImagePickerControllerSourceType)sourceType {
    OpenMediaManager *manager = [[OpenMediaManager alloc] initWithRootViewController:rootVC];
    manager.sourceType = sourceType;
    manager.delegate = (id)rootVC;
    [manager openMediaController];
    return manager;
}

@end
