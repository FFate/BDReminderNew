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
@dynamic identifier;

-(Account *) init{
    mustOverride();
    return self;
}

- (BOOL) isSessionValid {
    mustOverride();
    return YES;
}

- (NSString*) accountStatusText {
    if ([self isSessionValid]) {
        return @"Logged In";
    } else return @"Invalid Session";
}

static NSMutableArray* accountList;

+ (NSMutableArray*) accountList {
    return accountList;
}

+ (void) setAccountList:(NSMutableArray *)AnotherAccountList {
    accountList = AnotherAccountList;
}

@end
