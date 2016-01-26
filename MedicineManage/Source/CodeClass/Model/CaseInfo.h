//
//  CaseInfo.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/5.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CaseInfo : NSObject

/*
 "boardId": 48,
 "body": "      中年男性，有乙肝病史，腹痛伴肛门排气排便停止4天入院，入院时下腹可见肠形，无腹膜炎体征，有气过水声，CT提示小肠梗阻（小肠粘连于盆腔），予胃肠减压、润肠通便后，患者腹痛消失，有较正常的排气排便，但腹部仍咕咕作响，肠鸣音活跃，腹部无明显膨隆，无其他明显阳性体征，复查腹部立位片仍有明显的小肠扩张及液气平面等梗阻表现。追问病史，患者数个月前就有腹部轻微胀气，咕咕作响，但饮食及大便均较正常，直至入院前腹痛发作，曾有较长时间的服用中药史，有泌尿系感染史，曾在泌尿外住院治疗好转，有胆囊结石史（无胆绞痛史，未诊治），否认腹部外伤及阑尾炎",
 "click": 73,
 "createTime": null,
 "deleted": 0,
 "favorite": 0,
 "id": 32567831,
 "imageInfo": null,
 "modifyTime": null,
 "parent": 0,
 "postTime": 1451046900000,
 "rating": 0,
 "reply": 0,
 "root": 32567831,
 "subject": "【求助】小肠粘连患者",
 "type": 1000,
 "userId": 1913425,
 "username": "jianghaolu",
 "votes": 0
 */

@property (strong, nonatomic) NSString *boardId;
@property (strong, nonatomic) NSString *body;
@property (strong, nonatomic) NSString *click;
@property (strong, nonatomic) NSString *createTime;
@property (strong, nonatomic) NSString *deleted;
@property (strong, nonatomic) NSString *favorite;
@property (strong, nonatomic) NSString *caseId;
//@property (strong, nonatomic) NSString *imageInfo;
@property (strong, nonatomic) NSArray *imageInfo;
@property (strong, nonatomic) NSString *modifyTime;
@property (strong, nonatomic) NSString *parent;
@property (strong, nonatomic) NSString *postTime;
@property (strong, nonatomic) NSString *rating;
@property (strong, nonatomic) NSString *reply;
@property (strong, nonatomic) NSString *root;
@property (strong, nonatomic) NSString *subject;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *userId;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *votes;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
