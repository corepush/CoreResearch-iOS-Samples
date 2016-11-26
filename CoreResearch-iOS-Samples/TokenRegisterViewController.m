//
//  TokenRegisterViewController.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "TokenRegisterViewController.h"

@interface TokenRegisterViewController ()

@end

@implementation TokenRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"トークン登録";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didReceivedRegisterSuccessNotification:) name:CorePushManagerRegisterTokenRequestSuccessNotification object:nil];
    
    [self updateTokenLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (IBAction)registerAction{
    //*********************************************************************************************
    // プッシュ通知の有効化フラグをYESに設定
    //*********************************************************************************************
    [[CorePushManager shared] setPushEnabled:YES];
    
    //*********************************************************************************************
    // 通知の登録・デバイストークンをcore-aspサーバに登録
    //*********************************************************************************************
    [[CorePushManager shared] registerForRemoteNotifications];
}

- (void)didReceivedRegisterSuccessNotification:(NSNotification*)notification {
    [self updateTokenLabel];
}

@end
