//
//  FacebookAccount.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FacebookAccount.h"


@implementation FacebookAccount

-(FacebookAccount *) init{
    self = (FacebookAccount *) [NSEntityDescription insertNewObjectForEntityForName:@"FacebookAccount" inManagedObjectContext:[AppDelegate delegate].managedObjectContext];
    
    if(self)
    {
        //self.accountTag = 2;
    }
    
    return self;
}

- (NSString*) accountSiteName {
    return @"Facebook";
}

- (UIImage*) accountIcon {
    return [UIImage imageNamed:@"Facebook-icon.png"];
}

- (BOOL) isSessionValid {
    methodNotImplementedSoftWarning();
    return NO;
}

@end
