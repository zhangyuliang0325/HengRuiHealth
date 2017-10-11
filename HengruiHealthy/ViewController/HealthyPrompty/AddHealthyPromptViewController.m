//
//  AddHealthyPromptViewController.m
//  HengruiHealthy
//
//  Created by Mac on 2017/9/6.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AddHealthyPromptViewController.h"

#import "HealthyPromptInfoTableViewController.h"

#import "ChoosePromptWeekday.h"

#import "PersonClient.h"

#import "PromptManager.h"
#import "MBPrograssManager.h"

@interface AddHealthyPromptViewController () <HealthyPromptInfoDelegate, ChoosePromptWeekdayDelegate> {
    
    __weak IBOutlet UILabel *_lblTimeCount;
    __weak IBOutlet UIDatePicker *_datePicker;
    
    HealthyPromptInfoTableViewController *_tvcHealthyPromptInfo;
    ChoosePromptWeekday *_chooseWeekday;
    PromptManager *_manager;
    
    NSArray *_weekdayCodes;
    NSArray *_weekdayNames;
}

@end

@implementation AddHealthyPromptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _manager = [[PromptManager alloc] init];
    [self configUI];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    _tvcHealthyPromptInfo = (HealthyPromptInfoTableViewController *)segue.destinationViewController;
//    _tvcHealthyPromptInfo.click = self.click;/
    _tvcHealthyPromptInfo.delegate = self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - Http server

- (void)savePrompt {
    [MBPrograssManager showPrograssOnMainView];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:ss"];
    NSString *promptTime = [[formatter stringFromDate:_datePicker.date] stringByAppendingString:@":00"];
    [[PersonClient shareInstance] savePrompt:self.prompt.promptId title:self.prompt.title time:promptTime weekdays:self.prompt.weekdays ring:self.prompt.ring isVibrating:self.prompt.isVibrating ? @"true" : @"false" remark:[_tvcHealthyPromptInfo getRemark] enable:self.prompt.isEnable ? @"true" : @"false" handler:^(id response, BOOL isSuccess) {
        [MBPrograssManager hidePrograssFromMainView];
        if (isSuccess) {
            if ([self.delegate respondsToSelector:@selector(changedPrompts)]) {
                [self.delegate changedPrompts];
            }
            self.prompt.remark = [_tvcHealthyPromptInfo getRemark];
            self.prompt.promptTime = promptTime;
            self.prompt.promptId = response[0];
            if (self.prompt.isEnable) {
                [_manager cancelNotificaiton:self.prompt];
                [_manager addNotification:self.prompt];
            }
            [MBPrograssManager showMessage:@"添加成功" OnView:self.view];
            [self.navigationController popViewControllerAnimated:YES];
        } else {
            [MBPrograssManager showMessage:response OnView:self.view];
        }
    }];
}

#pragma mark - Action

- (IBAction)actionForChangeDate:(UIDatePicker *)sender {
    NSTimeInterval interval =[sender.date timeIntervalSinceNow];
    NSDate *date = sender.date;
    NSDate *now = [NSDate date];
    if ([date compare:now] == NSOrderedAscending) {
        date = [sender.date dateByAddingTimeInterval:86400];
        interval = [date timeIntervalSinceNow];
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:now toDate:date options:NSCalendarWrapComponents];
    _lblTimeCount.text = [NSString stringWithFormat:@"距下次提醒还有%ld天%ld小时%ld分钟", (long)components.day, (long)components.hour, (long)components.minute];
}

- (IBAction)actionForAddItem:(UIBarButtonItem *)sender {
    [self savePrompt];
}

#pragma mark - Healthy prompt info delegate

- (void)chooseWeekdays {
    [_chooseWeekday show];
}

#pragma mark - Choose weekdays delegate

- (void)choosedWeekdaysName:(NSString *)name {
    self.prompt.weekdays = name;
    [self setRecycle];
}

#pragma mark - UI

- (void)configUI {
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    if (self.isModify) {
        
    } else {
        self.prompt = [[HealthyPrompt alloc] init];
        self.prompt.title = @"健康提醒";
        self.prompt.isEnable = YES;
        self.prompt.isVibrating = YES;
        self.prompt.ring = @"default";
        self.prompt.weekdays = @"周一;周二;周三;周四;周五;周六;周日";
        
        [formatter setDateFormat:@"HH:mm"];
        self.prompt.promptTime = [[formatter stringFromDate:now] stringByAppendingString:@":00"];
    }
    [self setRecycle];
    [_tvcHealthyPromptInfo setRing:self.prompt.ring];
    [_tvcHealthyPromptInfo setVibrating:self.prompt.isVibrating];
    NSDate *promptDate = [[NSCalendar currentCalendar] dateBySettingHour:self.prompt.hour minute:self.prompt.minute second:0 ofDate:now options:NSCalendarSearchBackwards];
    if ([promptDate compare:now] == NSOrderedAscending) {
        promptDate = [promptDate dateByAddingTimeInterval:86400];
    }
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute fromDate:now toDate:promptDate options:NSCalendarWrapComponents];
    _lblTimeCount.text = [NSString stringWithFormat:@"距下次提醒还有%ld天%ld小时%ld分钟", (long)components.day, (long)components.hour, (long)components.minute];
    _chooseWeekday = [[[NSBundle mainBundle] loadNibNamed:@"ChoosePromptWeekday" owner:self options:nil] lastObject];
    _chooseWeekday.delegate = (id)self;
    [self.view addSubview:_chooseWeekday];
    [_chooseWeekday setSelectDays:self.prompt.weekdayCodes names:self.prompt.weekdayNames];
}

- (void)setRecycle {
    NSString *recycle = self.prompt.weekdays;
    if (self.prompt.weekdayNames.count == 7) {
        recycle = @"每天";
    }
    [_tvcHealthyPromptInfo setRecycle:recycle];
}


@end
