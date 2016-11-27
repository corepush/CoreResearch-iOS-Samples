Core Research iOS Samples

###  概要
<div>CORE RESEARCHの機能のサンプルプロジェクトを提供します。</div>
<div>本プロジェクトでは、以下のサンプルを提供しています。</div>

* トークン登録
  * SDKを使用して、iOSのデバイストークンを登録するサンプルコード
* トークン削除
  * SDKを使用して、iOSのデバイストークンを削除するサンプルコード
* 通知履歴取得
  * <a href="http://developer.core-asp.com/research_history.php">通知履歴取得API</a>を使用して、通知履歴を取得するサンプルコード
* アンケート表示
  * プッシュ通知を使用して、アンケート画面を表示するサンプルコード

<p>各APIの詳細については、<a href="http://developer.core-asp.com/index.php">Core Push Developer Support</a>の<a href="http://developer.core-asp.com/api_token.php">CORE ASP API</a>をご参照ください。</p>

### 前提
  * iOSのバージョン8.0以上で動作します。
  * 言語はObjective-Cを使用しています。
  * Xcode8.0以上で動作します。
  * CORE PUSH SDKを使用しています。SDKのバージョンは、CoreResearch対応版のv3.8以上を使用してください。
  * CORE PUSHの設定キーが必要になります。CORE PUSHの管理画面でアプリの設定キーをご確認できます。
  設定キーの設定については、<a href="#config_key">CORE PUSHの設定キーの設定</a>をご参照ください。

### <div id="config_key">CORE PUSHの設定キーの設定</div>
* CORE PUSHの管理画面で確認したアプリの設定キーを CoreResearchConst.m内のConfigKeyキーの値に指定してください。

```
// CORE PUSHの設定キー
NSString* ConfigKey = @"＜管理画面内のアプリの設定キーの値＞";
```
### <div id="research_notification">アンケート通知</div>
* アンケートの通知を受信した場合、通知のuserInfoオブジェクトに CoreResearch プロパティキーが 文字列値 "1" として設定されています。
通知の種類がアンケート通知か通常の通知であるを判断する場合は、CoreResearchのプロパティキーの値をもとに判別をしてください。

```    
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
```
* アンケート通知を受信した場合、通知のuserInfoオブジェクトの urlプロパティキーに アンケート表示用のurlが設定されています。

```
// userInfoオブジェクトからアンケート通知のURLを取得
NSString* url = [userInfo objectForKey:@"url"];
if ( url == nil || [url isEqualToString:@""]) {
    return;
}
```

### <div id="research_display">アンケート表示</div>

* <a href="#research_notification">アンケート通知</a>や<a href="#research_history">アンケート通知履歴</a>に含まれるアンケートのurlを表示するには、WebViewにアンケート表示用のurlを設定します。この設定の際にアンケートの回答者を匿名で識別する為に、取得したアンケート表示用のurlのクエリーに プラットフォーム固有のパラメータとuuidのパラメータを以下の形式で追加してください。
  * uuidを識別するためのcruuidパラメータの値は、CorePushManagerのuuidメソッドで取得した値を設定してください。
  * プラットフォームを識別するためのpfパラメータの値は、iosを設定してください。

```
// 取得したアンケート用のURL文字列に プラットフォーム種別を表す値(ios)とuuidの値を追加する
NSString* uuid = [[CorePushManager shared] uuid];
NSString* questionnaireUrl = [NSString stringWithFormat:@"%@&pf=ios&cruuid=%@", url, uuid];
```

* 本サンプルでは、WebViewを使用した QuestionnaireViewControllerクラスにアンケート用のurlを指定し、アンケートの表示をおこなっています。

```
QuestionnaireViewController *controller = [[QuestionnaireViewController alloc]initWithNibName:@"QuestionnaireViewController" bundle:nil];
    controller.urlString = questionnaireUrl;

// 現在表示中の画面上にアンケート画面を表示する
[[AppDelegate topMostViewController] presentViewController:controller animated:YES completion:nil];
```

### <div id="research_history">アンケート通知履歴</div>
* アンケート通知履歴を取得するには、<a href="http://developer.core-asp.com/research_history.php">通知履歴取得API</a>を使用してください。本サンプルでは、HistoryViewControllerクラス内でCoreResearchHistoryManagerクラスを使用し、通知履歴を取得しています。
* アンケート通知履歴からアンケートを表示するには、通知履歴に含まれるurlをアンケート表示用のWebViewに設定してください。表示方法の詳細については、<a href="#research_display">アンケート表示</a>をご参照ください。
