//
//  AcademicTableViewCell.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/4.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AcademicTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *categoryLabel;

@end
