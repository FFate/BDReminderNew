//
//  ContactsViewController.m
//  BDReminderNew
//
//  Created by Wang Tian on 12-8-27.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "ContactsViewController.h"
#import "LinkedContact.h"
#import "Contact.h"
#import "ContactCell.h"
#import "DejalActivityView.h"

#define ENABLE_DELETE_CONTACT YES

@interface ContactsViewController ()

@end

@implementation ContactsViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.contacts = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.contacts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"ContactCell";
    ContactCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    LinkedContact *linkedContact = [self.contacts objectAtIndex:indexPath.row];
    cell.nameLabel.text = linkedContact.name;
    cell.birthdayLabel.text = [Util stringFromNSDate:linkedContact.birthday];
    cell.personalImage.image = linkedContact.head;
    // Configure the cell...
    [cell showAccountSiteIcons:linkedContact];
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return ENABLE_DELETE_CONTACT;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //Contact* delete = [self.contacts objectAtIndex:indexPath.row];
        LinkedContact* delete = [self.contacts objectAtIndex:indexPath.row];
        
        [self removeLinkedContact:delete];
        
        // Delete from the array
        // [self.contacts removeObject:delete];
        
        // Delete from persistent store
        // [[AppDelegate delegate].managedObjectContext deleteObject:delete];
        
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    /*else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    } */
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

// current strategy: delete all contacts in this linkedContact
// alternative strategy: just remove linkage
- (void) removeLinkedContact: (LinkedContact*) linkedContact {
    // remove contacts in linkedContact
    for (Contact* contact in linkedContact.contact) {
        [[Contact contactList] removeObject:contact];
        [[AppDelegate delegate].managedObjectContext deleteObject:contact];
    }
    
    // remove linkedContact
    [[LinkedContact linkedContactList] removeObject:linkedContact];
    [[AppDelegate delegate].managedObjectContext deleteObject:linkedContact];
}

// merge newContacts array with the global contact array
- (void) mergeContactsAndUpdateView: (NSMutableArray*) newContacts {
    NSMutableArray* tempContactArray = [NSMutableArray array];
    
    // move non-duplicate contacts from old array to tempContactArray
    // (doing this to avoid mutation while enumeration)
    for (Contact* oldContact in [Contact contactList]) {
        BOOL duplicate = NO;
        for (Contact* newContact in newContacts) {
            if ([newContact myIsEqual:oldContact]) {
                duplicate = YES;
                break;
            }
        }
        
        // if this contact also appears in newContacts, we do nothing
        // (let the new one update the old one)
        if (duplicate)
            continue;
        // otherwise we have to keep the old contact
        else [tempContactArray addObject:oldContact];
    }
    
    // remove old contacts array
    for (Contact* persistentContact in [Contact contactList]) {
        if (![tempContactArray containsObject:persistentContact])
            [[AppDelegate delegate].managedObjectContext deleteObject:persistentContact];
    }
    [Contact setContactList:nil];
    self.contacts = nil;
    
    // add newContacts to tempContactArray
    [tempContactArray addObjectsFromArray:newContacts];
    
    // update self.contacts to tempContactArray
    [Contact setContactList:tempContactArray];
    [LinkedContact linkContactsFrom:self.contacts to:[LinkedContact linkedContactList]];
    self.contacts = [LinkedContact linkedContactList];
    
    // force ContactsViewController reloadData
    [self.tableView reloadData];
}

@end
