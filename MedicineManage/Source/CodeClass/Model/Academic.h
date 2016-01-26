//
//  Academic.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/6.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Academic : NSObject
@property ( nonatomic, strong) NSString *canComment;
@property ( nonatomic, strong) NSString *canEdit;
@property ( nonatomic, strong) NSString *canPushToWall;
@property ( nonatomic, strong) NSString *canReply;
@property ( nonatomic, strong) NSString *city;
@property ( nonatomic, strong) NSString *commentCount;
@property ( nonatomic, strong) NSString *commentFeed;
@property ( nonatomic, strong) NSString *content;
//@property ( nonatomic, strong) NSDictionary *content;
@property ( nonatomic, strong) NSString *createTime;
@property ( nonatomic, strong) NSString *date;
@property ( nonatomic, strong) NSString *dispalyThumpub;
@property ( nonatomic, strong) NSString *displayFloor;
@property ( nonatomic, strong) NSString *doctor;
@property ( nonatomic, strong) NSString *doctorStatus;
@property ( nonatomic, strong) NSString *expert;
@property ( nonatomic, strong) NSString *expertStatus;
@property ( nonatomic, strong) NSString *expertUser;
@property ( nonatomic, strong) NSString *floor;
@property ( nonatomic, strong) NSString *followerCount;
@property ( nonatomic, strong) NSString *groupId;
@property ( nonatomic, strong) NSString *academicId;
@property ( nonatomic, strong) NSString *infoAvatar;
@property ( nonatomic, strong) NSString *infoStatus;
@property ( nonatomic, strong) NSString *infoUserId;
@property ( nonatomic, strong) NSString *infoUsername;
@property ( nonatomic, strong) NSString *manyQuote;
@property ( nonatomic, strong) NSString *onTheWall;
@property ( nonatomic, strong) NSString *orgUser;
@property ( nonatomic, strong) NSString *paperContent;
@property ( nonatomic, strong) NSString *quoteCommentCount;
@property ( nonatomic, strong) NSString *quoteContent;
@property ( nonatomic, strong) NSString *quoteCreateTime;
@property ( nonatomic, strong) NSString *quoteDate;
@property ( nonatomic, strong) NSString *quoteId;
@property ( nonatomic, strong) NSString *quoteSource;
@property ( nonatomic, strong) NSString *quoteTid;
@property ( nonatomic, strong) NSString *recommendFeed;
@property ( nonatomic, strong) NSString *reply;
@property ( nonatomic, strong) NSString *replyTo;
@property ( nonatomic, strong) NSString *rootContent;
@property ( nonatomic, strong) NSString *rootCreateTime;
@property ( nonatomic, strong) NSString *rootDate;
@property ( nonatomic, strong) NSString *rootId;
@property ( nonatomic, strong) NSString *rootSource;
@property ( nonatomic, strong) NSString *rootTid;
@property ( nonatomic, strong) NSString *score;
@property ( nonatomic, strong) NSString *section;
@property ( nonatomic, strong) NSString *showVicon;
@property ( nonatomic, strong) NSString *source;
@property ( nonatomic, strong) NSString *sourceDesc;
@property ( nonatomic, strong) NSString *sourceLink;
@property ( nonatomic, strong) NSString *sourceTitle;
@property ( nonatomic, strong) NSString *specialTopicInfo;
@property ( nonatomic, strong) NSString *templateContent;
@property ( nonatomic, strong) NSString *thumbs;
@property ( nonatomic, strong) NSString *tid;
@property ( nonatomic, strong) NSString *userId;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
