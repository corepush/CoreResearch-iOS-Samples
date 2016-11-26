//
//  MainViewController.h
//  CoreResearch-iOS-Samples
//
//  Copyright © 2016年 Bless Service Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, MainCellType) {
    tokenRegister,
    tokenUnregister,
    history      // アプリバージョン
};

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic) IBOutlet UITableView* tableView;

@end
