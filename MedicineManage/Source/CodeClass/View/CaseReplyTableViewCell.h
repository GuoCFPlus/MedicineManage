//
//  CaseReplyTableViewCell.h
//  MedicineManage
//
//  Created by lanou3g on 16/1/6.
//  Copyright © 2016年 gcf. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CaseReplyTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *postTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *voteButton;
@property (weak, nonatomic) IBOutlet UILabel *voteCountLabel;
@property (weak, nonatomic) IBOutlet UIButton *favirateButton;
@property (weak, nonatomic) IBOutlet UILabel *favirateCountLabel;

@end
