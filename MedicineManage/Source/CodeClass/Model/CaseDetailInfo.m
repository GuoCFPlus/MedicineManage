//
//  CaseDetailInfo.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/7.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "CaseDetailInfo.h"

@implementation CaseDetailInfo

-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"id"]) {
        _caseDetailId = value;
    }
}

-(void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
    if ([key isEqualToString:@"votes"]) {
        self.votes = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"postTime"]) {
        self.postTime = [NSString stringWithFormat:@"%@",value];
    }
    if ([key isEqualToString:@"favs"]) {
        self.favs = [NSString stringWithFormat:@"%@",value];
    }
}


-(instancetype)initWithDictionary:(NSDictionary *)dict{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}


@end
