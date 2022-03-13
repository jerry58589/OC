//
//  FriendVC.m
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import "FriendVC.h"
#import "DataManager.h"
#import "InviteCell.h"
#import "FriendCell.h"

@interface FriendVC () {
    UIRefreshControl *refreshControl;
}

@end

@implementation FriendVC

const int inviteCellHeight = 80;
const int friendCellHeight = 60;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
}

- (void)setupUI {
    _addFriendBtnView.layer.cornerRadius = 20;
    _addFriendBtnView.layer.masksToBounds = YES;
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = _addFriendBtnView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor colorWithRed:86.0f/255.0f green:179.0f/255.0f blue:11.0f/255.0f alpha:1.0f] CGColor], (id)[[UIColor colorWithRed:166.0f/255.0f green:204.0f/255.0f blue:66.0f/255.0f alpha:1.0f] CGColor], nil];
    gradient.startPoint = CGPointMake(0, 0.5);
    gradient.endPoint = CGPointMake(1, 0.5);
    [_addFriendBtnView.layer insertSublayer:gradient atIndex:0];
    
    _inviteTableView.scrollEnabled = NO;
    _inviteTableView.separatorColor = [UIColor clearColor];
    [_searchBar.searchTextField setFont: [UIFont systemFontOfSize:14]];
    [_searchBar setBackgroundImage:[[UIImage alloc] init]];
    [_searchBar setTranslucent:NO];
    [_searchBar setTintColor:[UIColor clearColor]];
    [self setInviteTableViewHeight];

    [self.inviteTableView registerNib:[UINib nibWithNibName:@"InviteCell" bundle:nil] forCellReuseIdentifier:@"InviteCell"];
    [self.friendsTableView registerNib:[UINib nibWithNibName:@"FriendCell" bundle:nil] forCellReuseIdentifier:@"FriendCell"];

    self.inviteTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.friendsTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    UITapGestureRecognizer *tap =
      [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(searchBarEndEditing)];
    [self.view addGestureRecognizer:tap];
    
    refreshControl = [[UIRefreshControl alloc] init];
    [self.friendsTableView setRefreshControl:refreshControl];
    [refreshControl addTarget:self action:@selector(getApiData) forControlEvents:UIControlEventValueChanged];

    [self updateUI];

    [[DataManager shared] getProfile:^(NSDictionary *proflie){
        dispatch_async(dispatch_get_main_queue(), ^{
            self.myName.text = proflie[@"name"];
            self.myKOID.text = proflie[@"kokoid"];
        });
    }];
    
    [self getApiData];
}

- (void)getApiData {
    if (_type == NoFriend) {
        [[DataManager shared] getNoFriends:^(NSArray *friendList){
            NSLog(@"NoFriend data =%@", friendList);

            self.friendArray = [friendList mutableCopy];
            self.searchFriendArray = [friendList mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUI];
                [self->refreshControl endRefreshing];
            });
        }];
    }
    else if (_type == NoInvite) {
        [[DataManager shared] getAllFriend:^(NSArray *friendList) {
            NSLog(@"NoInvite data =%@", friendList);

            self.friendArray = [friendList mutableCopy];
            self.searchFriendArray = [friendList mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self updateUI];
                [self->refreshControl endRefreshing];
            });
        }];
    }
    else if (_type == HasInvite) {
        [[DataManager shared] getFriendsAndInvites:^(NSArray *friendList, NSArray *inviteList) {
            NSLog(@"HasInvite data =%@%@", friendList, inviteList);
            
            self.friendArray = [friendList mutableCopy];
            self.inviteArray = [inviteList mutableCopy];
            self.searchFriendArray = [friendList mutableCopy];

            dispatch_async(dispatch_get_main_queue(), ^{
                [self setInviteTableViewHeight];
                [self updateUI];
                [self->refreshControl endRefreshing];
            });
        }];
    }
}

- (void)updateUI {
    [_friendsTableView setHidden: _friendArray.count == 0];
    [_noFriendView setHidden:_friendArray.count != 0];
    [_searchView setHidden: _friendArray.count == 0];
    [_shrinkSwitch setHidden: _inviteArray.count == 0];
    
    [_friendsTableView reloadData];
    [_inviteTableView reloadData];
}

- (void)searchBarEndEditing {
    [_searchBar endEditing:YES];
    [self updateUI];
}

- (void)setInviteTableViewHeight{
    if (!_shrinkSwitch.on) {
        _inviteTVHeight.constant = 0;
    }
    else {
        _inviteTVHeight.constant = inviteCellHeight * _inviteArray.count;
    }
}

- (IBAction)shrinkSwitchPressed:(id)sender {
    [_inviteTableView setHidden: !_shrinkSwitch.on];
    [self setInviteTableViewHeight];
}

// MARK: TableView delegate
- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (tableView == _inviteTableView) {
        NSDictionary *invitInfo = [[NSDictionary alloc] initWithDictionary:_inviteArray[indexPath.row]];
        InviteCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InviteCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name.text = invitInfo[@"name"];
        return cell;
    }
    else {
        NSDictionary *friendInfo = [[NSDictionary alloc] initWithDictionary:_searchFriendArray[indexPath.row]];
        FriendCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FriendCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name.text = friendInfo[@"name"];
        
        if ([friendInfo[@"isTop"] isEqualToString:@"1"]) {
            [cell.starImgView setHidden:NO];
        }
        
        if ([friendInfo[@"status"] isEqualToNumber:@0]) {
            [cell.inviteView setHidden:NO];
        }
        else if ([friendInfo[@"status"] isEqualToNumber:@1]) {
            [cell.moreView setHidden:NO];
        }
        
        return cell;
    }
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _inviteTableView) {
        return _inviteArray.count;
    }
    return _searchFriendArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == _inviteTableView) {
        return inviteCellHeight;
    }
    return friendCellHeight;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [self searchBarEndEditing];
}

// MARK: SearchBar delegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText length] > 0) {
        [_searchFriendArray removeAllObjects];
        for (NSDictionary *info in _friendArray) {
            if ([info[@"name"] containsString:searchText]) {
                [_searchFriendArray addObject:info];
            }
        }
    }
    else {
        _searchFriendArray = [_friendArray mutableCopy];
    }
    
    [self updateUI];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self searchBarEndEditing];
}

@end
