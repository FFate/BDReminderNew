//
//  MyRenrenGetBirthdayDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "MyRenrenGetBirthdaysFromUidsDelegate.h"
#import "Contact.h"
#import "ContactsViewController.h"

@implementation MyRenrenGetBirthdaysFromUidsDelegate

-(id)initWithAccount: (Account*) account {
    self = [[MyRenrenGetBirthdaysFromUidsDelegate alloc] init];
    
    self.account = account;
    
    return self;
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSArray* returnArray = (NSArray*) response.rootObject;
    
    for (ROResponseItem* friend in returnArray) {
        NSLog(@"Friend name: %@, BD:%@", [friend valueForItemKey:@"name"], [friend valueForItemKey:@"birthday"]);
        Contact* contact = [[Contact alloc] initWithName:[friend valueForItemKey:@"name"] birthdayString:[friend valueForItemKey:@"birthday"] account:self.account];
        
        // add into global array
        [[AppDelegate delegate].contacts addObject:contact];
    }
    
    // force ContactsViewController reloadData
    UINavigationController *nav = (UINavigationController*) [[UIApplication sharedApplication] keyWindow].rootViewController;
    ContactsViewController* contactsViewController = [[nav viewControllers] objectAtIndex:0];
    [contactsViewController.tableView reloadData];
}

@end
