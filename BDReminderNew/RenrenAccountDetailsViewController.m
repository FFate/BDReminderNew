//
//  RenrenAccountDetailsViewController.m
//  BDReminderNew
//
//  Created by qinsoon on 28/09/12.
//  Copyright (c) 2012 qinsoon. All rights reserved.
//

#import "RenrenAccountDetailsViewController.h"

@interface RenrenAccountDetailsViewController ()

@end

@implementation RenrenAccountDetailsViewController
@synthesize accountStatusLabel;
@synthesize loginDelegate;
@synthesize userInfoDelegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
    }
    return self;
}

// this initMethod will get called by
// [UIStoryboard instantiateViewControllerWithIdentifier]
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    [self initDelegatesChecklist];
    return self;
}

- (void) initDelegatesChecklist {
    loginDelegate = [[MyRenrenLoginDelegate alloc]initWithViewController:self];
    userInfoDelegate = [[MyRenrenGetUserInfoDelegate alloc]initWithViewController:self];
}

// override
- (void) updateAccountStatus: (Account*) account {
    self.accountStatusLabel.text = [AccountsViewController accountStatusText:account.accountStatus];
}

// override
- (IBAction) userLogin: (id)sender {
    if (![[Renren sharedRenren] isSessionValid]) {
        // no valid session, log in then
        [[Renren sharedRenren] authorizationWithPermisson:nil andDelegate:loginDelegate];
    } else {
        [[Renren sharedRenren] logout:loginDelegate];
    }
}

// override
- (IBAction)updateUserInfo:(id)sender {
    [self requestRenrenAccountInfo];
}

- (void) requestRenrenAccountInfo{
    // sending request
    ROUserInfoRequestParam* params = [[ROUserInfoRequestParam alloc] init];
    [[Renren sharedRenren] getUsersInfo:params andDelegate:userInfoDelegate];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setAccountStatusLabel:nil];
    [super viewDidUnload];
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return 1;
    } else if (section == 1) {
        return 3;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

@end
