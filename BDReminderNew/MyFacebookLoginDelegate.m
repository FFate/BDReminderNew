//
//  MyFacebookLoginDelegate.m
//  BDReminderNew
//
//  Created by Wang Tian on 12-10-2.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "MyFacebookLoginDelegate.h"
#import <FacebookSDK/FacebookSDK.h>
#import "FacebookAccountDetailsViewController.h"

NSString *const SCSessionStateChangedNotification = @"com.qinsoon.BDReminder:SCSessionStateChangedNotification";

@interface MyFacebookLoginDelegate ()


@end


@implementation MyFacebookLoginDelegate

@synthesize viewController = _viewController;

- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState)state
                      error:(NSError *)error
{
    // FBSample logic
    // Any time the session is closed, we want to display the login controller (the user
    // cannot use the application unless they are logged in to Facebook). When the session
    // is opened successfully, hide the login controller and show the main UI.
    switch (state){

        case FBSessionStateOpen:{
            Account* account = (Account*)[[Account accountList] objectAtIndex:_viewController.accountIndex];
            //account.accountStatus = ACCOUNT_VALID;
            
            // FBSample logic
            // Pre-fetch and cache the friends for the friend picker as soon as possible to improve
            // responsiveness when the user tags their friends.
            
            FBCacheDescriptor *cacheDescriptor = [FBFriendPickerViewController cacheDescriptor];
            [cacheDescriptor prefetchAndCacheForSession:session];
        }
            break;
        case FBSessionStateClosed:
        case FBSessionStateClosedLoginFailed:{
            
        }
            break;
        default:
            break;
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:SCSessionStateChangedNotification
                                                        object:session];
    
    if (error) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:error.localizedDescription
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
    }

}

- (BOOL)openSessionWithAllowLoginUI:(BOOL)allowLoginUI {
    NSArray *permissions = [NSArray arrayWithObjects:@"publish_actions", @"user_photos", nil];
    return [FBSession openActiveSessionWithPermissions:permissions
                                          allowLoginUI:allowLoginUI
                                     completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                         [self sessionStateChanged:session state:state error:error];
                                     }];
}


- (MyFacebookLoginDelegate*) initWithViewController: (FacebookAccountDetailsViewController *) sourceViewController {
    self = [super init];
    self.viewController = sourceViewController;
    return self;
}

@end
