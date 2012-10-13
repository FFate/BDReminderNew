//
//  Util.h
//  BDReminderNew
//
//  Created by qinsoon on 13/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DATE_FORMAT @"yyyy-MM-dd"

@interface Util : NSObject

+ (NSString*) stringFromNSDate: (NSDate*) date;

@end
