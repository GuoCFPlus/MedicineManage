//
//  CaseDetailInfo.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/7.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseDetailInfo : NSObject

/*
 
 "id": 32653936,
 "boardId": 48,
 "boardTitle": "普通外科",
 "userId": 11526771,
 "username": "Zhangyubo1980",
 "subject": "乳腺炎皮肤溃疡",
 "body": "急性乳腺炎穿刺后（未穿刺出脓液），交替外敷硫酸镁和芒硝，一天后针眼处皮肤出现溃烂，后越来越大，目前有一元硬币那么大，各位老师怎么处理?<br/><div class=\"notice\">本帖为病例讨论帖，3天后将只有完成<a href=\"http://i.dxy.cn/doctor/identify?from=app\" class=\"red\">医师认证</a>的专业人士才能查看，<a href=\"http://i.dxy.cn/doctor/identify?from=app\" class=\"blue\" target=\"_blank\">马上认证</a></div>",
 "parent": 0,
 "root": 32653936,
 "type": 1700,
 "postTime": 1452048177000,
 "user": {
 "userId": 11526771,
 "username": "Zhangyubo1980",
 "avatar": "18.jpg",
 "doctor": true,
 "expert": false,
 "statusTitle": "<div class=\"user-level-area\">入门站友<p class=\"user-level user-level-1\"></p></div>",
 "sectionTitle": "普外科"
 },
 "floor": 1,
 "warning": false,
 "eMoney": 0,
 "score": 0,
 "imagesInfo": null,
 "prefix": "",
 "good": false,
 "votes": 1,
 "casePostEnter": false,
 "openAppForReply": false,
 "favs": 1,
 "favorited": true,
 "voted": true,
 "hasAttachment": false,
 "attachment": [],
 "title": "乳腺炎皮肤溃疡"
 
 */

@property (strong, nonatomic) NSString *caseDetailId;
@property (strong, nonatomic) NSString *boardId;
@property (strong, nonatomic) NSString *boardTitle;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *parent;
@property (strong, nonatomic) NSString *root;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *postTime;
@property (strong, nonatomic) NSString *user;
@property (strong, nonatomic) NSString *floor;
@property (assign, nonatomic) BOOL warning;
@property (strong, nonatomic) NSString *eMoney;
@property (strong, nonatomic) NSString *score;
@property (strong, nonatomic) NSString *imagesInfo;
@property (strong, nonatomic) NSString *prefix;
@property (assign, nonatomic) BOOL good;
@property (strong, nonatomic) NSString *votes;
@property (assign, nonatomic) BOOL casePostEnter;
@property (assign, nonatomic) BOOL openAppForReply;
@property (strong, nonatomic) NSString *favs;
@property (assign, nonatomic) BOOL favorited;
@property (assign, nonatomic) BOOL voted;
@property (assign, nonatomic) BOOL hasAttachment;
@property (strong, nonatomic) NSString *attachment;
@property (strong, nonatomic) NSString *title;

-(instancetype)initWithDictionary:(NSDictionary *)dict;


@end
