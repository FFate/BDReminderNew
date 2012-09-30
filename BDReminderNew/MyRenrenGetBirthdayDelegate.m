//
//  MyRenrenGetBirthdayDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenGetBirthdayDelegate.h"

@implementation MyRenrenGetBirthdayDelegate

@synthesize friends;

- (id) initWithFriendsList: (NSMutableArray*) aFriendsList {
    self = [super init];
    self.friends = aFriendsList;
    return self;
}



@end
