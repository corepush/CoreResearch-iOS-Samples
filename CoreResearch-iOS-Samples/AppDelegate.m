//
//  AppDelegate.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    //*********************************************************************************************
    // CorePushManagerクラスの初期化
    //*********************************************************************************************
    [[CorePushManager shared] setConfigKey:ConfigKey];           //コンフィグキーの設定
    [[CorePushManager shared] setDebugEnabled:YES];              //デバッグログを有効化
    [[CorePushManager shared] setDelegate:self];                 //CorePushManagerDelegateの設定
    [[CorePushManager shared] registerForRemoteNotifications];   //通知の登録
    
    //*********************************************************************************************
    // アプリのプロセスが起動していない状態で通知からアプリを起動した時の処理を定義する。
    // launchOptionsに通知のUserInfoが存在する場合は、CorePushManagerDelegate#handleLaunchingNotificationを
    // 呼び出し、存在しない場合は何も行わない。
    //*********************************************************************************************
    [[CorePushManager shared] handleLaunchingNotificationWithOption:launchOptions];
    
    //*********************************************************************************************
    // アイコンバッジ数をリセットする
    //*********************************************************************************************
    [CorePushManager resetApplicationIconBadgeNumber];
    
    return YES;
}

// 通知サービスの登録成功時に呼ばれる。
- (void) application:(UIApplication*) application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    //*********************************************************************************************
    // APNSの通知登録の成功時に呼び出される。デバイストークンをcore-aspサーバに登録する。
    //*********************************************************************************************
    [[CorePushManager shared] registerDeviceToken:deviceToken];
}

// 通知サービスの登録失敗時に呼ばれる。
- (void) application:(UIApplication*) application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    //*********************************************************************************************
    // APNSの通知登録の失敗時に呼び出される。
    // 通知サービスの登録に失敗する場合は、iPhoneシミュレータでアプリを実行しているかプッシュ通知が有効化されていない
    // プロビジョニングでビルドしたアプリを実行している可能性があります。
    //*********************************************************************************************
    NSLog(@"error: %@", [error description]);
}

// アプリが通知を受信した場合に呼ばれる。
- (void) application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    //*********************************************************************************************
    // アプリがフォアグランド・バックグランド状態で動作中に通知を受信した時の動作を定義する。
    // バックラウンド状態で通知を受信後に通知からアプリを起動した場合、
    // CorePushManagerDelegate#handleBackgroundNotificationが呼び出されます。
    // フォアグランド状態で通知を受信した場合、CorePushManagerDelegate#handleForegroundNotificationが呼び出されます。
    //*********************************************************************************************
    [[CorePushManager shared] handleRemoteNotification:userInfo];
    
    //*********************************************************************************************
    // アイコンバッジ数をリセットする
    //*********************************************************************************************
    [CorePushManager resetApplicationIconBadgeNumber];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    [application registerForRemoteNotifications];
}

- (void)handleLaunchingNotification:(NSDictionary *)userInfo {
    //*********************************************************************************************
    // アプリが停止中に通知からアプリを起動した時の動作を定義
    //*********************************************************************************************
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showQuestionnaireView:userInfo];
    });

}

- (void)handleBackgroundNotification:(NSDictionary*)userInfo {
    //*********************************************************************************************
    // アプリがバックグランドで動作中に通知からアプリを起動した時の動作を定義
    //*********************************************************************************************
    [self showQuestionnaireView:userInfo];
}

- (void)handleForegroundNotifcation:(NSDictionary*)userInfo {
    //*********************************************************************************************
    // アプリがフォアグランドで動作中に通知を受信した時の動作を定義
    //*********************************************************************************************
    [self showQuestionnaireView:userInfo];
}

- (void)showQuestionnaireView:(NSDictionary*)userInfo {
    
    // 通知がアンケート通知であるかを判定する。
    // userInfoオブジェクトからアンケート通知を表すCoreResearchキーの値を取得する。
    // 取得した値が1の場合は、アンケート通知と判定する。
    NSString* coreReseachFlag = [userInfo objectForKey:@"CoreResearch"];
    if (coreReseachFlag == nil || ![coreReseachFlag isEqualToString:@"1"]) {
        return;
    }
    
    // userInfoオブジェクトからアンケート通知のURLを取得
    NSString* url = [userInfo objectForKey:@"url"];
    if ( url == nil || [url isEqualToString:@""]) {
        return;
    }

    // 取得したアンケート用のURL文字列に プラットフォーム種別を表す値(ios)とuuidの値を追加する
    NSString* uuid = [[CorePushManager shared] uuid];
    NSString* questionnaireUrl = [NSString stringWithFormat:@"%@&pf=ios&cruuid=%@", url, uuid];
        QuestionnaireViewController *controller = [[QuestionnaireViewController alloc]initWithNibName:@"QuestionnaireViewController" bundle:nil];
        controller.urlString = questionnaireUrl;
    
    // 現在表示中の画面上にアンケート画面を表示する
    [[AppDelegate topMostViewController] presentViewController:controller animated:YES completion:nil];
}

+ (UIViewController*)topMostViewController {
    // keyWindowの最上位のビューコントローラを取得
    UIViewController* topViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    while (topViewController.presentedViewController) {
        topViewController = topViewController.presentedViewController;
    }
    
    return topViewController;
}

@end
