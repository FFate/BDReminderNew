//
//  Account.h
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "AccountProtocol.h"

#define RENREN_ACCOUNT 1
#define FACEBOOK_ACCOUNT 2

typedef enum {
    ACCOUNT_OUT_OF_DATE,
    ACCOUNT_AUTHENTICATION_FAILED,
    
    ACCOUNT_VALID,
    
    ACCOUNT_NOT_SET
} AccountStatus;

@class Contact;

@interface Account : NSManagedObject <AccountProtocol>

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSSet *contact;
@property (nonatomic, assign) int accountTag;

@property AccountStatus accountStatus;

@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addContactObject:(Contact *)value;
- (void)removeContactObject:(Contact *)value;
- (void)addContact:(NSSet *)values;
- (void)removeContact:(NSSet *)values;

+ (void)traverseAccountListAndGetContacts;

@end
