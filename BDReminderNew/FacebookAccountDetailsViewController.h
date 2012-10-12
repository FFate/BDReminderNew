//
//  FacebookAccountDetailsViewController.h
//  BDReminderNew
//
//  Created by Wang Tian on 12-10-12.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "NewAccountDetailsViewController.h"
#import "MyFacebookLoginDelegate.h"

@class MyFacebookLoginDelegate;

@interface FacebookAccountDetailsViewController : NewAccountDetailsViewController

@property (nonatomic, retain) MyFacebookLoginDelegate* loginDelegate;

@end
