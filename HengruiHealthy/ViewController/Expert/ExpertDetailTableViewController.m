//
//  ExpertDetailTableViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/17.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "ExpertDetailTableViewController.h"

#import "QualificaitonCollectionViewCell.h"

#import "ExpertEvalueLabel.h"
#import "ExpertEvalueCell.h"

#import "ExpertClient.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry/Masonry.h>
#import <MJExtension.h>
@interface ExpertDetailTableViewController () <UICollectionViewDelegate, UICollectionViewDataSource> {
    
    __weak IBOutlet UIButton *_btnAppointment;
    __weak IBOutlet UIView *_vwAppointment;
    __weak IBOutlet UIView *_vwEvalueLabel;
    __weak IBOutlet UILabel *_lblLevel;
    __weak IBOutlet UILabel *_lblUtil;
    __weak IBOutlet UILabel *_lblDuties;
    __weak IBOutlet UILabel *_lblName;
    __weak IBOutlet UIImageView *_imgAvatar;
    __weak IBOutlet UICollectionViewFlowLayout *_layoutCertifier;
    __weak IBOutlet UICollectionView *_cvCertifier;
    __weak IBOutlet UILabel *_lblArea;
    __weak IBOutlet UILabel *_lblInfo;
    
    CGFloat _infoHeight;
    CGFloat _areaHeight;
    CGFloat _certifierHeight;
    
    CGFloat _sectionInfoHeight;
    CGFloat _sectionAreaHeight;
    CGFloat _sectionCertifierHeight;
    CGFloat _sectionEvalueLabelHeight;
    CGFloat _sctionEvalueContentCellHeight;
    
    NSMutableArray *_evalueContents;
    
}

@end

static NSString *expertEvalueCellIdentifier = @"ExpertEvalueCell";

@implementation ExpertDetailTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    [self.tableView registerNib:[UINib nibWithNibName:@"ExpertEvalueCell" bundle:nil] forCellReuseIdentifier:expertEvalueCellIdentifier];
    [self getExpertEvalues:_expert.expertId];
    [self getEvalueContent:1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Http server

- (void)getExpertEvalues:(NSString *)expertId {
    [[ExpertClient shartInstance] getExpertEvalueLabel:expertId handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *evalueLabels = [ExpertEvalueLabel mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            [self configEvalueLabelCell:evalueLabels];
        } else {
            
        }
    }];
}

- (void)getEvalueContent:(NSInteger)pageNumber {
    [[ExpertClient shartInstance] getExpertEvalueContent:_expert.expertId pageNumber:[NSString stringWithFormat:@"%ld", (long)pageNumber] limit:@"15" handler:^(id response, BOOL isSuccess) {
        if (isSuccess) {
            NSArray *evalueCounts = [ExpertEvalueContent mj_objectArrayWithKeyValuesArray:response[@"Items"]];
            if (_evalueContents == nil) {
                _evalueContents = [NSMutableArray array];
            }
            [_evalueContents addObjectsFromArray:evalueCounts];
            [self.tableView reloadData];
        } else {
            
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForInfoButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    _sectionInfoHeight = sender.selected ? _infoHeight : 0;
    [self translateArrowButton:sender];
}

- (IBAction)actionForGoodAtButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    _sectionAreaHeight = sender.selected ? _areaHeight : 0;
    [self translateArrowButton:sender];
}

- (IBAction)actionForCertifierButton:(UIButton *)sender {
    sender.selected = !sender.selected;
    _sectionCertifierHeight = sender.selected ? _certifierHeight : 0;
    [self translateArrowButton:sender];
}

- (IBAction)actionForAppointmentButton:(UIButton *)sender {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [super numberOfSectionsInTableView:tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 3) {
        return _evalueContents.count + 2;
    }
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (indexPath.row > 1) {
            ExpertEvalueCell *cell = [tableView dequeueReusableCellWithIdentifier:expertEvalueCellIdentifier forIndexPath:indexPath];
            cell.content = _evalueContents[indexPath.row - 2];
            [cell loadCell];
            _sctionEvalueContentCellHeight = cell.cellHeight;
            return cell;
        }
    }
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 1) {
                return _sectionInfoHeight;
            }
            break;
        case 1:
            if (indexPath.row == 1) {
                return _sectionAreaHeight;
            }
            break;
        case 2:
            if (indexPath.row == 1) {
                return _sectionCertifierHeight;
            }
            break;
        case 3:
            if (indexPath.row == 1) {
                return _sectionEvalueLabelHeight;
            } else if (indexPath.row > 1) {
                return _sctionEvalueContentCellHeight;
            }
            break;
        default:
            break;
    }
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 3) {
        if (indexPath.row > 1) {
            return 200;
        }
    }
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView indentationLevelForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 4) {
        return 0.0000001;
    } else {
        return 10;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.0000001;
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _expert.qualificationURLs.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cvCellIdentifier = @"qualificationCellIdentifier";
    QualificaitonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cvCellIdentifier forIndexPath:indexPath];
    cell.url = _expert.qualificationURLs[indexPath.row];
    [cell loadCell];
    return cell;
}

