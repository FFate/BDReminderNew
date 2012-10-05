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
#import "Account.h"
#import "AccountsViewController.h"
#import "RenrenAccount.h"
#import "FacebookAccount.h"

@implementation AppDelegate {

}

+ (AppDelegate*) delegate {
    return (AppDelegate *) [[UIApplication sharedApplication] delegate];
}

- (NSManagedObjectModel *) managedObjectModel {
    if (managedObjectModel_ != nil) {
        return managedObjectModel_;
    }
    
    // load model from URL
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"Model" withExtension:@"momd"];
    managedObjectModel_ = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
    return managedObjectModel_;
}

- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext_ != nil) {
        return managedObjectContext_;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        managedObjectContext_ = [[NSManagedObjectContext alloc] init];
        [managedObjectContext_ setPersistentStoreCoordinator:coordinator];
    }
    return managedObjectContext_;
}

- (NSPersistentStoreCoordinator *) persistentStoreCoordinator {
    if (persistentStoreCoordinator_ != nil) {
        return persistentStoreCoordinator_;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"appData1005.sqlite"];
    NSLog(@"db: %@", [storeURL absoluteURL]);
    NSError *error = nil;
    persistentStoreCoordinator_ = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator_ addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        NSLog(@"Couldnt open persistentStore, ignore this");
        //abort();
    }
    
    return persistentStoreCoordinator_;
}

- (NSURL *) applicationDocumentsDirectory {
    //return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask] lastObject];
    
    NSString *LOG_DIRECTORY = @"BDReminder";
    static NSURL *ald = nil;
    
    if (ald == nil) {
        
        NSFileManager *fileManager = [[NSFileManager alloc] init];
        NSError *error;
        NSURL *libraryURL = [fileManager URLForDirectory:NSLibraryDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:&error];
        if (libraryURL == nil) {
            NSLog(@"Could not access Library directory\n%@", [error localizedDescription]);
        }
        else {
            ald = [libraryURL URLByAppendingPathComponent:@"Logs"];
            ald = [ald URLByAppendingPathComponent:LOG_DIRECTORY];
            NSDictionary *properties = [ald resourceValuesForKeys:@[NSURLIsDirectoryKey]
                                                            error:&error];
            if (properties == nil) {
                if (![fileManager createDirectoryAtURL:ald withIntermediateDirectories:YES attributes:nil error:&error]) {
                    NSLog(@"Could not create directory %@\n%@", [ald path], [error localizedDescription]);
                    ald = nil;
                }
            }
        }
    }
    return ald;
}

- (void) saveContext {
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    if (managedObjectContext != nil) {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (NSMutableArray*) buildAccountsList {
    NSMutableArray* accountsList = [[NSMutableArray alloc] initWithCapacity:20];
    
    RenrenAccount *renrenAccount = [[RenrenAccount alloc] init];
    [accountsList  addObject:renrenAccount];
    
    FacebookAccount *facebookAccount = [[FacebookAccount alloc] init];
    [accountsList addObject:facebookAccount];
    
    return accountsList;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //BOOL createContactsOnLoad = NO;
    BOOL RESET_PERSISTENT_STORE = NO;
    
    if (RESET_PERSISTENT_STORE) {
        NSError * error;
        // retrieve the store URL
        NSURL * storeURL = [[self.managedObjectContext persistentStoreCoordinator] URLForPersistentStore:[[[self.managedObjectContext persistentStoreCoordinator] persistentStores] lastObject]];
        // lock the current context
        [self.managedObjectContext lock];
        [self.managedObjectContext reset];//to drop pending changes
        //delete the store from the current managedObjectContext
        if ([[self.managedObjectContext persistentStoreCoordinator] removePersistentStore:[[[self.managedObjectContext persistentStoreCoordinator] persistentStores] lastObject] error:&error])
        {
            // remove the file containing the data
            [[NSFileManager defaultManager] removeItemAtURL:storeURL error:&error];
            //recreate the store like in the  appDelegate method
            [[self.managedObjectContext persistentStoreCoordinator] addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error];//recreates the persistent store
        }
        [self.managedObjectContext unlock];
        //that's it !
    }
    
    /*if (createContactsOnLoad) {
        // create contacts when application is loaded
        contacts = [NSMutableArray arrayWithCapacity:20];
        
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:10];
        [comps setMonth:2];
        [comps setYear:1987];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSDate *date = [gregorian dateFromComponents:comps];
        Contact *contact = [[Contact alloc] initWithName: @"Qinsoon" birthday: date];
        
        [contacts addObject:contact];
        
        contact = [[Contact alloc] initWithName:@"FFate" birthday:date];
        
        [contacts addObject:contact];
    } else {*/
    
    // fetch Contact from persistence store
    
    NSMutableArray* contacts;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Contact" inManagedObjectContext:[self managedObjectContext]];
    if (entity == nil) {
        NSLog(@"Contact entity is nil, something wrong!");
        abort();
    }
    [request setEntity:entity];
    
    NSError *error = nil;
    contacts = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    
    if (error != nil ) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }        
    
    if (contacts == nil) {
        NSLog(@"Failed to fetch contacts from persistent store");
        abort();
    }
    
    // fetch accounts from persistence store
    
    NSMutableArray* accounts;
    
    request = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"Account" inManagedObjectContext:[self managedObjectContext]];
    if (entity == nil) {
        NSLog(@"Account entity is nil, something wrong!");
        abort();
    }
    [request setEntity:entity];
    
    error = nil;
    accounts = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    
    if (error != nil ) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    if (accounts == nil || [accounts count] == 0) {
        NSLog(@"Failed to fetch accounts from persistent store");
        accounts = [self buildAccountsList];
    }
    
    // set contacts and accounts
    [Account setAccountList:accounts];
    [Contact setContactList:contacts];
        
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
    [self saveContext];
    NSLog(@"Context saved...");
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
    [self saveContext];
    NSLog(@"Context saved...");
}

@end
