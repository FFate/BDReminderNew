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

@interface AccountDetailsViewController : UITableViewController <RenrenDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTypeTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic) int accountIndex;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

- (IBAction)userLogin:(id)sender;
- (IBAction)updateUserInfo:(id)sender;

- (void) updateAccountTypeAndInfoText: (Account*) account;
- (void) updateAccountInfo: (Account*) account;

@end
