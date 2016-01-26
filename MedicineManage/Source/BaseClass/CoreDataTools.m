//
//  CoreDataTools.m
//  MusicPlayer_test1
//
//  Created by lanou3g on 15/12/28.
//  Copyright © 2015年 gcf. All rights reserved.
//

#import "CoreDataTools.h"

@implementation CoreDataTools


+(instancetype)shareCoreData{
    static CoreDataTools *coreData = nil;
    if (coreData == nil) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            coreData = [[CoreDataTools alloc]init];
        });
    }
    return coreData;
}

-(instancetype)init{
    if (self = [super init]) {
        //协调器->数据模型
        NSManagedObjectModel *model = [NSManagedObjectModel mergedModelFromBundles:nil];
        //根据model初始化一个协调器
        NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        //创建一个上下文对象
        self.context = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
        //该上下文对象的协调器指向我们刚才创建的协调器
        self.context.persistentStoreCoordinator = persistentStoreCoordinator;
        //创建数据库
        NSString *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
        NSLog(@"%@",documentPath);
        NSString *dataBasePath = [documentPath stringByAppendingPathComponent:@"MedicineManage.sqlite" ];
        
        [persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:[NSURL fileURLWithPath:dataBasePath] options:nil error:nil];
    }
    return self;
}


@end
