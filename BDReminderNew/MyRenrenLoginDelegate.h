//
//  MyRenrenLoginDelegate.h
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RenrenAccountDetailsViewController.h"

@class RenrenAccountDetailsViewController;

@interface MyRenrenLoginDelegate : NSObject <RenrenDelegate>

@property (nonatomic, retain) RenrenAccountDetailsViewController* viewController;

@property (nonatomic, retain) id getUserInfoDelegate;

- (MyRenrenLoginDelegate*) initWithViewController: (RenrenAccountDetailsViewController *) viewController;

@end
