//
//  InviteCell.m
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import "InviteCell.h"

@implementation InviteCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _cardView.layer.cornerRadius = 6;
    _cardView.layer.shadowRadius = 6;
    _cardView.layer.shadowColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2].CGColor;
    _cardView.layer.shadowOffset = CGSizeMake(0, 4);
    _cardView.layer.shadowOpacity = 0.7;
    _cardView.layer.masksToBounds = NO;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
