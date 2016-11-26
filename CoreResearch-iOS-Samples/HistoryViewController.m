//
//  HistoryViewController.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "HistoryViewController.h"
#import "CoreResearchHistoryManager.h"
#import "QuestionnaireViewController.h"
#import <CorePush/CorePushManager.h>

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"アンケート履歴";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    
    CoreResearchHistoryManager *manager = [CoreResearchHistoryManager shared];
    [manager requestHistory:^(NSArray *historys){
        self.historys = historys;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.tableView reloadData];
        });
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary* history = [self.historys objectAtIndex:indexPath.row];
    [self showQuestionnaireView:history];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.historys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *labelStr = @"";
    NSDictionary* history = [self.historys objectAtIndex:indexPath.row];
    labelStr = [history objectForKey:@"body"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = labelStr;
    return cell;
}

- (void)showQuestionnaireView:(NSDictionary*)history {
    NSString *url = [history objectForKey:@"url"];
    if (url == nil || [url isEqualToString:@""]) {
        return;
    }
    
    NSString* uuid = [[CorePushManager shared] uuid];
    NSString* questionnaireUrl = [NSString stringWithFormat:@"%@&pf=ios&cruuid=%@", url, uuid];
    
    QuestionnaireViewController *controller = [[QuestionnaireViewController alloc]initWithNibName:@"QuestionnaireViewController" bundle:nil];
    controller.urlString = questionnaireUrl;
    [self presentViewController:controller animated:YES completion:nil];
}

@end
