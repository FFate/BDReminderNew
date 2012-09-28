//
//  MyRenrenGetUserInfoDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenGetUserInfoDelegate.h"

@implementation MyRenrenGetUserInfoDelegate

@synthesize viewController;

- (id)initWithViewController:(RenrenAccountDetailsViewController *)aViewController {
    self = [super init];
    self.viewController = aViewController;
    return self;
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSLog(@"requestDidReturn");
    NSArray* returnArray = (NSArray*) response.rootObject;
    ROUserResponseItem* user = (ROUserResponseItem*)[returnArray objectAtIndex:0];
    
    //    RenrenAccount* account = (RenrenAccount*)[[AppDelegate delegate].accountsList objectAtIndex:accountIndex];
    
    NSString* name = [[NSString alloc] initWithString:user.name];
    NSLog(@"Returned name is: %@", name);
    Account* myAccount = (Account *)[[AppDelegate delegate].accountsList objectAtIndex:viewController.accountIndex];
    myAccount.userName = name;
    viewController.userNameLabel.text = name;
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
