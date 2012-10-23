//
//  AppDelegate.h
//  BDReminderNew
//
//  Created by qinsoon on 27/08/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

#define mustOverride() @throw [NSException exceptionWithName:NSInvalidArgumentException reason:[NSString stringWithFormat:@"%s must be overridden in a subclass/category", __PRETTY_FUNCTION__] userInfo:nil]

#define methodNotImplemented() mustOverride()

#define methodNotImplementedSoftWarning() NSLog(@"%s must be implemented, otherwise it may function inproperly", __PRETTY_FUNCTION__)

#define PERSISTENT_STORE_FILE @"appData1023.sqlite"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSManagedObjectContext *managedObjectContext_;
    NSManagedObjectModel *managedObjectModel_;
    NSPersistentStoreCoordinator *persistentStoreCoordinator_;
}

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
- (NSURL *)applicationDocumentsDirectory;
- (void)saveContext;

//- (NSMutableArray*) accountsList;

+ (AppDelegate*) delegate;

+ (void) NSLogAllLinkedContacts;

@end
