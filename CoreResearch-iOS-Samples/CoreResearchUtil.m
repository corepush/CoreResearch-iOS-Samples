//
//  CoreResearchUtil.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "CoreResearchUtil.h"

@implementation CoreResearchUtil

+ (NSData*)HTTPBodyData:(NSDictionary*)params {
    __block NSString* bodyDataString = @"";
    
    NSArray* allKeys = [params allKeys];
    [allKeys enumerateObjectsUsingBlock:^(NSString *key, NSUInteger index, BOOL *stop) {
        NSString* value = params[key];
        bodyDataString = [bodyDataString stringByAppendingString:[NSString stringWithFormat:@"%@=%@", key, value]];
        
        if (index != params.count) {
            bodyDataString = [bodyDataString stringByAppendingString:@"&"];
        }
    }];
    
    return [bodyDataString dataUsingEncoding:NSUTF8StringEncoding];
}

@end
