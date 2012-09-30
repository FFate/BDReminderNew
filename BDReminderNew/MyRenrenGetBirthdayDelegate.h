//
//  MyRenrenGetBirthdayDelegate.h
//  BDReminderNew
//
//  Created by qinsoon on 30/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyRenrenGetBirthdayDelegate : NSObject <RenrenDelegate>

@property (nonatomic, retain) NSMutableArray* friends;

- (id) initWithFriendsList: (NSMutableArray*) aFriendsList;

@end
