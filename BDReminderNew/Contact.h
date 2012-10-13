//
//  Contact.h
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, LinkedContact;

@interface Contact : NSManagedObject

@property (nonatomic, retain) NSString * uid;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) UIImage * head;
@property (nonatomic, retain) Account *account;

@property (nonatomic, retain) LinkedContact *aggregatedContact;

// test use only
-(Contact*) initWithName: (NSString*) name birthday: (NSDate*) birthday;

// birthday as yyyy-MM-dd
-(Contact*) initWithUid: (NSString*) uid name:(NSString *)name birthdayString:(NSString *)birthday headUrl: (NSString*) headUrl account: (Account*) account;

-(NSString*) getBirthdayString;

- (BOOL) myIsEqual:(id)object;

- (void) linkTo: (LinkedContact*) linkedContact;

+ (NSMutableArray*) contactList;
+ (void) setContactList: (NSMutableArray*) anotherContactList;

@end
