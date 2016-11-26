//
//  TokenUnregisterViewController.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "TokenUnregisterViewController.h"

@interface TokenUnregisterViewController ()

@end

@implementation TokenUnregisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"トークン削除";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivedUnregisterSuccessNotification:) name:CorePushManagerUnregisterTokenRequestSuccessNotification object:nil];
    
    [self updateTokenLabel];
}

- (void)updateTokenLabel{
    //フォアグランド起動時にデバイストークンを送信
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSString* deviceToken = [defaults objectForKey:CorePushDeviceTokenKey];
    
    if (deviceToken != nil && ![deviceToken isEqualToString:@""]) {
        self.tokenLabel.text = [NSString stringWithFormat:@"デバイストークン： %@",deviceToken];
    } else {
        self.tokenLabel.text = @"デバイストークン： 空";
    }
}

- (IBAction)unregisterAction{
    //*********************************************************************************************
    // プッシュ通知の有効化フラグをNOに設定
    //*********************************************************************************************
    [[CorePushManager shared] setPushEnabled:NO];
    
    //*********************************************************************************************
    // デバイストークンをcore-aspサーバから削除
    //*********************************************************************************************
    [[CorePushManager shared] unregisterDeviceToken];
}

- (void)didReceivedUnregisterSuccessNotification:(NSNotification*)notification {
    [self updateTokenLabel];
}

@end
