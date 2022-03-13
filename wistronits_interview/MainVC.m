//
//  MainVC.m
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import "MainVC.h"
#import "FriendVC.h"

@interface MainVC ()

@end

@implementation MainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pressedNoFriends:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"FriendVC"];
    vc.type = NoFriend;
    [self.navigationController pushViewController:vc animated:YES];

}

- (IBAction)pressedNoInvite:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"FriendVC"];
    vc.type = NoInvite;
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)pressedHaveInvite:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    FriendVC *vc = [storyboard instantiateViewControllerWithIdentifier:@"FriendVC"];
    vc.type = HasInvite;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
