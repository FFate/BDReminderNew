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

@class Contact;

@interface Account : NSManagedObject

@property (nonatomic, retain) NSString * userName;
@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSSet *contact;

+ (NSMutableArray*) accountList;
+ (void) setAccountList: (NSMutableArray* )AnotherAccountList;

- (NSString*) accountSiteName;
- (UIImage*) accountIcon;
- (BOOL) isSessionValid;
- (NSString*) accountStatusText;

@end

@interface Account (CoreDataGeneratedAccessors)

- (void)addContactObject:(Contact *)value;
- (void)removeContactObject:(Contact *)value;
- (void)addContact:(NSSet *)values;
- (void)removeContact:(NSSet *)values;

+ (void)traverseAccountListAndGetContacts;

@end
