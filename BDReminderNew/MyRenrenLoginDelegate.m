//
//  MyRenrenLoginDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenLoginDelegate.h"

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
    Account* account = (Account*)[[AppDelegate delegate].accountsList objectAtIndex:viewController.accountIndex];
    account.accountStatus = ACCOUNT_VALID;
    [viewController updateAccountStatus:account];
    [viewController.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
}

- (void) renrenDidLogout:(Renren *)renren {
    // this account is logged out
    Account* account = (Account*)[[AppDelegate delegate].accountsList objectAtIndex:viewController.accountIndex];
    account.accountStatus = ACCOUNT_NOT_SET;
    [viewController updateAccountStatus:account];
    [viewController.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
}

- (void) renren:(Renren *)renren loginFailWithError:(ROError *)error {
    Account* account = (Account*)[[AppDelegate delegate].accountsList objectAtIndex:viewController.accountIndex];
    account.accountStatus = ACCOUNT_AUTHENTICATION_FAILED;
    [viewController updateAccountTypeAndInfoText:account];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed Login Attempt"
                                                    message:@"Authentication to Renren failed. "
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
