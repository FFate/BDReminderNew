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

@dynamic name;
@dynamic birthday;
@dynamic aggregatedContact;
@dynamic account;


-(Contact*) initWithName: (NSString*) name birthday: (NSDate*) birthday{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.birthday = birthday;
    }
    
    return self;
}

@end
