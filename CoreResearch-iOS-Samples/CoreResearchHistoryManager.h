//
//  CoreResearchHistoryManager.h
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreResearchConst.h"

typedef void (^CallbackHandler)(NSArray *historys);

/**
    アンケート履歴を管理するクラス
 */
@interface CoreResearchHistoryManager : NSObject<NSURLSessionDelegate>

+ (id)shared;

- (void)requestHistory:(CallbackHandler)handler;

@end
