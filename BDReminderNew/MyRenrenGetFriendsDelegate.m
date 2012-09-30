//
//  MyRenrenGetContactsDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenGetFriendsDelegate.h"

@implementation MyRenrenGetFriendsDelegate

@synthesize viewController;

- (id) initWithViewController:(RenrenAccountDetailsViewController *)aViewController {
    self = [super init];
    self.viewController = aViewController;
    return self;
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSLog(@"GetContactsDelegate DidReturnResponse.");
    NSArray* returnArray = (NSArray*) response.rootObject;
    
    NSLog(@"size: %d", [returnArray count]);
    for (ROFriendResponseItem *friend in returnArray) {
        NSLog(@"Friend: %@, id: %@\n", friend.name, friend.userId);
        
        // get birthday
        
    }
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
