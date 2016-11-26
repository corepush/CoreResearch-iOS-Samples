//
//  HistoryViewController.h
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistoryViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic) IBOutlet UITableView* tableView;
@property(nonatomic) NSArray* historys;

@end
