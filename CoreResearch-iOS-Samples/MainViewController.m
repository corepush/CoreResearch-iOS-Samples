//
//  MainViewController.m
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"ホーム";
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSString *segueName = @"";
    switch (indexPath.row) {
        case tokenRegister:
            segueName = @"TokenRegister";
            break;
        case tokenUnregister:
            segueName = @"TokenUnregister";
            break;
        case history:
            segueName = @"History";
            break;
    }
    
    [self performSegueWithIdentifier:segueName sender:self];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *labelStr = @"";
    switch (indexPath.row) {
        case tokenRegister:
            labelStr = @"トークン登録";
            break;
        case tokenUnregister:
            labelStr = @"トークン削除";
            break;
        case history:
            labelStr = @"アンケート履歴";
            break;
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = labelStr;
    return cell;
}

@end
