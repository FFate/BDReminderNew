//
//  Contact.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Contact.h"
#import "Account.h"
#import "AggregatedContact.h"
#import "AppDelegate.h"

@implementation Contact

@dynamic name;
@dynamic birthday;
@dynamic aggregatedContact;
@dynamic account;

-(Contact*) initWithName: (NSString*) name birthday: (NSDate*) birthday{
    AppDelegate *appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    self = (Contact *) [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:appDelegate.managedObjectContext];
    
    if (self) {
        self.name = name;
        self.birthday = birthday;
    }
    
    return self;
}

#define DATE_FORMAT @"yyyy-MM-dd"

-(Contact*) initWithName:(NSString *)name birthdayString:(NSString *)birthday account:(Account *)account {
    self = (Contact *) [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:[AppDelegate delegate].managedObjectContext];
    
    if (self) {
        self.name = name;
        self.account = account;
        
        // convert birthday string to NSDate
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // this is imporant - we set our input date format to match our input string
        // if format doesn't match you'll get nil from your string, so be careful
        [dateFormatter setDateFormat:DATE_FORMAT];
        self.birthday = [dateFormatter dateFromString:birthday];
    }
    
    return self;
}

-(NSString*) getBirthdayString {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    return [dateFormatter stringFromDate:self.birthday];
}

@end
