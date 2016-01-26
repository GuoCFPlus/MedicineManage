//
//  CaseDetailCell.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/9.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseDetailCell : UITableViewCell

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) WKWebView *contentWebView;
@property (strong, nonatomic) UILabel *authorLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIButton *votesButton;
@property (strong, nonatomic) UILabel *votesLabel;
@property (strong, nonatomic) UIButton *collectButton;
@property (strong, nonatomic) UILabel *collectLabel;
@property (strong, nonatomic) UIButton *reviewButton;

@end
