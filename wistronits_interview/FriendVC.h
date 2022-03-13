//
//  FriendVC.h
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSUInteger {
    NoFriend,
    NoInvite,
    HasInvite,
} FriendType;


@interface FriendVC : UIViewController <UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (weak, nonatomic) IBOutlet UILabel *myKOID;
@property (weak, nonatomic) IBOutlet UIView *noFriendView;
@property (weak, nonatomic) IBOutlet UITableView *inviteTableView;
@property (weak, nonatomic) IBOutlet UITableView *friendsTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inviteTVHeight;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UISwitch *shrinkSwitch;
@property (weak, nonatomic) IBOutlet UIView *addFriendBtnView;

@property (nonatomic, strong) NSMutableArray *inviteArray;
@property (nonatomic, strong) NSMutableArray *friendArray;
@property (nonatomic, strong) NSMutableArray *searchFriendArray;

@property (assign, nonatomic) FriendType type;
@property (nonatomic) BOOL isShrink;

@end

NS_ASSUME_NONNULL_END
