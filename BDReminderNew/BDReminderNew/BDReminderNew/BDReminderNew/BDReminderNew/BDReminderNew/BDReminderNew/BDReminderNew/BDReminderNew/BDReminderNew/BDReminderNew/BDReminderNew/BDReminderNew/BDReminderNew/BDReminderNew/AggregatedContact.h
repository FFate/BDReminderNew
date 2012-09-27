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

@interface AggregatedContact : NSManagedObject

@property (nonatomic, retain) NSSet *contact;
@end

@interface AggregatedContact (CoreDataGeneratedAccessors)

- (void)addContactObject:(Contact *)value;
- (void)removeContactObject:(Contact *)value;
- (void)addContact:(NSSet *)values;
- (void)removeContact:(NSSet *)values;

+ (void)buildAggregatedContactList;
+ (void)sortContactListbyBD;

@end
