//
//  OpenApi.m
//  wistronits_interview
//
//  Created by JerryLo on 2022/3/9.
//

#import "OpenApi.h"

@implementation OpenApi

- (NSString *)getUrl:(ApiType)type {
    NSString* url = @"";
    switch (type) {
        case Profile:
            url = @"https://dimanyen.github.io/man.json";
            break;
        case FirendList1:
            url = @"https://dimanyen.github.io/friend1.json";
            break;
        case FirendList2:
            url = @"https://dimanyen.github.io/friend2.json";
            break;
        case FriendAndInvite:
            url = @"https://dimanyen.github.io/friend3.json";
            break;
        case NoFrieds:
            url = @"https://dimanyen.github.io/friend4.json";
            break;
        default:
            break;
    }
    
    return url;
}

- (void)getDataFrom:(ApiType)type WithSuccessComplete:(void (^)(NSDictionary *response))successCompletion {
    NSString *url = [self getUrl:type];
    
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString: url]];
   
    [urlRequest setHTTPMethod:@"GET"];

    NSLog(@"GET url= %@", url);
    
    NSURLSession *session = [NSURLSession sharedSession];

    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200) {
           NSError *parseError = nil;
           NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
           NSLog(@"The response is - %@",responseDictionary);
            successCompletion(responseDictionary);
        }
        else {
           NSLog(@"Error");
        }
    }];
    [dataTask resume];
}

@end
