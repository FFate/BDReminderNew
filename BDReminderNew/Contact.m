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


@implementation Contact

@synthesize name;
@synthesize birthday;
@synthesize aggregatedContact;
@synthesize account;


-(Contact*) initWithName: (NSString*) name birthday: (NSDate*) birthday{
    self = [super init];
//    self = (Contact *) [NSEntityDescription insertNewObjectForEntityForName:@"Contact" inManagedObjectContext:managedObjectContext];
    
    if (self) {
        self.name = name;
        self.birthday = birthday;
    }
    
    return self;
}

@end
