//
//  MyRenrenGetBirthdayDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenGetBirthdaysFromUidsDelegate.h"

@implementation MyRenrenGetBirthdaysFromUidsDelegate

@synthesize friends;

- (id) initWithFriendsList: (NSMutableArray*) aFriendsList {
    self = [super init];
    self.friends = aFriendsList;
    return self;
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSLog(@"GetBirthdaysFromUidsDelegate DidReturnResponse.");
    NSArray* returnArray = (NSArray*) response.rootObject;
    
    NSLog(@"size: %d", [returnArray count]);
    for (ROResponseItem* friend in returnArray) {
        NSLog(@"Friend name: %@, BD:%@", [friend valueForItemKey:@"name"], [friend valueForItemKey:@"birthday"]);
    }
}

@end
