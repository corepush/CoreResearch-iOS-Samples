//
//  CoreResearchUtil.h
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
    ユーティリティクラス
 */
@interface CoreResearchUtil : NSObject

/**
 パラメータの辞書データをHTTPBodyのDataオブジェクトに変換する
 */
+ (NSData*)HTTPBodyData:(NSDictionary*)params;

@end
