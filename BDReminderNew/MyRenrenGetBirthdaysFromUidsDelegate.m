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

#define VERBOSE_FRIEND_INFO NO

@implementation MyRenrenGetBirthdaysFromUidsDelegate

@synthesize viewController;

- (id) initWithViewController: (RenrenAccountDetailsViewController*) viewController WithAccount: (Account*) account {
    self = [[MyRenrenGetBirthdaysFromUidsDelegate alloc] init];
    
    self.viewController = viewController;
    self.account = account;
    
    return self;
}

- (void)renren: (Renren*)renren requestDidReturnResponse:(ROResponse *)response {
    NSArray* returnArray = (NSArray*) response.rootObject;
    
    NSMutableArray* newContacts = [[NSMutableArray alloc] initWithCapacity:[returnArray count]];
    
    for (ROResponseItem* friend in returnArray) {
        if (VERBOSE_FRIEND_INFO) NSLog(@"Friend id: %@, name: %@, BD:%@, head:%@",
              [friend valueForItemKey:@"uid"],
              [friend valueForItemKey:@"name"],
              [friend valueForItemKey:@"birthday"],
              [friend valueForItemKey:@"tinyurl"]);
        Contact* contact = [[Contact alloc]
                            initWithUid: [friend valueForItemKey:@"uid"]
                            name:[friend valueForItemKey:@"name"]
                            birthdayString:[friend valueForItemKey:@"birthday"]
                            headUrl:[friend valueForItemKey:@"tinyurl"]
                            account:self.account];
        
        // add into array
        [newContacts addObject:contact];
    }
    
    UINavigationController *nav = (UINavigationController*) [[UIApplication sharedApplication] keyWindow].rootViewController;
    ContactsViewController* contactsViewController = [[nav viewControllers] objectAtIndex:0];
    [contactsViewController mergeContactsAndUpdateView:newContacts];
    
    [viewController dismissLoadingOverlay];
}

@end
