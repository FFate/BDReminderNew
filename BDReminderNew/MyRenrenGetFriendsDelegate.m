//
//  MyRenrenGetContactsDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenGetFriendsDelegate.h"
#import "MyRenrenGetBirthdaysFromUidsDelegate.h"

@implementation MyRenrenGetFriendsDelegate

@synthesize viewController;
@synthesize getBirthdayDelegate;

- (id) initWithViewController:(RenrenAccountDetailsViewController *)aViewController {
    self = [super init];
    self.viewController = aViewController;
    self.getBirthdayDelegate = [[MyRenrenGetBirthdaysFromUidsDelegate alloc] initWithFriendsList:nil];
    return self;
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSLog(@"GetContactsDelegate DidReturnResponse.");
    NSArray* returnArray = (NSArray*) response.rootObject;
    
    NSMutableString* uids = [[NSMutableString alloc] init];
    for (NSString* friendId in returnArray) {
        NSLog(@"Friend id: %@\n", friendId);
        [uids appendFormat:@"%@,", friendId];
    }
    
    NSLog(@"UID list: %@", uids);
    
    ROUserInfoRequestParam* params = [[ROUserInfoRequestParam alloc] init];
    params.userIDs = uids;
    params.fields = @"name, birthday";
    [[Renren sharedRenren] getUsersInfo:params andDelegate:getBirthdayDelegate];
}

- (void)renren:(Renren *)renren requestFailWithError:(ROError*)error
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Request Fail"
                                                    message:@"Something Wrong when trying to get friends list"
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

@end