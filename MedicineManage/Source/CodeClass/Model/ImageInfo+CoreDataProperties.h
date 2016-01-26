//
//  ImageInfo+CoreDataProperties.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/4.
//  Copyright © 2016年 gcf. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ImageInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ImageInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *avatarPath;
@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSNumber *mobilePushId;
@property (nullable, nonatomic, retain) NSString *path;
@property (nullable, nonatomic, retain) NSDate *sortTime;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *url;



@end

NS_ASSUME_NONNULL_END
