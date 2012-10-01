//
//  MyRenrenGetContactsDelegate.h
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RenrenAccountDetailsViewController.h"

@class RenrenAccountDetailsViewController;

@interface MyRenrenGetFriendsDelegate : NSObject <RenrenDelegate>

@property (nonatomic, retain) RenrenAccountDetailsViewController* viewController;
@property (nonatomic, retain) id getBirthdayDelegate;

- (id) initWithViewController: (RenrenAccountDetailsViewController*) aViewController;

@end
