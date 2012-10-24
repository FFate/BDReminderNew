//
//  AppSettings.m
//  BDReminderNew
//
//  Created by qinsoon on 23/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "AppSettings.h"

@implementation AppSettings

+ (BOOL) onlyShowContactWithBirthday {
    return NO;
}

// 2 hours before birthday
+ (NSInteger) notifyBeforeInMinutes {
    return 2 * 60;
}

@end
