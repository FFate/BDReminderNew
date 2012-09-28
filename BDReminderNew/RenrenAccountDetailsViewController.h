//
//  RenrenAccountDetailsViewController.h
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AccountDetailsViewController.h"
#import "MyRenrenLoginDelegate.h"
#import "MyRenrenGetUserInfoDelegate.h"

@class MyRenrenLoginDelegate;
@class MyRenrenGetUserInfoDelegate;

@interface RenrenAccountDetailsViewController : AccountDetailsViewController

@property (weak, nonatomic) IBOutlet UILabel *accountStatusLabel;

@property (nonatomic, retain) MyRenrenLoginDelegate* loginDelegate;
@property (nonatomic, retain) MyRenrenGetUserInfoDelegate* userInfoDelegate;

@end
