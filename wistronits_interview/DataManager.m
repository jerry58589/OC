//
//  DataManager.m
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import "DataManager.h"
#import "OpenApi.h"

@implementation DataManager

+ (instancetype)shared {
    static DataManager *testObject = nil;
    if(testObject == nil) {
        testObject = [[DataManager alloc]init];
        _oaAPI = [OpenApi alloc];
    }
    return testObject;
}

OpenApi *_oaAPI;

- (void)getProfile:(void (^)(NSDictionary * profile))Completion {
    [_oaAPI getDataFrom:Profile WithSuccessComplete:^(NSDictionary *response){
        Completion(response[@"response"][0]);
    }];
}

- (void)getNoFriends:(void (^)(NSArray * friendList))Completion {
    [_oaAPI getDataFrom:NoFrieds WithSuccessComplete:^(NSDictionary *response){
        Completion(response[@"response"]);
    }];
}

- (void)getAllFriend:(void (^)(NSArray * allFrien))Completion {
    NSMutableArray * allFriend = [[NSMutableArray alloc]init];
    
    [_oaAPI getDataFrom:FirendList1 WithSuccessComplete:^(NSDictionary *response1){
        [allFriend setArray:response1[@"response"]];
        [_oaAPI getDataFrom:FirendList2 WithSuccessComplete:^(NSDictionary *response2){
            
            NSMutableArray * friendList2 = [[NSMutableArray alloc]initWithArray:response2[@"response"]];
            
            for (int i = 0; i < [friendList2 count]; i++) {
                NSMutableDictionary* friendInfo = [[NSMutableDictionary alloc] initWithDictionary:[friendList2 objectAtIndex:i]];
                
                [friendInfo setObject:[friendInfo[@"updateDate"]  stringByReplacingOccurrencesOfString:@"/" withString:@""] forKey:@"updateDate"];
                
                BOOL containsUser = NO;
                for (int j = 0; j < [allFriend count]; j++) {
                    NSDictionary* allFriendInfo = [[NSDictionary alloc] initWithDictionary:[allFriend objectAtIndex:j]];

                    if (allFriendInfo[@"fid"] == friendInfo[@"fid"]) {
                        containsUser = YES;
                        
                        if ([allFriendInfo[@"updateDate"] intValue] < [friendInfo[@"updateDate"] intValue]) {
                            allFriend[j] = friendInfo;
                        }
                    }
                }
                
                if (!containsUser) {
                    [allFriend addObject:friendInfo];
                }
            }
            
            Completion(allFriend);
        }];
    }];
}

- (void)getFriendsAndInvites:(void (^)(NSArray * friendList, NSArray * inviteList))Completion {
    [_oaAPI getDataFrom:FriendAndInvite WithSuccessComplete:^(NSDictionary *response){
        // status = 2 -> inviteList
        NSMutableArray * friendList = [[NSMutableArray alloc]init];
        NSMutableArray * inviteList = [[NSMutableArray alloc]init];

        for(NSDictionary *info in response[@"response"]) {
            if ([info[@"status"] isEqualToNumber:@2]) {
                [inviteList addObject:info];
            }
            else {
                [friendList addObject:info];
            }
        }
        
        Completion(friendList, inviteList);
    }];
}



@end
