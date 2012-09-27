//
//  Account.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Account.h"
#import "Contact.h"
#import "AppDelegate.h"

@implementation Account

@dynamic password;
@dynamic userName;
@dynamic contact;


-(Account*) initWithUserName: (NSString*) userName password: (NSString*) password{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self = (Account *) [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:appDelegate.managedObjectContext];
    
    if (self) {
        self.userName = userName;
        self.password = password;
    }
    
    return self;
}

-(Account *) init{
    
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self = (Account *) [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:appDelegate.managedObjectContext];

    return self;
}

static NSSet * accountList;

- (void) loginAndGetContacts {
    mustOverride();
}

@end
