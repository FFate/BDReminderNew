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
@synthesize session = _session;

/*- (void)sessionStateChanged:(FBSession *)session
                      state:(FBSessionState)state
                      error:(NSError *)error
{
    // FBSample logic
    // Any time the session is closed, we want to display the login controller (the user
    // cannot use the application unless they are logged in to Facebook). When the session
    // is opened successfully, hide the login controller and show the main UI.
    switch (state){

        case FBSessionStateOpen:{
            //account.accountStatus = ACCOUNT_VALID;
            
            // FBSample logic
            // Pre-fetch and cache the friends for the friend picker as soon as possible to improve
            // responsiveness when the user tags their friends.
            [_viewController.loginButton setTitle:@"Log out" forState:UIControlStateNormal];
            _viewController.accountStatusLabel.text = @"111";
            NSLog(@"logged in");
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
}*/

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // FBSample logic
    // We need to handle URLs by passing them to FBSession in order for SSO authentication
    // to work.
    return [FBSession.activeSession handleOpenURL:url];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // FBSample logic
    // if the app is going away, we close the session object; this is a good idea because
    // things may be hanging off the session, that need releasing (completion block, etc.) and
    // other components in the app may be awaiting close notification in order to do cleanup
    [FBSession.activeSession close];
}

- (void)applicationDidBecomeActive:(UIApplication *)application	{
    // this means the user switched back to this app without completing a login in Safari/Facebook App
    if (FBSession.activeSession.state == FBSessionStateCreatedOpening) {
        // BUG: for the iOS 6 preview we comment this line out to compensate for a race-condition in our
        // state transition handling for integrated Facebook Login; production code should close a
        // session in the opening state on transition back to the application; this line will again be
        // active in the next production rev
        //[FBSession.activeSession close]; // so we close our session and start over
    }
}


- (MyFacebookLoginDelegate*) initWithViewController: (FacebookAccountDetailsViewController *) sourceViewController {
    self = [super init];
    self.viewController = sourceViewController;
    return self;
}

@end
