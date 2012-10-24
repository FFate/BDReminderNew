//
//  BDLocalNotifications.h
//  BDReminderNew
//
//  Created by qinsoon on 24/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LinkedContact.h"

@interface BDLocalNotifications : NSObject

+ (void) addBDLocalNotificationFor:(LinkedContact *) contact;
+ (void) removeBDLocalNotificationFor: (LinkedContact *) contact;

@end
