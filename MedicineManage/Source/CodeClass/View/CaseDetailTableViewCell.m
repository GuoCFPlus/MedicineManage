//
//  CaseDetailTableViewCell.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/6.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "CaseDetailTableViewCell.h"

@implementation CaseDetailTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
//投票
- (IBAction)voteAction:(id)sender {
    
}
//收藏
- (IBAction)collectAction:(id)sender {
    
}
//评论
- (IBAction)reviewAction:(id)sender {
    
}



@end
