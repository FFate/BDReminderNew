//
//  BDLocalNotifications.m
//  BDReminderNew
//
//  Created by qinsoon on 24/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "BDLocalNotifications.h"

#define NOTIFICATION_ID @"nid"
#define VERBOSE_NOTIFICATION YES

@implementation BDLocalNotifications

+ (void) addBDLocalNotificationFor:(LinkedContact *) contact {
    if (contact.birthday == nil || contact.nextBirthday == nil)
        return;
    
    UILocalNotification *localNotif = [[UILocalNotification alloc] init];
    if (localNotif == nil)
        return;
    
    // set notification fire date
    NSDate* triggerDate = [contact.nextBirthday addTimeInterval:-[AppSettings notifyBeforeInMinutes] * 60];
    localNotif.fireDate = triggerDate;
    localNotif.timeZone  = [NSTimeZone defaultTimeZone];
    
    // set notification content
    localNotif.alertBody = [NSString stringWithFormat:@"%@'s birthday is coming on %@",
                            contact.name, [Util stringFromNSDate:contact.nextBirthday]];
    localNotif.alertAction = @"View Details";
    
    // set notification sound and badge
    localNotif.soundName = UILocalNotificationDefaultSoundName;
    localNotif.applicationIconBadgeNumber = 1;
    
    // set dictionary
    NSString* nid = [self getNotificationIDForContact:contact];
    NSDictionary* infoDict = [NSDictionary dictionaryWithObject:nid forKey:NOTIFICATION_ID];
    localNotif.userInfo = infoDict;
    
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    
    if (VERBOSE_NOTIFICATION) NSLog(@"Setting notification(nid:%@) for %@ on %@", nid, contact.name, [Util stringWithTimeFromNSDate:triggerDate]);
}

+ (NSString*) getNotificationIDForContact: (LinkedContact* ) contact {
    NSMutableString* nid = [[NSMutableString alloc] init];
    [nid appendFormat:@"%@", contact.name];
    [nid appendFormat:@"-"];
    [nid appendFormat:@"%@", [Util stringFromNSDate:contact.birthday]];
    return nid;
}

+ (void) removeBDLocalNotificationFor: (LinkedContact *) contact {
    if (contact.birthday == nil)
        return;
    NSString* deleteNotificationNid = [self getNotificationIDForContact:contact];
    
    NSArray* notifications = [[UIApplication sharedApplication] scheduledLocalNotifications];
    for (UILocalNotification* notif in notifications) {
        NSDictionary* userInfo = notif.userInfo;
        NSString* nid = [userInfo valueForKey:NOTIFICATION_ID];
        if ([nid isEqual:deleteNotificationNid]) {
            [[UIApplication sharedApplication] cancelLocalNotification:notif];
            if (VERBOSE_NOTIFICATION)
                NSLog(@"Deleted notification(nid:%@)", deleteNotificationNid);
            return;
        }
    }
}

@end
