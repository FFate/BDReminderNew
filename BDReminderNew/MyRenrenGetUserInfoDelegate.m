//
//  MyRenrenGetUserInfoDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenGetUserInfoDelegate.h"
#import "RenrenAccount.h"

@implementation MyRenrenGetUserInfoDelegate

@synthesize viewController;
@synthesize getFriendsDelegate;

- (id)initWithViewController:(RenrenAccountDetailsViewController *)aViewController {
    self = [super init];
    self.viewController = aViewController;
    return self;
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSArray* returnArray = (NSArray*) response.rootObject;
    ROUserResponseItem* user = (ROUserResponseItem*)[returnArray objectAtIndex:0];
    
    NSString* name = [[NSString alloc] initWithString:user.name];
    RenrenAccount* myAccount = (RenrenAccount *)viewController.account;
    myAccount.userName = [[NSString alloc] initWithString:name];
    myAccount.identifier = [[NSString alloc] initWithString:user.userId];
    viewController.userNameLabel.text = name;
    
    // update contacts
    [viewController updateLoadingOverlayText:@"Getting Contacts..."];
    
    getFriendsDelegate = [[MyRenrenGetFriendsDelegate alloc] initWithViewController:viewController];
    
    ROGetFriendsRequestParam* friendUidsParams = [[ROGetFriendsRequestParam alloc] init];
    friendUidsParams.page = @"1";
    friendUidsParams.count = @"500";
    [[Renren sharedRenren] getFriends:friendUidsParams andDelegate:getFriendsDelegate];
}

- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Fail"
                                                    message:@"Something Wrong"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
