//
//  AcademicTableViewCell.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/4.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "AcademicTableViewCell.h"

@implementation AcademicTableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    self.headerImageView.layer.cornerRadius = self.headerImageView.frame.size.width/2;
    self.headerImageView.layer.masksToBounds = YES;
    
    self.userNameLabel.textColor = kColor;
    self.categoryLabel.textColor = kColor;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
