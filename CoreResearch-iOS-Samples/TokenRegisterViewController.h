//
//  TokenRegisterViewController.h
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreResearchConst.h"
#import <CorePush/CorePushConfig.h>
#import <CorePush/CorePushManager.h>

@interface TokenRegisterViewController : UIViewController

@property(nonatomic)IBOutlet UIButton* registerButton;
@property(nonatomic)IBOutlet UILabel* tokenLabel;

-(IBAction) registerAction;

@end
