//
//  Contact.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contact.h"
#import "Account.h"
#import "LinkedContact.h"
#import "AppDelegate.h"

@implementation Contact

@dynamic name;
@dynamic birthday;
@dynamic aggregatedContact;
@dynamic account;
@dynamic head;
@dynamic uid;

-(Contact*) initWithName: (NSString*) name birthday: (NSDate*) birthday{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self = (Contact *) [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:appDelegate.managedObjectContext];
    
    if (self) {
        self.name = name;
        self.birthday = birthday;
    }
    
    return self;
}

-(Contact*) initWithUid: (NSString*) uid
                   name:(NSString *)name
          birthdayString:(NSString *)birthday
                 headUrl:(NSString *)headUrl
                 account:(Account *)account {
    self = (Contact *) [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:[AppDelegate delegate].managedObjectContext];
    
    if (self) {
        self.uid = uid;
        self.name = name;
        self.account = account;
        
        // convert birthday string to NSDate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:DATE_FORMAT];
        self.birthday = [dateFormatter dateFromString:birthday];
        
        // get head
        UIImage* head = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:headUrl]]];
        if (head == nil) {
            head = [UIImage imageNamed:@"defaultHead.jpeg"];
        }
        self.head = head;
    }
    
    return self;
}

-(NSString*) getBirthdayString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    return [dateFormatter stringFromDate:self.birthday];
}

- (BOOL) myIsEqual:(id)object {
    if (self == object) {
        return YES;
    } else if (object) {
        Contact* another = (Contact*) object;
        return ([another.uid isEqual:self.uid] &&([another.account class] == [self.account class]));
    }
    return NO;
}

- (void) linkTo: (LinkedContact*) linkedContact {
    // remove current linkage
    if (self.aggregatedContact) {
        [self.aggregatedContact removeContactObject:self];
        self.aggregatedContact = nil;
    }
    
    // build new linkage
    self.aggregatedContact = linkedContact;
    [linkedContact addContactObject:self];
}

static NSMutableArray* contactList;

+ (NSMutableArray*) contactList {
    return contactList;
}

+ (void) setContactList:(NSMutableArray *)anotherContactList {
    contactList = anotherContactList;
}

@end
