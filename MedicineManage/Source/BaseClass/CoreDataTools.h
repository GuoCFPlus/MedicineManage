//
//  CoreDataTools.h
//  MusicPlayer_test1
//
//  Created by lanou3g on 15/12/28.
//  Copyright © 2015年 gcf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CoreDataTools : NSObject

//定义上下文
@property (strong, nonatomic) NSManagedObjectContext *context;

+(instancetype)shareCoreData;

@end
