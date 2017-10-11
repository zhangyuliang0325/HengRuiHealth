//
//  AddArchiveTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/11.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AddArchiveTableViewController.h"

#import "HealthyArchiveDetailTableViewController.h"

#import "ArchivePhotoCellTableViewCell.h"

#import "ArchiveClient.h"

#import "OpenMediaManager.h"
#import "MBPrograssManager.h"

typedef NS_ENUM(NSInteger, PhotoType) {
    hospitalPhoto,
    casePhoto,
    drugPhoto
};

@interface AddArchiveTableViewController () <OpenMediaManagerDelegate, ArchivePhotoCellDelegate, UITextViewDelegate> {
    
    __weak IBOutlet UILabel *_lblTime;
    __weak IBOutlet UIButton *_btnHospital;
    __weak IBOutlet UIButton *_btnCase;
    __weak IBOutlet UIButton *_btnDrug;
    __weak IBOutlet UILabel *_lblHolder;
    __weak IBOutlet UILabel *_lblTextCount;
    __weak IBOutlet UITextView *_txtDetail;
    
    NSMutableDictionary *_parameters;
    PhotoType _type;
    NSDate *_recordDate;
    
    NSMutableArray *_hospitals;
    NSMutableArray *_cases;
    NSMutableArray *_drugs;
    
    CGFloat _hospitalHeight;
    CGFloat _caseHeight;
    CGFloat _drugHeight;
    
    NSInteger _hospitalCount;
    NSInteger _caseCount;
    NSInteger _drugCount;
    
    NSInteger _uploadImageCount;
    NSInteger _totalUpload;
    
    int _photoCount;
    
    OpenMediaManager *_mediaManager;
}

@end

@implementation AddArchiveTableViewController

- (void)dealloc {
    NSLog(@"dealloc add archive");
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createParameters];
    [self configPhotos];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)saveHospitalPhoto {
    NSArray *photos = [_hospitals subarrayWithRange:NSMakeRange(0, _hospitalCount)];
    [[ArchiveClient shareInstance] savePhotos:photos handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            [self saveImageType:@"Dalx_Yyjc" result:response];
        } else {
            [MBPrograssManager hidePrograssFromMainView];
            [MBPrograssManager showMessage:@"保存失败,请重试" OnView:self.view];
        }
    }];
}

- (void)saveCasePhoto {
    NSArray *photos = [_cases subarrayWithRange:NSMakeRange(0, _caseCount)];
    [[ArchiveClient shareInstance] savePhotos:photos handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            [self saveImageType:@"Dalx_Bl" result:response];
        } else {
            [MBPrograssManager hidePrograssFromMainView];
            [MBPrograssManager showMessage:@"保存失败,请重试" OnView:self.view];
        }
    }];
}

- (void)saveDrugPhoto {
    NSArray *photos = [_drugs subarrayWithRange:NSMakeRange(0, _drugCount)];
    [[ArchiveClient shareInstance] savePhotos:photos handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            [self saveImageType:@"Dalx_Yyfa" result:response];
        } else {
            [MBPrograssManager hidePrograssFromMainView];
            [MBPrograssManager showMessage:@"保存失败,请重试" OnView:self.view];
        }
    }];
}

