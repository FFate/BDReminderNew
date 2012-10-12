//
//  FacebookAccountDetailsViewController.h
//  BDReminderNew
//
//  Created by Wang Tian on 12-10-2.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewAccountDetailsViewController.h"
#import "AccountDetailsViewController.h"
#import "FacebookAccountDetailsViewController.h"
#import "MyFacebookLoginDelegate.h"

@class MyFacebookLoginDelegate;


@interface FacebookAccountDetailsViewController : NewAccountDetailsViewController



@property (nonatomic,retain) MyFacebookLoginDelegate *loginDelegate;


@end
