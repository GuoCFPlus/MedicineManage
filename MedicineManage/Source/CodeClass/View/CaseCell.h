//
//  CaseCell.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/8.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseCell : UITableViewCell

@property (strong, nonatomic) UIView *bgView;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *contentLabel;
@property (strong, nonatomic) UIView *imgInfoView;
@property (strong, nonatomic) UIImageView *contentImage1;
@property (strong, nonatomic) UIImageView *contentImage2;


@end