- (void)saveArchive {
    _parameters[@"Remark"] = _txtDetail.text;
    [[ArchiveClient shareInstance] saveHealthyArchiveWithParameter:_parameters handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationRepleaceArchiveList object:nil];
            _totalUpload = 0;
            _uploadImageCount = 0;
            NSArray *ids = (NSArray *)response;
            HealthyArchiveDetailTableViewController *tvcArchiveDetail = [[UIStoryboard storyboardWithName:@"HealthyArchive" bundle:nil] instantiateViewControllerWithIdentifier:@"tvcArchiveDetail"];
            tvcArchiveDetail.archiveId = ids[0];
//            [self.navigationController pushViewController:tvcArchiveDetail animated:YES];
            UINavigationController *nav = self.navigationController;
            NSMutableArray *mArr = [NSMutableArray arrayWithArray:nav.childViewControllers];
            AddArchiveTableViewController *tvc = [mArr lastObject];
            [mArr removeObject:tvc];
            [mArr addObject:tvcArchiveDetail];
            [nav setViewControllers:mArr];
            tvc.view = nil;
            tvc = nil;
            
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForHospital:(UIButton *)sender {
    _type = hospitalPhoto;
    [self chooseMediaType];
}

- (IBAction)actionForCase:(UIButton *)sender {
    _type = casePhoto;
    [self chooseMediaType];
}

- (IBAction)actionForDrug:(UIButton *)sender {
    _type = drugPhoto;
    [self chooseMediaType];
}

- (IBAction)_actionForJczz_SfFlkg:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Jczz_SfFlkg"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForJczz_SfDydssjdn:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Jczz_SfDydssjdn"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForJczz_SfXs:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Jczz_SfXs"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForJczz_SfFzxh:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Jczz_SfFzxh"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForJczz_SfZhdh:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Jczz_SfZhdh"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForWxh_SfSlmhxj:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Wxh_SfSlmhxj"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForWxh_SfSzflr:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Wxh_SfSzflr"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForWxh_SfTnbsb:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Wxh_SfTnbsb"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForWxh_SfTnbz:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Wxh_SfTnbz"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForSjbb_SfSzmm:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Sjbb_SfSzmm"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForSjbb_SfPfsr:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Sjbb_SfPfsr"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForSjbb_SfBmfx:(UIButton *)sender {
    sender.selected = !sender.selected;
    _parameters[@"Sjbb_SfBmfx"] = sender.selected ? @"true" : @"false";
}
- (IBAction)actionForSaveItem:(id)sender {
    [MBPrograssManager showPrograssOnMainView];
    if (_hospitalCount + _caseCount + _drugCount == 0) {
        [self saveArchive];
        return;
    }
    if (_hospitalCount != 0) {
        _totalUpload ++;
        [self saveHospitalPhoto];
    }
    if (_caseCount != 0) {
        _totalUpload ++;
        [self saveCasePhoto];
    }
    if (_drugCount != 0) {
        _totalUpload ++;
        [self saveDrugPhoto];
    }
}
#pragma mark - Table view data source 

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:{
                ArchivePhotoCellTableViewCell *photoCell = (ArchivePhotoCellTableViewCell *)cell;
                photoCell.photos = _hospitals;
                photoCell.photoCount = (int)_hospitalCount;
                photoCell.indexPath = indexPath;
                photoCell.delegate = (id)self;
                [photoCell loadCell];
            }
                break;
            case 3: {
                ArchivePhotoCellTableViewCell *photoCell = (ArchivePhotoCellTableViewCell *)cell;
                photoCell.photos = _cases;
                photoCell.photoCount = (int)_caseCount;
                photoCell.indexPath = indexPath;
                photoCell.delegate = (id)self;
                [photoCell loadCell];
            }
                break;
            case 5: {
                ArchivePhotoCellTableViewCell *photoCell = (ArchivePhotoCellTableViewCell *)cell;
                photoCell.photos = _drugs;
                photoCell.photoCount = (int)_drugCount;
                photoCell.indexPath = indexPath;
                photoCell.delegate = (id)self;
                [photoCell loadCell];
            }
                break;
        }
        
    }
    return cell;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 1:
                return _hospitalHeight;
                break;
            case 3:
                return _caseHeight;
                break;
            case 5:
                return _drugHeight;
                break;
        }
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

#pragma mark - Text view delegate

- (void)textViewDidChange:(UITextView *)textView {
    if (textView.text.length > 0) {
        _lblHolder.hidden = YES;
    } else {
        _lblHolder.hidden = NO;
    }
}

#pragma mark - Opent media delegate

- (void)openFaild:(NSString *)message {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:message message:nil preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:action];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)finishChoose:(UIImage *)image {
    NSInteger row = 0;
    NSMutableArray *mArr;
    CGFloat *height;
    UIButton *chooseButton;
    NSInteger *count;
    switch (_type) {
        case hospitalPhoto:
            mArr = _hospitals;
            height = &_hospitalHeight;
            chooseButton = _btnHospital;
            count = &_hospitalCount;
            row = 1;
            break;
        case casePhoto:
            mArr = _cases;
            height = &_caseHeight;
            chooseButton = _btnCase;
            count = &_caseCount;
            row = 3;
            break;
        case drugPhoto:
            mArr = _drugs;
            height = &_drugHeight;
            chooseButton = _btnDrug;
            count = &_drugCount;
            row = 5;
            break;
        default:
            break;
    }
    [mArr insertObject:image atIndex:mArr.count - 1];
    if (mArr.count > 0) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        chooseButton.hidden = YES;
        *height = 110;
        *count = (int)mArr.count - 1;
        if (mArr.count > 3) {
            [mArr removeLastObject];
        }
        UITableViewRowAnimation animation;
        if (mArr.count == 2) {
            animation = UITableViewRowAnimationTop;
        } else {
            animation = UITableViewRowAnimationNone;
        }
        [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
        [self.tableView beginUpdates];
        [self.tableView endUpdates];
    }
}

#pragma mark - Archive photo cell delegate

- (void)addPhotoInCell:(UITableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    _type = indexPath.row / 2;
    [self chooseMediaType];
}

