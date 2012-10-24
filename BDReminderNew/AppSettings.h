//
//  AppSettings.h
//  BDReminderNew
//
//  Created by qinsoon on 23/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppSettings : NSObject

+ (BOOL) onlyShowContactWithBirthday;
+ (NSInteger) notifyBeforeInMinutes;

@end
