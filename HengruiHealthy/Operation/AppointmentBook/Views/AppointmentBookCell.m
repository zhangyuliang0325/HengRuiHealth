//
//  AppointmentBookCell.m
//  HengruiHealthy
//
//  Created by Hengzhan on 2017/9/26.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AppointmentBookCell.h"

@interface AppointmentBookCell()

@property (weak, nonatomic) IBOutlet UIView *isHideEvaluateView; //患者评价的父视图
@property (weak, nonatomic) IBOutlet UIView *evaluateSignView;  //患者评价标签的父试图
@property (weak, nonatomic) IBOutlet UITextView *proDescriptionTF; //问题描述
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView; //头像
@property (weak, nonatomic) IBOutlet UILabel *nameLab;   //名字
@property (weak, nonatomic) IBOutlet UILabel *firstPositionLab; //第一职称
@property (weak, nonatomic) IBOutlet UILabel *secondPositionLab; //第二职称
@property (weak, nonatomic) IBOutlet UILabel *goodAtLab;        //擅长
@property (weak, nonatomic) IBOutlet UILabel *appointOrderLab;  //预约单号
@property (weak, nonatomic) IBOutlet UIImageView *isReplayImageView; //已回复，已逾期
@property (weak, nonatomic) IBOutlet UIImageView *firstStarImageView; //第一颗星星
@property (weak, nonatomic) IBOutlet UIImageView *secondStarImageView; //第二颗星星
@property (weak, nonatomic) IBOutlet UIImageView *thirdStarImageView;  //第三颗星星
@property (weak, nonatomic) IBOutlet UIImageView *forthStarImageView;  //第四颗星星
@property (weak, nonatomic) IBOutlet UIImageView *fifthStarImageView;  //第五颗星星
@property (weak, nonatomic) IBOutlet UILabel *beginLab;       //起
@property (weak, nonatomic) IBOutlet UILabel *beginTimeLab;   //起始时间
@property (weak, nonatomic) IBOutlet UILabel *endLab;         //止
@property (weak, nonatomic) IBOutlet UILabel *endTimeLab;     //终止时间
@property (weak, nonatomic) IBOutlet UIView *isHideButtonsView; //按钮们的父视图
@property (weak, nonatomic) IBOutlet UIButton *firstButton;
@property (weak, nonatomic) IBOutlet UIButton *secondButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdButton;
@property (weak, nonatomic) IBOutlet UIButton *forthButton;
@property (weak, nonatomic) IBOutlet UIView *isHideOutTimeView; //逾期后的内容提示
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineViewTop; //线距离顶部控件的约束
@property (weak, nonatomic) IBOutlet UILabel *priceLab;  //咨询价格
@property (weak, nonatomic) IBOutlet UIButton *goPayButton;  //去支付


@end

@implementation AppointmentBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setUpUI];
}

//初始化UI配置
-(void)setUpUI{
    self.headerImageView.layer.cornerRadius = 25;
    self.headerImageView.layer.masksToBounds = YES;
    self.beginLab.layer.borderColor = [[UIColor redColor] CGColor];
    self.endLab.layer.borderColor = [[UIColor redColor] CGColor];
    self.firstButton.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.secondButton.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.thirdButton.layer.borderColor = [[UIColor orangeColor] CGColor];
    self.forthButton.layer.borderColor = [[UIColor orangeColor] CGColor];
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}

@end
