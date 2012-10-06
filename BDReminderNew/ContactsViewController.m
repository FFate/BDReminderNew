//
//  ContactsViewController.m
//  BDReminderNew
//
//  Created by Wang Tian on 12-8-27.
//  Copyright (c) 2012年 qinsoon. All rights reserved.
//

#import "ContactsViewController.h"
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
    
    DejalBezelActivityView* loadingView = (DejalBezelActivityView*)[DejalBezelActivityView activityViewForView:self.view withLabel:@"Loading Contacts... (test use)"];
    
    [loadingView performSelector:@selector(animateRemove) withObject:nil afterDelay:1];
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
    
    Contact *contact = [self.contacts objectAtIndex:indexPath.row];
    cell.nameLabel.text = contact.name;
    cell.birthdayLabel.text = [contact getBirthdayString];
    cell.personalImage.image = contact.head;
    // Configure the cell...
    
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
        Contact* delete = [self.contacts objectAtIndex:indexPath.row];
        
        // Delete from the array
        [self.contacts removeObject:delete];
        
        // Delete from persistent store
        [[AppDelegate delegate].managedObjectContext deleteObject:delete];
        
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

// merge newContacts array with the global contact array
// do not add duplicated contact (same name and same BD)
- (void) mergeContactsAndUpdateView: (NSMutableArray*) newContacts {
    // should check duplicate here
    [self.contacts addObjectsFromArray:newContacts];    
    
    // force ContactsViewController reloadData
    [self.tableView reloadData];
}

@end