- (void)removePhotoFromCell:(ArchivePhotoCellTableViewCell *)cell {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CGFloat *cellHeight = NULL;
    _photoCount = cell.photoCount;
    NSMutableArray *mArr = [NSMutableArray arrayWithArray:cell.photos];
    if (cell.photoCount == 2) {
        [mArr addObject:[UIImage imageNamed:@"add_image_big"]];
    }
    UIButton *cellButton;
    switch (indexPath.row) {
        case 1:
            _hospitals = mArr;
            cellHeight = &_hospitalHeight;
            cellButton = _btnHospital;
            _hospitalCount = cell.photoCount;
            break;
        case 3:
            _cases = mArr;
            cellHeight = &_caseHeight;
            cellButton = _btnCase;
            _caseCount = cell.photoCount;
            break;
        case 5:
            _drugs = mArr;
            cellHeight = &_drugHeight;
            cellButton = _btnDrug;
            _drugCount = cell.photoCount;
            break;
        default:
            break;
    }
    UITableViewRowAnimation animation;
    if (_photoCount == 0) {
        *cellHeight = 0;
        animation = UITableViewRowAnimationBottom;
        cellButton.hidden = NO;
    } else {
        animation = UITableViewRowAnimationNone;
    }
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:animation];
    [self.tableView beginUpdates];
    [self.tableView endUpdates];

}

#pragma mark - Method

- (void)createParameters {
    _recordDate = [NSDate date];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy年MM月dd日 HH:ss"];
    _lblTime.text = [format stringFromDate:_recordDate];
    _parameters = [NSMutableDictionary dictionary];
    _parameters[@"Jczz_SfFlkg"] = @"false";
    _parameters[@"Jczz_SfDydssjdn"] = @"false";
    _parameters[@"Jczz_SfXs"] = @"false";
    _parameters[@"Jczz_SfFzxh"] = @"false";
    _parameters[@"Jczz_SfZhdh"] = @"false";
    _parameters[@"Wxh_SfSlmhxj"] = @"false";
    _parameters[@"Wxh_SfSzflr"] = @"false";
    _parameters[@"Wxh_SfTnbsb"] = @"false";
    _parameters[@"Wxh_SfTnbz"] = @"false";
    _parameters[@"Sjbb_SfSzmm"] = @"false";
    _parameters[@"Sjbb_SfPfsr"] = @"false";
    _parameters[@"Sjbb_SfBmfx"] = @"false";
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:_recordDate];
    NSDate *localeDate = [_recordDate  dateByAddingTimeInterval: interval];
    _parameters[@"RecordTime"] = [NSString stringWithFormat:@"%@", localeDate];
    _parameters[@"UserId"] = [[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textViewDidChangeText:) name:UITextViewTextDidChangeNotification object:_txtDetail];
}

- (void)chooseMediaType {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *camara = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _mediaManager = [OpenMediaManager checkAuthorizationWithSourceType:UIImagePickerControllerSourceTypeCamera rootViewController:self];
    }];
    UIAlertAction *altum = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        _mediaManager = [OpenMediaManager checkAuthorizationWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary rootViewController:self];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [ac addAction:camara];
    [ac addAction:altum];
    [ac addAction:cancel];
    [self presentViewController:ac animated:YES completion:nil];
}

- (void)configPhotos {
    _hospitals = [NSMutableArray array];
    [_hospitals addObject:[UIImage imageNamed:@"add_image_big"]];
    _cases = [NSMutableArray array];
    [_cases addObject:[UIImage imageNamed:@"add_image_big"]];
    _drugs = [NSMutableArray array];
    [_drugs addObject:[UIImage imageNamed:@"add_image_big"]];
}

- (void)textViewDidChangeText:(NSNotification *)notification

{
    
    /**
     
     *  最大输入长度,中英文字符都按一个字符计算
     
     */
    
    static int kMaxLength = 500;
    
    
    
    UITextView *textView = (UITextView *)notification.object;
    
    NSString *toBeString = textView.text;
    
    // 获取键盘输入模式
    
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    
    // 中文输入的时候,可能有markedText(高亮选择的文字),需要判断这种状态
    
    // zh-Hans表示简体中文输入, 包括简体拼音，健体五笔，简体手写
    
    if ([lang isEqualToString:@"zh-Hans"]) {
        
        UITextRange *selectedRange = [textView markedTextRange];
        
        //获取高亮选择部分
        
        UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，表明输入结束,则对已输入的文字进行字数统计和限制
        
        if (!position) {
            
            if (toBeString.length > kMaxLength) {
                
                // 截取子串
                
                textView.text = [toBeString substringToIndex:kMaxLength];
                
            }
            _lblTextCount.text = [NSString stringWithFormat:@"%lu/500", (unsigned long)textView.text.length];
        } else { // 有高亮选择的字符串，则暂不对文字进行统计和限制
            
            NSLog(@"11111111111111========      %@",position);
            
        }
        
    } else {
        
        // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
        
        if (toBeString.length > kMaxLength) {
            
            // 截取子串
            
            textView.text = [toBeString substringToIndex:kMaxLength];
            
        }
        
    }
}

- (void)saveImageType:(NSString *)typeName result:(NSArray *)result {
    NSMutableString *mStr = [NSMutableString string];
    for (NSString *string in result) {
        [mStr appendFormat:@"%@;", string];
    }
    [mStr deleteCharactersInRange:NSMakeRange(mStr.length - 1, 1)];
    _parameters[typeName] = mStr;
    _uploadImageCount ++;
    if (_uploadImageCount == _totalUpload) {
        [self saveArchive];
    }
}


@end
