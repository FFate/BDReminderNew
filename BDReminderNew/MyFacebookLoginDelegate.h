//
//  MyFacebookLoginDelegate.h
//  BDReminderNew
//
//  Created by Wang Tian on 12-10-2.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FacebookAccountDetailsViewController.h"

extern NSString *const SCSessionStateChangedNotification;

@class FacebookAccountDetailsViewController;

@interface MyFacebookLoginDelegate : NSObject
@property (nonatomic, retain) FacebookAccountDetailsViewController* viewController;
@property (strong, nonatomic) FBSession *session;

- (MyFacebookLoginDelegate*) initWithViewController: (FacebookAccountDetailsViewController *) viewController;

- (void) openSession;
- (void) closeSession;

@end
