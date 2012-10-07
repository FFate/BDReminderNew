//
//  AccountDetailsViewController.h
//  BDReminderNew
//
//  Created by qinsoon on 27/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"
#import "AccountsViewController.h"
#import "DejalActivityView.h"

@interface AccountDetailsViewController : UITableViewController

@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic) int accountIndex;
@property (nonatomic, retain) Account* account;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *accountTypeLabel;

// loading overlay
//@property (nonatomic, retain) DejalBezelActivityView* loadingOverlay;
- (void) showLoadingOverlayWithText:(NSString*) text;
- (void) showLoadingOverlayWithText:(NSString *)text dismissAfterDelay:(NSTimeInterval)delay;
- (void) updateLoadingOverlayText:(NSString*) text;
- (void) dismissLoadingOverlay;

- (IBAction)userLogin:(id)sender;
- (IBAction)updateUserInfo:(id)sender;

- (void) updateAccountTypeAndInfoText: (Account*) account;
- (void) updateAccountStatus: (Account*) account;
- (void) updateAccountInfo: (Account*) account;

@end
