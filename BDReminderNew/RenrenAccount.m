//
//  RenrenAccount.m
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RenrenAccount.h"


@implementation RenrenAccount

-(RenrenAccount *) init{
    self = (RenrenAccount *) [NSEntityDescription insertNewObjectForEntityForName:@"RenrenAccount" inManagedObjectContext:[AppDelegate delegate].managedObjectContext];
    
    if(self)
    {

    }
    
    return self;
}

// override
- (NSString*) accountSiteName {
    return @"Renren";
}

// override
- (UIImage*) accountIcon {
    return [UIImage imageNamed:@"Renren-icon.png"];
}

// override
- (BOOL) isSessionValid {
    return [[Renren sharedRenren] isSessionValid];
}

@end
