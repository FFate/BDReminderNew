//
//  Contact.h
//  BDReminder
//
//  Created by Lin Shuisheng on 21/08/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Account, AggregatedContact;

@interface Contact : NSManagedObject



@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * birthday;
@property (nonatomic, retain) AggregatedContact *aggregatedContact;
@property (nonatomic, retain) Account *account;

@end
