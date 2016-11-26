//
//  QuestionnaireViewController.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "QuestionnaireViewController.h"

@interface QuestionnaireViewController ()

@end

@implementation QuestionnaireViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]]];
    UIBarButtonItem* left1 = [[UIBarButtonItem alloc]
                              initWithTitle:@"閉じる"
                              style:UIBarButtonItemStylePlain
                              target:self
                              action:@selector(close)];
    
    // メールアドレスや電話番号などの自動データ検出を無効
    self.webView.dataDetectorTypes = UIDataDetectorTypeNone;
    
    self.navigationItem.rightBarButtonItems = @[left1];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)close{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
