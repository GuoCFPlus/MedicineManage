//
//  CaseInfo.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/5.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "CaseInfo.h"

@implementation CaseInfo

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _caseId = value;
    }
}
/*
-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"votes"]) {
        self.votes = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"postTime"]) {
        self.postTime = [NSString stringWithFormat:@"%@",value];
    }
}
*/

-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
@end
