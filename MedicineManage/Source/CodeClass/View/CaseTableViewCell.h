//
//  CaseTableViewCell.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/4.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
