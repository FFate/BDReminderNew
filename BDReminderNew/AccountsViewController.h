//
//  AccountsViewController.h
//  BDReminderNew
//
//  Created by Wang Tian on 12-9-16.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountsViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *accounts;

+ (NSString *)accountNameByTag:(int) accountTag;
+ (UIImage *)iconOfAccountByTag:(int) accountTag;
+ (NSString *)accountStatusText:(int) accountStatus;

@end
