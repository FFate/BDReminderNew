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
#import "QWeiboAccount.h"
#import "LinkedContact.h"

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
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:PERSISTENT_STORE_FILE];
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
    
    QWeiboAccount *qweiboAccount = [[QWeiboAccount alloc] init];
    [accountsList addObject:qweiboAccount];
    
    return accountsList;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
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
    
    // fetch Contact
    NSMutableArray* contacts = [self fetchEntityFromPersistentStoreWithEntityName:@"Contact"];
    // fetch Account
    NSMutableArray* accounts = [self fetchEntityFromPersistentStoreWithEntityName:@"Account"];
    if (accounts == nil || [accounts count] == 0) {
        NSLog(@"Failed to fetch accounts from persistent store. Will create account list");
        accounts = [self buildAccountsList];
    }
    // fetch LinkedContact
    NSMutableArray* linkedContacts = [self fetchEntityFromPersistentStoreWithEntityName:@"LinkedContact"];
    if (linkedContacts == nil || [linkedContacts count] == 0) {
        NSLog(@"No linked contacts exist, will automatically link contacts");
        [LinkedContact linkContactsFrom: contacts to: linkedContacts];
    }
    
    // set contacts and accounts
    [Account setAccountList:accounts];
    [Contact setContactList:contacts];
    [LinkedContact setLinkedContactList:linkedContacts];
    
    [AppDelegate NSLogAllLinkedContacts];
        
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    ContactsViewController *contactsViewController =
    [[navigationController viewControllers] objectAtIndex:0];
    //contactsViewController.contacts = contacts;
    contactsViewController.contacts = linkedContacts;
    
    return YES;
}

- (NSMutableArray*) fetchEntityFromPersistentStoreWithEntityName: (NSString*) entityName {
    NSMutableArray* returnArray = [NSMutableArray array];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:entityName inManagedObjectContext:[self managedObjectContext]];
    if (entity == nil) {
        NSLog(@"%@ entity is nil, something wrong!", entityName);
        abort();
    }
    [request setEntity:entity];
    
    NSError *error = nil;
    returnArray = [[[self managedObjectContext] executeFetchRequest:request error:&error] mutableCopy];
    
    if (error != nil ) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    if (returnArray == nil) {
        NSLog(@"Failed to fetch %@ from persistent store", entityName);
        abort();
    }
    
    return returnArray;
}

+ (void) NSLogAllLinkedContacts {
    NSLog(@"Output all linked contacts");
    // test use
    NSMutableString* msg = [[NSMutableString alloc] initWithString:@"\n"];
    for (LinkedContact* link in [LinkedContact linkedContactList]) {
        [msg appendFormat:@"Name: %@, site: ", link.name];
        for (Contact* contact in link.contact) {
            [msg appendFormat:@"%@,", [contact.account accountSiteName]];
        }
        [msg appendFormat:@"\n"];
    }
    NSLog(msg);
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
