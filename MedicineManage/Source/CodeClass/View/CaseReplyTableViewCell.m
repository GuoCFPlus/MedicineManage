//
//  CaseReplyTableViewCell.m
//  MedicineManage
//
//  Created by lanou3g on 16/1/6.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import "CaseReplyTableViewCell.h"

@implementation CaseReplyTableViewCell

- (void)awakeFromNib {
    // Initialization code
    //无色
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)replyAction:(id)sender {
    
}


@end
