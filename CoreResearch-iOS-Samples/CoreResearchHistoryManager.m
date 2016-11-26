//
//  CoreResearchHistoryManager.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "CoreResearchHistoryManager.h"
#import "CoreResearchUtil.h"

@implementation CoreResearchHistoryManager

static id shared = nil;

+ (id)shared {
    @synchronized(self) {
        if (shared == nil) {
            shared = [[self alloc] init];
        }
    }
    return shared;
}

- (void)requestHistory:(CallbackHandler)handler {
    NSString *urlString = CoreResearchHistoryApi;
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];

    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] initWithURL:url cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
    request.HTTPMethod = @"POST";

    // リクエストパラメータ
    NSDictionary* params = @{
                             @"config_type": @"1",
                             @"config_key": ConfigKey
                             };
    
    request.HTTPBody = [CoreResearchUtil HTTPBodyData:params];
    
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
            if (httpResponse.statusCode == 200) {
                NSError *jsonError;
                
                NSDictionary* dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&jsonError];
                
                NSArray *array = [dict objectForKey:@"results"];
                
                if (handler) {
                    handler(array);
                }
            }
        } else {
            NSLog(@"error");
        }
    }];
    [dataTask resume];
}


@end
