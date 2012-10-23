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
@dynamic nextBirthday;

- (id) initWithContact: (Contact*) contact {
    self = (LinkedContact*) [NSEntityDescription insertNewObjectForEntityForName:@"LinkedContact" inManagedObjectContext:[AppDelegate delegate].managedObjectContext];
    
    if (self) {
        self.birthday = contact.birthday;
        self.name = contact.name;
        self.head = contact.head;
        [self addContactObject:contact];
        self.nextBirthday = [self getNextBirthday:self.birthday];
    }
    
    return self;
}

- (BOOL) match: (Contact*) contact {
    // naive matching
    if ([self.name isEqual:contact.name])
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

+ (void) sortLinkedContactByRecentBDFirst {
    [linkedContactList sortUsingSelector:@selector(compare:)];
}

- (NSComparisonResult) compare:(LinkedContact *)second{
    NSComparisonResult result;
    if (!self.nextBirthday)
        result = NSOrderedDescending;
    else if (self.nextBirthday && !second.nextBirthday)
        result = NSOrderedAscending;
    else {
        result = [self.nextBirthday compare: second.nextBirthday];
    }
    
    NSString* compare;
    switch (result) {
        case NSOrderedAscending:
            compare = @"<";
            break;
        case NSOrderedDescending:
            compare = @">";
            break;
        case NSOrderedSame:
            compare = @"=";
            break;
        default:
            break;
    }
    NSLog(@"%@(%@) %@ %@(%@)", self.name, [Util stringFromNSDate:self.birthday],
          compare, second.name, [Util stringFromNSDate:second.birthday]);
    return result;
}

#define UNIT_FLAGS NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit

static int thisYear = -1;

+ (NSInteger) getCurrentYear {
    if (thisYear == -1) {
        NSCalendar* cal = [NSCalendar currentCalendar];
        NSDate* now = [NSDate date];
        thisYear = [[cal components:UNIT_FLAGS fromDate:now] year];
    }
    
    return thisYear;
}

- (NSDate*) getNextBirthday: (NSDate*) birthday {
    if (birthday == nil)
        return nil;
    
    NSDate* nextBirthday;
    
    NSDate* birthdayInThisYear = [LinkedContact birthday:birthday inYear:[LinkedContact getCurrentYear]];
    NSDate* now = [NSDate date];
    NSComparisonResult comparison = [birthdayInThisYear compare:now];
    if (comparison == NSOrderedAscending) {
        // birthday in this year has passed
        nextBirthday = [LinkedContact birthday:birthday inYear:[LinkedContact getCurrentYear]+1];
    }else nextBirthday = birthdayInThisYear;
    
    return nextBirthday;
}

+ (NSDate*) birthday: (NSDate*) birthday inYear: (NSInteger) year {
    NSCalendar* cal = [NSCalendar currentCalendar];
    NSDateComponents *comps = [cal components:UNIT_FLAGS fromDate:birthday];
    [comps setYear:year];
    return [cal dateFromComponents:comps];
}

@end
