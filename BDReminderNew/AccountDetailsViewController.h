//
//  AccountDetailsViewController.h
//  BDReminderNew
//
//  Created by qinsoon on 27/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@interface AccountDetailsViewController : UITableViewController <RenrenDelegate>

@property (weak, nonatomic) IBOutlet UITextField *accountTypeTextField;
@property (retain, nonatomic) IBOutlet UIButton *loginButton;
@property (nonatomic) int accountTag;
- (IBAction)userLogin:(id)sender;

@end
