//
//  Util.m
//  BDReminderNew
//
//  Created by qinsoon on 13/10/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "Util.h"

@implementation Util

+ (NSString*) stringFromNSDate: (NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:DATE_FORMAT];
    return [dateFormatter stringFromDate:date];
}

@end
