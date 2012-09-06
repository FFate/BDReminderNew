//
//  Account.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Account.h"
#import "Contact.h"


@implementation Account

@dynamic password;
@dynamic userName;
@dynamic contact;

static NSSet * accountList;

- (void) loginAndGetContacts {
    mustOverride();
}

@end
