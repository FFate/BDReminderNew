//
//  MyRenrenLoginDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenLoginDelegate.h"
#import "DejalActivityView.h"
#import "MyRenrenGetFriendsDelegate.h"
#import "MyRenrenGetUserInfoDelegate.h"

@interface MyRenrenLoginDelegate()

@end

@implementation MyRenrenLoginDelegate

@synthesize viewController;
@synthesize getUserInfoDelegate;

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
    
    // update user info
    [viewController showLoadingOverlayWithText:@"Getting Account Information..."];
    
    getUserInfoDelegate = [[MyRenrenGetUserInfoDelegate alloc] initWithViewController:viewController];
    
    ROUserInfoRequestParam* userInfoParams = [[ROUserInfoRequestParam alloc] init];
    userInfoParams.fields = @"name";
    [[Renren sharedRenren] getUsersInfo:userInfoParams andDelegate:getUserInfoDelegate];
}

- (void) renrenDidLogout:(Renren *)renren {
    // this account is logged out
    Account* account = (Account*)[[Account accountList] objectAtIndex:viewController.accountIndex];
    
    // update model
    account.identifier = nil;
    account.userName = nil;
    
    // update view
    [viewController updateAccountStatus:account];
    [viewController updateAccountInfo:account];
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
