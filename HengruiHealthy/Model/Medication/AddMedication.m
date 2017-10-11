//
//  AddMedication.m
//  HengruiHealthy
//
//  Created by Mac on 2017/8/31.
//  Copyright © 2017年 com.hengrui. All rights reserved.
//

#import "AddMedication.h"

@implementation AddMedication

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return @{
             @"isMorning":@"IsMorning",
             @"morningCount":@"MorningTakeMedicationAmount",
             @"isAfternoon":@"IsNooning",
             @"afternoonCount":@"NooningTakeMedicationAmount",
             @"isEvening":@"IsEvening",
             @"eveningCount":@"EveningTakeMedicationAmount",
             
             @"medicationId":@"DrugId",
             @"goodsName":@"DrugNameOfCommodity",
             @"name":@"DrugName",
             @"imageURL":@"SmallImageUrl",
             @"specification":@"DrugSpecification",
             @"countOfUse":@"NumberOfTakeMedication",
             @"company":@"DrugProductionEnterprise",
             @"profile":@"DrugProfile",
             @"approval":@"DrugApprovalNumber",
             @"unit":@"DrugTakeMedicationUnitf",
             @"dosage":@"TakeMedicationAmount"
             };
}

- (instancetype)init {
    if (self = [super init]) {
        self.medicationId = @"";
        self.isEvening = NO;
        self.isMorning = NO;
        self.isAfternoon = NO;
        self.morningCount = @"0";
        self.afternoonCount = @"0";
        self.eveningCount = @"0";
        self.medication = [[Medication alloc] init];
    }
    return self;
}

#pragma mark - Setter 

- (void)setMedicationId:(NSString *)medicationId {
    _medicationId = medicationId;
    self.medication.medicationId = medicationId;
}

- (void)setGoodsName:(NSString *)goodsName {
    _goodsName = goodsName;
    self.medication.goodsName = goodsName;
}

- (void)setName:(NSString *)name {
    _name = name;
    self.medication.name = name;
}

- (void)setUnit:(NSString *)unit {
    _unit = unit;
    self.medication.unit = unit;
}

- (void)setImageURL:(NSString *)imageURL {
    _imageURL = imageURL;
    self.medication.imageURL = imageURL;
}

- (void)setSpecification:(NSString *)specification {
    _specification = specification;
    self.medication.specification = specification;
}

- (void)setCountOfUse:(NSString *)countOfUse {
    _countOfUse = countOfUse;
    self.medication.countOfUse = countOfUse;
}

- (void)setCompany:(NSString *)company {
    _company = company;
    self.medication.company = company;
}

- (void)setProfile:(NSString *)profile {
    _profile = profile;
    self.medication.profile = profile;
}

- (void)setApproval:(NSString *)approval {
    _approval = approval;
    self.medication.approval = approval;
}

- (void)setDosage:(NSString *)dosage {
    _dosage = dosage;
    self.medication.dosage = dosage;
}

@end


