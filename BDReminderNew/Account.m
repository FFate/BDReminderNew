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

@dynamic userName;
@dynamic contact;
@synthesize accountStatus;

-(Account *) init{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self = (Account *) [NSEntityDescription insertNewObjectForEntityForName:@"Account" inManagedObjectContext:appDelegate.managedObjectContext];
    
    self.accountStatus = ACCOUNT_NOT_SET;

    return self;
}

static NSSet * accountList;

- (void) loginAndGetContacts {
    mustOverride();
}

@end
