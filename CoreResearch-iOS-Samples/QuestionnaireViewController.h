//
//  QuestionnaireViewController.h
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionnaireViewController : UIViewController<UIWebViewDelegate>

@property(nonatomic) IBOutlet UIWebView *webView;
@property(nonatomic) IBOutlet UINavigationBar *navigationBar;
@property(nonatomic) IBOutlet UINavigationItem *navigationItem;

@property(nonatomic) NSString* urlString;

@end
