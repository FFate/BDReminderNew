//
//  AppDelegate.m
//  BDReminderNew
//
//  Created by qinsoon on 27/08/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "AppDelegate.h"
#import "Contact.h"
#import "ContactsViewController.h"

@implementation AppDelegate {
    NSMutableArray *contacts;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    contacts = [NSMutableArray arrayWithCapacity:20];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:10];
    [comps setMonth:2];
    [comps setYear:1987];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDate *date = [gregorian dateFromComponents:comps];
    Contact *contact = [[Contact alloc] init];
    contact.name = @"Qinsoon";
    contact.birthday = date;
    
    [contacts addObject:contact];
    
    contact = [[Contact alloc] init];
    contact.name = @"FFate";
    contact.birthday = date;
    
    [contacts addObject:contact];
        
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    ContactsViewController *contactsViewController =
    [[navigationController viewControllers] objectAtIndex:0];
    contactsViewController.contacts = contacts;
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
