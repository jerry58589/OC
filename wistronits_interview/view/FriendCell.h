//
//  FriendCell.h
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/10.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FriendCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *transferView;
@property (weak, nonatomic) IBOutlet UIView *transferContentview;
@property (weak, nonatomic) IBOutlet UIView *inviteView;
@property (weak, nonatomic) IBOutlet UIView *inviteContentview;
@property (weak, nonatomic) IBOutlet UIView *moreView;
@property (weak, nonatomic) IBOutlet UIImageView *starImgView;
@property (weak, nonatomic) IBOutlet UILabel *name;


@end

NS_ASSUME_NONNULL_END
