//
//  AggregatedContact.h
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Contact;

@interface LinkedContact : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) UIImage* head;

@property (nonatomic, retain) NSSet *contact;

- (id) initWithContact: (Contact*) contact;

- (BOOL) match: (Contact*) contact;
- (BOOL) alreadyLinkedWith: (Contact*) contact;

+ (NSMutableArray*) linkedContactList;
+ (void) setLinkedContactList: (NSMutableArray*) anotherLinkedContactList;
+ (void) linkContactsFrom: (NSMutableArray*) contacts to: (NSMutableArray*) linkedContacts;

@end

@interface LinkedContact (CoreDataGeneratedAccessors)

- (void)addContactObject:(Contact *)value;
- (void)removeContactObject:(Contact *)value;
- (void)addContact:(NSSet *)values;
- (void)removeContact:(NSSet *)values;

+ (void)buildAggregatedContactList;
+ (void)sortContactListbyBD;

@end
