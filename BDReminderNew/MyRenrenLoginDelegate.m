//
//  MyRenrenLoginDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenLoginDelegate.h"
#import "DejalActivityView.h"

@interface MyRenrenLoginDelegate()

@end

@implementation MyRenrenLoginDelegate

@synthesize viewController;

- (MyRenrenLoginDelegate*) initWithViewController: (RenrenAccountDetailsViewController *) sourceViewController {
    self = [super init];
    self.viewController = sourceViewController;
    return self;
}

- (void) renrenDidLogin:(Renren *)renren {
    // this account is logged in
    Account* account = (Account*)[[Account accountList] objectAtIndex:viewController.accountIndex];
    [viewController updateAccountStatus:account];
    [viewController.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
}

- (void) renrenDidLogout:(Renren *)renren {
    // this account is logged out
    Account* account = (Account*)[[Account accountList] objectAtIndex:viewController.accountIndex];
    [viewController updateAccountStatus:account];
    [viewController.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
}

- (void) renren:(Renren *)renren loginFailWithError:(ROError *)error {
    Account* account = (Account*)[[Account accountList] objectAtIndex:viewController.accountIndex];
    [viewController updateAccountTypeAndInfoText:account];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed Login Attempt"
                                                    message:@"Authentication to Renren failed. "
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
