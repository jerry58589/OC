//
//  OpenApi.h
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef enum: NSUInteger {
    Profile,
    FirendList1,
    FirendList2,
    FriendAndInvite,
    NoFrieds
} ApiType;



@interface OpenApi : NSObject
- (void)getDataFrom:(ApiType)type WithSuccessComplete:(void (^)(NSDictionary *response))successCompletion;


@end

NS_ASSUME_NONNULL_END
