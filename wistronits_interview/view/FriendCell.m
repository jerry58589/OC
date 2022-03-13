//
//  FriendCell.m
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/10.
//

#import "FriendCell.h"

@implementation FriendCell

- (void)awakeFromNib {
    [super awakeFromNib];

    self.transferContentview.layer.borderWidth = 1;
    self.transferContentview.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:0/255.0f blue:140.0f/255.0f alpha:1.0f].CGColor;
    self.transferContentview.layer.cornerRadius = 2;
    self.transferContentview.layer.masksToBounds = YES;
    
    self.inviteContentview.layer.borderWidth = 1;
    self.inviteContentview.layer.borderColor = [UIColor colorWithRed:201.0f/255.0f green:201.0f/255.0f blue:201.0f/255.0f alpha:1.0f].CGColor;
    self.inviteContentview.layer.cornerRadius = 2;
    self.inviteContentview.layer.masksToBounds = YES;
    
    [self.inviteView setHidden:YES];
    [self.moreView setHidden:YES];
    [self.starImgView setHidden:YES];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
