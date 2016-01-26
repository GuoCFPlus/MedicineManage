//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h

#import "CoreDataTools.h"

#import "LoginViewController.h"
#import "RegisterViewController.h"
#import "FindPasswordViewController.h"

#import "AcademicTableViewController.h"
#import "AcademicTableViewCell.h"
#import "ImageInfo.h"
#import "Academic.h"

#import "CaseTableViewController.h"
#import "CaseTableViewCell.h"
#import "CaseCell.h"
#import "CaseInfo.h"
#import "CaseDetailTableViewController.h"
#import "CaseDetailTableViewCell.h"
#import "CaseReplyTableViewCell.h"
#import "CaseDetailInfo.h"

#import "ForumTableViewController.h"
#import "MessageTableViewController.h"
#import "UserInfoTableViewController.h"



//#4F46A0   79 70 160
#define kColor [UIColor colorWithRed:79/255.0 green:70/255.0 blue:160/255.0 alpha:1]
#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kGap 10
#define kGap_2 5
#define kCellWidth (kScreenWidth - 2*kGap)
#define kLineHeight 21
#define kFontSize 15
#define kFontSize_s 13
#define kCellImageWidth 80

#endif
