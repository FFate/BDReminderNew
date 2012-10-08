//
//  MSFTestAppDelegate.m
//  MSFTest
//
//  Created by chen qi on 11-5-24.
//  Copyright 2011 tencent. All rights reserved.
//

#import "OpenSdkTestAppDelegate.h"
#import "OpenSdkTestViewController.h"
#import "FeatureListViewController.h"
#import "OpenSdkOauth.h"

@implementation OpenSdkTestAppDelegate

@synthesize window;
@synthesize viewController;
@synthesize navigationController;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
	featureListViewController = [[FeatureListViewController alloc] initWithStyle:UITableViewStyleGrouped];
	
	self.navigationController = [[UINavigationController alloc] initWithRootViewController:featureListViewController];
	self.window.rootViewController = self.navigationController;
    [self.window makeKeyAndVisible];

    return YES;
}

/*- (BOOL)application:(UIApplication *)applicatin openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
 {
     //_alertView = [[UIAlertView alloc] init];
     //[_alertView ];
     NSLog(@"redirect url %@", url);
     // If the URL's structure doesn't match the structure used for Tencent authorization, abort.
     if (![[url absoluteString] hasPrefix:openSdkOauth.redirectURI]) {
         return NO;
     }
 
     NSString *query = [url fragment];
 
     // Version 3.2.3 encodes the parameters in the query but
     // version 3.3 and above encode the parameters in the fragment. To support
     // both versions, we try to parse the query if
     // the fragment is missing.
     if (!query) {
         query = [url query];
     }
 
    // NSDictionary *params = [self parseURLParams:query];
     //NSString *accessToken = [params valueForKey:@"access_token"];
 
     // If the URL doesn't contain the access token, an error has occurred.
     if (!accessToken) {
         NSString *errorReason = [params valueForKey:@"error"];
 
         // If the error response indicates that we should try again using Safari, open
         // the authorization dialog in Safari.
         if (errorReason && [errorReason isEqualToString:@"service_disabled_use_browser"]) {
             [self authorizeWithTencentAppAuthInSafari:YES];
             return YES;
         }
 
         // If the error response indicates that we should try the authorization flow
         // in an inline dialog, do that.
         if (errorReason && [errorReason isEqualToString:@"service_disabled"]) {
             [self authorizeWithTencentAppAuthInSafari:NO];
             return YES;
         }
 
         NSString *errorCode = [params valueForKey:@"error_code"];
 
         BOOL userDidCancel =
         !errorCode && (!errorReason || [errorReason isEqualToString:@"access_denied"]);
            [self tencentDialogNotLogin:userDidCancel];
         return YES;
     }
 
     // We have an access token, so parse the expiration date.
    NSString *expTime = [params valueForKey:@"expires_in"];
     NSDate *expirationDate = [NSDate distantFuture];
    if (expTime != nil) {
        int expVal = [expTime intValue];
        if (expVal != 0) {
            expirationDate = [NSDate dateWithTimeIntervalSinceNow:expVal];
        }
    }
 
     [self tencentDialogLogin:accessToken expirationDate:expirationDate];
     return YES;
 }*/

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
	[featureListViewController release];
    [viewController release];
    [window release];
    [super dealloc];
}


@end
