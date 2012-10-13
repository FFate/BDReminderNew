//
//  AggregatedContact.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LinkedContact.h"
#import "Contact.h"


@implementation LinkedContact

@dynamic contact;
@dynamic birthday;
@dynamic name;
@dynamic head;

- (id) initWithContact: (Contact*) contact {
    self = (LinkedContact*) [NSEntityDescription insertNewObjectForEntityForName:@"LinkedContact" inManagedObjectContext:[AppDelegate delegate].managedObjectContext];
    
    if (self) {
        self.birthday = contact.birthday;
        self.name = contact.name;
        self.head = contact.head;
        [self addContactObject:contact];
    }
    
    return self;
}

- (BOOL) match: (Contact*) contact {
    // naive matching
    if ([self.name isEqual:contact.name] && [self.birthday isEqual:contact.birthday])
        return YES;
    else return NO;
}

- (BOOL) alreadyLinkedWith: (Contact*) contact {
    for (Contact* existing in self.contact) {
        if ([existing myIsEqual:contact]) {
            return YES;
        }
    }
    return NO;
}

// global linkedContactList
static NSMutableArray* linkedContactList = nil;

+ (NSMutableArray*) linkedContactList {
    if (!linkedContactList)
        linkedContactList = [NSMutableArray array];
    return linkedContactList;
}

+ (void) setLinkedContactList: (NSMutableArray*) anotherLinkedContactList {
    linkedContactList = anotherLinkedContactList;
}

+ (void) linkContactsFrom: (NSMutableArray*) contacts to: (NSMutableArray*) linkedContacts {
    for (Contact* contact in contacts) {
        // find if this contact has an existing linkedContact
        LinkedContact* exist = nil;
        for (LinkedContact* linkedContact in linkedContacts) {
            if ([linkedContact match:contact]) {
                exist = linkedContact;
                break;
            }
        }
        
        // if there is already a linked contact for such contact
        // we need to link the contact to such existing linkedContact
        if (exist) {
            if (![exist alreadyLinkedWith:contact])
                [contact linkTo:exist];
        }
        // otherwise create a linked contact for such contact
        else {
            LinkedContact* newLinkedContact = [[LinkedContact alloc] initWithContact:contact];
            [linkedContacts addObject:newLinkedContact];
        }
    }
}

@end