#pragma mark - Collection view delegate

#pragma mark - UI

- (void)configUI {
    _lblName.text = _expert.name;
    _lblDuties.text = _expert.duties;
    _lblUtil.text = _expert.util;
    _lblLevel.text = _expert.level;
    _lblInfo.text = _expert.aptitude;
    SDWebImageDownloader *downloader = [SDWebImageManager sharedManager].imageDownloader;
    [downloader setValue:[[NSUserDefaults standardUserDefaults] objectForKey:kHRHtyUserId] forHTTPHeaderField:@"Cookie"];
    [downloader downloadImageWithURL:[NSURL URLWithString:_expert.avatar] options:SDWebImageDownloaderHandleCookies progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
        
    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
        _imgAvatar.image = image;
    }];
    [_lblInfo sizeToFit];
    _infoHeight = _lblInfo.bounds.size.height + 16;
    _sectionInfoHeight = _infoHeight;
    _lblArea.text = _expert.speciality;
    [_lblArea sizeToFit];
    _areaHeight = _lblArea.bounds.size.height + 16;
    _sectionAreaHeight = _areaHeight;
    CGFloat photoHeight = (HRHtyScreenWidth - 60) / 3;
    _layoutCertifier.itemSize = CGSizeMake(photoHeight, photoHeight);
    _layoutCertifier.minimumInteritemSpacing = 15;
    _certifierHeight = photoHeight + 16;
    _sectionCertifierHeight = _certifierHeight;
    
}

- (void)configEvalueLabelCell:(NSArray *)evalueLabels {
    __block CGFloat x = 15;
    __block CGFloat y = 8;
    [evalueLabels enumerateObjectsUsingBlock:^(ExpertEvalueLabel *evalueLabel, NSUInteger idx, BOOL * _Nonnull stop) {
        UILabel *label = [[UILabel alloc] init];
        label.text = evalueLabel.labelText;
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13.0f];
        label.textColor = [UIColor lightGrayColor];
        [label sizeToFit];
        CGFloat width = label.bounds.size.width + 10;
        CGFloat height = label.bounds.size.height + 8;
        if (x + width > HRHtyScreenWidth) {
            x = 15;
            y = y + height + 5;
        }
        label.frame = CGRectMake(x, y, width, height);
        label.layer.borderColor = [UIColor lightGrayColor].CGColor;
        label.layer.borderWidth = 1;
        label.layer.cornerRadius = 2;
        label.clipsToBounds = YES;
        [_vwEvalueLabel addSubview:label];
        if (idx == evalueLabels.count - 1) {
            _sectionEvalueLabelHeight = y + height + 8;
            [self.tableView beginUpdates];
            [self.tableView endUpdates];
            return;
        }
        
        x = x + width + 8;
        if (x > HRHtyScreenWidth - 15) {
            x = 15;
            y = y + height + 5;
        }
    }];
}

#pragma mark - Method

- (void)translateArrowButton:(UIButton *)sender {
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
    CGAffineTransform transform = sender.transform;
    [UIView animateWithDuration:0.2 animations:^{
        sender.transform = CGAffineTransformRotate(transform, M_PI);
    }];
}

@end
