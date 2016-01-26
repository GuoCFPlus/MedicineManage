//
//  CaseCell.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/8.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "CaseCell.h"

@implementation CaseCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.bgView = [[UIView alloc]initWithFrame:CGRectMake(0, kGap/2, kScreenWidth, self.frame.size.height - kGap/2)];
    self.bgView.backgroundColor = [UIColor whiteColor];
    
    self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(kGap, kGap, kCellWidth, kLineHeight)];
    self.titleLabel.numberOfLines = 0;
    //设置为加粗15号
    self.titleLabel.font = [UIFont boldSystemFontOfSize:kFontSize];
    self.titleLabel.text = @"标题";
    [self.bgView addSubview:self.titleLabel];
    
    
    self.authorLabel = [[UILabel alloc]initWithFrame:CGRectMake(kGap, CGRectGetMaxY(self.titleLabel.frame)+kGap, kCellWidth, kLineHeight)];
    self.authorLabel.numberOfLines = 1;
    self.authorLabel.font = [UIFont systemFontOfSize:kFontSize_s];
    self.titleLabel.text = @"用户名  投票/点击";
    [self.bgView addSubview:self.authorLabel];
    
    self.contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(kGap, CGRectGetMaxY(self.authorLabel.frame)+kGap, kCellWidth, kLineHeight)];
    self.contentLabel.numberOfLines = 3;
    self.contentLabel.font = [UIFont systemFontOfSize:kFontSize];
    self.contentLabel.text = @"内容";
    [self.bgView addSubview:self.contentLabel];
    
    self.imgInfoView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.contentLabel.frame)+kGap, kScreenWidth, kCellImageWidth)];
    [self.bgView addSubview:self.imgInfoView];
    
    self.contentImage1 = [[UIImageView alloc]initWithFrame:CGRectMake(kGap, 0, kCellImageWidth, kCellImageWidth)];
    self.contentImage1.image = [UIImage imageNamed:@"AppIcon60x60"];
    [self.imgInfoView addSubview:self.contentImage1];
    
    self.contentImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.contentImage1.frame)+kGap, 0, kCellImageWidth, kCellImageWidth)];
    self.contentImage2.image = [UIImage imageNamed:@"AppIcon60x60"];
    self.contentImage2.hidden = YES;
    [self.imgInfoView addSubview:self.contentImage2];
    
    [self.contentView addSubview:self.bgView];
    
}


- (void)awakeFromNib {
    // Initialization code
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
