//
//  DataManager.h
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject
+ (instancetype) shared;

- (void)getProfile:(void (^)(NSDictionary *profile))Completion;
- (void)getNoFriends:(void (^)(NSArray *friendList))Completion;
- (void)getAllFriend:(void (^)(NSArray *allFriend))Completion;
- (void)getFriendsAndInvites:(void (^)(NSArray *friendList, NSArray *inviteList))Completion;

@end

NS_ASSUME_NONNULL_END
