//
//  NewAccountDetailsViewController.h
//  BDReminderNew
//
//  Created by Wang Tian on 12-10-12.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Account.h"

@interface NewAccountDetailsViewController : UITableViewController

@property (weak, nonatomic) IBOutlet UILabel *accountStatus;
@property (nonatomic) int accountIndex;
@property (nonatomic, retain) Account* account;

-(void) userLogin;
-(void) logoutButtonWasPressed:(id)sender;
-(void) updateView;

@end
