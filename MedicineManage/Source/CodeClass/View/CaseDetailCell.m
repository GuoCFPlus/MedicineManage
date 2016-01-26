//
//  CaseDetailCell.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/9.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "CaseDetailCell.h"

@implementation CaseDetailCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    //无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kGap, kGap, kCellWidth, kLineHeight)];
    self.titleLabel.text = @"标题";
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.font = [UIFont systemFontOfSize:kFontSize weight:kFontSize];
    [self.contentView addSubview:self.titleLabel];
    
    self.contentWebView = [[WKWebView alloc]initWithFrame:CGRectMake(kGap, CGRectGetMaxY(self.titleLabel.frame)+kGap, kCellWidth, kLineHeight)];
    [self.contentView addSubview:self.contentWebView];
    
    self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(kGap, CGRectGetMaxY(self.contentWebView.frame), kCellWidth, kLineHeight)];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
