//
//  ContactsViewController.h
//  BDReminderNew
//
//  Created by Wang Tian on 12-8-27.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContactsViewController : UITableViewController{
    //NSMutableArray *contactsArray;
}

@property (nonatomic, strong) NSMutableArray *contacts;

- (void) mergeContactsAndUpdateView: (NSMutableArray*) newContacts;

@end
