//
//  QWeiboAccount.m
//  BDReminderNew
//
//  Created by qinsoon on 8/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "QWeiboAccount.h"


@implementation QWeiboAccount

- (QWeiboAccount*) init{
    self = (QWeiboAccount *) [NSEntityDescription insertNewObjectForEntityForName:@"QWeiboAccount" inManagedObjectContext:[AppDelegate delegate].managedObjectContext];
    
    if (self) {
        
    }
    
    return self;
}

- (NSString*) accountSiteName {
    return @"QWeibo";
}

- (UIImage*) accountIcon {
    return [UIImage imageNamed:@"QWeibo-icon.png"];
}

- (BOOL) isSessionValid {
    methodNotImplementedSoftWarning();
    return NO;
}

@end
