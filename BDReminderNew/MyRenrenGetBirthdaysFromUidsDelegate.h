//
//  MyRenrenGetBirthdayDelegate.h
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Account.h"

@interface MyRenrenGetBirthdaysFromUidsDelegate : NSObject <RenrenDelegate>

@property (nonatomic, retain) Account* account;

- (id) initWithAccount: (Account*) account;

@end
