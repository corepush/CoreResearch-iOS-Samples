//
//  AppDelegate.h
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CorePush/CorePushManager.h>
#import <CorePush/CorePushAnalyticsManager.h>
#import <CorePush/CorePushConfig.h>
#import "CoreResearchConst.h"
#import "QuestionnaireViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, CorePushManagerDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

